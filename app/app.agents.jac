# Agents

# Initialize Memory for a new user
walker initialize_memory {
    has email: str = "";
    has full_name: str= "";

    can initialize_memory with `root entry {
        new_memory = here ++> Memory(email=self.email, full_name=self.full_name);
        report {"status": "Success", "message": "Memory initialized", "body": new_memory};
    }
}

# Create a new Resume node
walker create_resume_node {
    can create_resume_node with `root entry {
        new_resume = here ++> Resume();
        report {"status": "Success", "message": "Resume node created", "body": new_resume};
    }
}

# Save CV contents to Resume node as bytes
walker upload_resume {
    has file: bytes = b"";      # Base64 string from frontend
    has name: str = "";
    has mime: str = "";

    can visit_resume with `root entry {
        print("Visiting Resume Node");
        visit [-->(`?Resume)];
    }

    can upload_resume with Resume entry {

        here.name = self.name;
        here.mime = self.mime;

        try {
            let decoded_bytes = base64.b64decode(self.file);
            here.content = decoded_bytes;
        }
        except Exception as e {
            print(f"Base64 decode error: {e}");
            report {"status": "Fail", "message": "Failed to decode resume file", "body": {}};
            disengage;
        }

        print(f"File bytes saved, size = {len(here.content)} bytes");

        report {
            "status": "Success",
            "message": "Resume uploaded",
            "body": {
                "name": here.name,
                "mime": here.mime,
                "size_bytes": len(here.content)
            }
        };
    }
}

# Update resume upload status in memory
walker update_resume_upload_status {
    can check_memory with `root entry {
        visit [-->(`?Memory)];
    }

    can update_resume_upload_status with Memory entry {
        here.resume_uploaded = True;
        report {"status": "Success", "message": "Resume upload status updated", "body": here.resume_uploaded};
    }
}


# Check if CV is uploaded or not
walker check_resume_upload_status {
    can check_memory with `root entry {
        visit [-->(`?Memory)];
    }

    can check_resume_upload_status with Memory entry {
        report {"status": "Success", "message": "", "body": here.resume_uploaded};
    }
}


# Save CV to disk
walker save_resume {

    can visit_resume with `root entry {
        visit [-->(`?Resume)];
    }

    can save_resume with Resume entry {

        if not here.content {
            print("No resume content found");
            report {
                "status": "Fail",
                "message": "No resume content to save",
                "body": {}
            };
            disengage;
        }

        print("Saving resume file to disk...");

        let dir = "./resumes";
        if not os.path.exists(dir) {
            os.makedirs(dir);
        }

        # Original file path
        let base_name = here.name;
        let path = f"{dir}/{base_name}";

        # Handle duplicate filenames
        if (os.path.exists(path)) {
            let parts = base_name.rsplit(".", 1);

            if (len(parts) == 2) {
                let filename = parts[0];
                let ext = parts[1];
                let counter = 1;

                while (True) {
                    let new_name = f"{filename}({counter}).{ext}";
                    let new_path = f"{dir}/{new_name}";

                    if not os.path.exists(new_path) {
                        path = new_path;
                        break;
                    }

                    counter = counter + 1;
                }

            } else {
                # No extension
                let filename = base_name;
                let counter = 1;

                while (True) {
                    let new_name = f"{filename}({counter})";
                    let new_path = f"{dir}/{new_name}";

                    if not os.path.exists(new_path) {
                        path = new_path;
                        break;
                    }

                    counter = counter + 1;
                }
            }
        }

        # Save file bytes
        try {
            with open(path, "wb") as f {
                f.write(here.content);
            }
        }
        except Exception as e {
            print(f"Error writing file: {e}");
            report {
                "status": "Fail",
                "message": "Error saving resume to disk",
                "body": {}
            };
            disengage;
        }

        # Ensure file_path exists on Resume node
        here.file_path = path;

        print(f"File saved at: {path}");
        report {
            "status": "Success",
            "message": "Resume saved to disk",
            "body": {
                "file_path": here.file_path
            }
        };
    }
}

# analyze CV and report findings to FE
walker analyze_cv {
    has user_profile: UserProfile = UserProfile([], [], []);

    """
    You are an AI that extracts structured information ONLY from real CV/resume text.

    ### TASK
    Given a block of text, determine whether it represents a CV/resume using common CV structure and words such as Experience, Skills, Referees, Education. 
    Do not analyze anything that does not look like a CV. Return None if it is not a CV.  If it is a CV, extract:

    - skills: list of Skill objects (Skill{name, description})
    - certifications: list of Certification objects (Certification{title, provider, url})
    - interests: list of Interest objects (Interest{name, description})

    Return a populated UserProfile.

    If the text is NOT a CV/resume, return None.

    If the document is not a CV → return None.


    ### IMPORTANT
    The output MUST be a well-structured UserProfile object with lists of Skill, Certification, and Interest objects.
    No missing fields. No hallucination. Use only the information present in the text.
    """
    def extract_user_skills_from_cv(resume_text: str) -> UserProfile | None by llm(method="Reason");

    can visit_resume with `root entry {
        visit [-->(`?Resume)] else {
            report {
                "status": "Fail",
                "message": "No Resume node found",
                "body": {}
            };
            disengage;
        }
    }

    can extract_user_skills with Resume entry {

        # Edge Case Checks
        if not here.file_path {
            report {
                "status": "Fail",
                "message": "No resume file path found",
                "body": {}
            };
            disengage;
        }

        if not os.path.exists(here.file_path) {
            report {
                "status": "Fail",
                "message": "Resume file does not exist on disk",
                "body": {}
            };
            disengage;
        }

        # Extract Text
        let text = read_document_text(here.file_path);

        if not text {
            report {
                "status": "Fail",
                "message": "Unable to extract text from resume",
                "body": {}
            };
            disengage;
        }

        # LLM Extraction
        try {
            self.user_profile = self.extract_user_skills_from_cv(text);
        } except Exception as err {
            report {
                "status": "Fail",
                "message": {err},
                "body": {}
            };
            disengage;
        }
        # create User graph
        print("Saving User Profile to Memory...\n");
        root spawn create_user_graph(user_profile=self.user_profile);
        


        # Final Report
        report {
            "status": "Success",
            "message": "Resume processed successfully",
            "body": {
                "skills": [s.name for s in self.user_profile.skills],
                "certifications": [
                    {"title": c.title, "provider": c.provider, "url": c.url} 
                    for c in self.user_profile.certifications
                    ],
                    "interests": [
                        {"name": i.name, "description": i.description}
                        for i in self.user_profile.interests
                    ]
                }
            };
        }
}


# extract full names and email
walker get_user_details {

    can visit_memory with `root entry {
        visit [-->(`?Memory)] else {
            report {
                "status": "Fail",
                "message": "No user found",
                "body": {}
            };
            disengage;
        }
    }

    can get_user_details with Memory entry {

        # Edge Case Checks

        if here.full_name == None or here.email == None {
            report {
                "status": "Fail",
                "message": "User details missing in memory",
                "body": {}
            };
            disengage;
        }

        let name_clean = here.full_name.strip() if here.full_name else "";
        let email_clean = here.email.strip() if here.email else "";

        if name_clean == "" and email_clean == "" {
            report {
                "status": "Fail",
                "message": "No user details found",
                "body": {}
            };
            disengage;
        }

        # Final Success Report

        report {
            "status": "Success",
            "message": "User details fetched successfully",
            "body": {
                "full_name": name_clean,
                "email": email_clean
            }
        };
    }
}


# create and store user profile
walker create_user_graph {
    has user_profile: UserProfile = UserProfile([], [], []);

    can visit_memory with `root entry {
        print("Checking User Memory...");
        visit [-->(`?Memory)] else {
            report {"status": "Fail", "message": "User memory not initialized", "body": {}};
            disengage;
        }
    }

    can create_user_graph with Memory entry {
        print(f"Found user: {here.resume_uploaded}");
        end_node = End();

        for skill in self.user_profile.skills {

            # Check if Skill exists
            if [-->(`?Skill)](?name == skill.name) { 
                print(f"Skipping duplicate skill: {skill.name}"); 
                continue;
            }
            here +>:skilled_in:+> skill ++> end_node;
        }

        for cert in self.user_profile.certifications {

            # Check if Certification exists
            if [-->(`?Certification)](?title == cert.title) {
                continue;
            }
            here +>:has_certification:+> cert ++> end_node;
        }

        for interest in self.user_profile.interests {

            # Check if Interest exists
            if [-->(`?Interest)](?name == interest.name) {

                continue;
            }
            here +>:interested_in:+> interest ++> end_node;
        }

        report {
            "status": "Success",
            "message": "Resume analyzed successfully",
            "body": {
                "skills": [s.name for s in self.user_profile.skills],
                "certifications": [c.title for c in self.user_profile.certifications],
                "interests": [i.name for i in self.user_profile.interests]
            }
        };
    }
}


# Suggest roles based on user profile
walker generate_role_suggestions {
    has user_profile: UserProfile = UserProfile([], [], []);

    """
    Analyze the user’s skills, interests, and certifications. Suggest top 3 realistic career roles that match their strengths.
    Each role must include a short title and a concise description explaining why the user is a good fit.
    Avoid generic suggestions and prioritize roles where the user's skill combination provides a clear advantage.
    """

    def suggest_roles_based_on_profile(user_profile: UserProfile) -> list[Role] by llm(method="Reason");

    # Fetch Profile 
    can fetch_user_profile with `root entry {
        print("Fetching user profile for role suggestion...\n");

        let fetched_profile = root spawn get_user_profile();
        
        # cease operation if user profile is not fetched
        if fetched_profile == None or fetched_profile.user_profile == None {
            print("ERROR: Failed to fetch user profile.\n");
            report {
                "status": "Fail",
                "message": "Unable to load user profile.",
                "body": []
            };
            disengage;
        }

        self.user_profile = fetched_profile.user_profile;

        print("Fetched user profile:\n");
        print(self.user_profile);
        print("\n");
    }

    # Suggest Roles
    can suggest_roles with `root entry {
        print("Using LLM to suggest roles based on user profile...\n");

        # Edge case: empty or weak profile
        if len(self.user_profile.skills) == 0
           and len(self.user_profile.interests) == 0
           and len(self.user_profile.certifications) == 0 {

            print("WARNING: User profile is empty. LLM suggestions may be inaccurate.\n");
        }

        let suggested_roles = self.suggest_roles_based_on_profile(self.user_profile);

        # LLM returned nothing
        if suggested_roles == None {
            print("ERROR: LLM returned no roles.\n");
            report {
                "status": "Error",
                "message": "LLM failed to generate any role suggestions.",
                "body": []
            };
            disengage;
        }

        # LLM returned empty list
        if len(suggested_roles) == 0 {
            print("No roles returned by LLM.\n");
            report {
                "status": "Empty",
                "message": "No roles could be suggested for the provided profile.",
                "body": []
            };
            disengage;
        }

        print("Suggested Roles:\n");

        let valid_roles = [];

        # Validate each LLM-generated role object
        for role in suggested_roles {
            if role == None
               or role.title == None
               or role.description == None {

                print("Skipping malformed role suggestion returned by LLM.\n");
                continue;
            }

            print(f"- {role.title}: {role.description}\n");
            valid_roles += [role];
        }

        # All roles were invalid
        if len(valid_roles) == 0 {
            print("ERROR: All LLM suggestions were malformed.\n");
            report {
                "status": "Fail",
                "message": "LLM returned invalid role objects.",
                "body": []
            };
            disengage;
        }

        # Final response
        report {
            "status": "Success",
            "message": "Roles suggested successfully",
            "body": [
                {
                    "title": role.title,
                    "description": role.description
                }
                for role in valid_roles
            ]
        };
    }
}


# Retrieve user profile
walker get_user_profile {
    has user_profile: UserProfile = UserProfile([], [], []);

    can visit_memory with `root entry {

        print("get_user_profile walker visiting memory..\n");
        visit [-->(`?Memory)] else {
            report {
                "status": "Fail",
                "message": "User memory not initialized",
                "body": {}
            };
            disengage;
        }
    }

    can visit_skills with Memory entry {
        print("get_user_profile walker visiting skills..\n");
        visit [-->(`?Skill)] else {
            print("No Skills found");
            report {
                "status": "Fail",
                "message": "No Skills found",
                "body": {}
            };
        }
    }

    can add_skill with Skill entry {
        print("get_user_profile adding skills..\n");
        self.user_profile.skills.append(here);
        visit [-->(`?End)] else {
            print("No End node...creating one..\n");
            end_node = End();
            here ++> end_node;
            visit [-->(`?End)];
        };
    }


    can visit_interests with Memory entry {
        visit [-->(`?Interest)];
    }

    can add_interest with Interest entry {
        self.user_profile.interests.append(here);
        visit [-->(`?End)] else {
            print("No End node...creating one..\n");
            end_node = End();
            here ++> end_node;
            visit [-->(`?End)];
        };
    }

    can visit_certifications with Memory entry {
        visit [-->(`?Certification)];
    }

    can add_certification with Certification entry {
        self.user_profile.certifications.append(here);
        visit [-->(`?End)] else {
            print("No End node...creating one..\n");
            end_node = End();
            here ++> end_node;
            visit [-->(`?End)];
        };
    }

}

# Update user profile
walker update_user_profile {

    has updated_skills: list[dict] = [];
    has updated_interests: list[dict] = [];
    has updated_certifications: list[dict] = [];

    can visit_memory with `root entry {
        print("Visiting User Memory to update profile...\n");
        visit [-->(`?Memory)] else {
            report {
                "status": "Fail",
                "message": "User memory was never initialized",
                "body": {}
            };
            disengage;
        }
    }

    can add_new_skills with Memory entry {
        print("Arrived at Memory node..\n");

        print("Visiting Skill nodes to delete..\n");
        visit [-->(`?Skill)] else {
            report {
                "status": "Info",
                "message": "No skills found",
                "body": {}
            };
        }
        print(f"Clone that remained at Memory Adding new skills...{self.updated_skills}\n");
        for skill in self.updated_skills {
            let name = skill["name"];
            let desc = skill["description"];

            if not [-->(`?Skill)](?name==name) {
                let new_skill = Skill(name=name, description=desc);
                here +>:skilled_in:+> new_skill;
                report {
                    "status": "Success",
                    "message": "Skill added successfully",
                    "body": {name}
                };
            }
            else {
                report {
                    "status": "Fail",
                    "message": "Skill already exists",
                    "body": {name}
                };
            }
        }

    }

    can delete_skill with Skill entry {
        print("Deleting skills if not in updated list...\n");
        let names = [s["name"] for s in self.updated_skills];

        if here.name not in names {
            let removed = here.name;
            del here;
            report {
                "status": "Success",
                "message": "Skill deleted",
                "body": {removed}
            };
        }
        else {
            report {
                "status":"Fail",
                "message": "Skill not deleted because it exists in updated list",
                "body": {here.name}
            };
        }
    }

    can add_new_interests with Memory entry {

        print("Visiting Interest nodes to delete..\n");
        visit [-->(`?Interest)] else {
            report {
                "status": "Info",
                "message": "No interests found",
                "body": {}
            };
        }
        print("Adding new interests...\n");
        for interest in self.updated_interests {
            let name = interest["name"];
            let desc = interest["description"];

            if not [-->(`?Interest)](?name==name) {
                let new_interest = Interest(name=name, description=desc);
                here +>:interested_in:+> new_interest;
                report {
                    "status": "Success",
                    "message": "Interest added successfully",
                    "body": {name}
                };
            }
            else {
                report {
                    "status": "Fail",
                    "message": "Interest already exists",
                    "body": {name}
                };
            }
        }
        
    }

    can delete_interest with Interest entry {
        print("Deleting interests if not in updated list...\n");
        let names = [i["name"] for i in self.updated_interests];

        if here.name not in names {
            let removed = here.name;
            del here;
            report {
                "status": "Success",
                "message": "Interest deleted",
                "body": {removed}
            };
        }
        else {
            report {
                "status":"Fail",
                "message": "Interest not deleted because it exists in updated list",
                "body": {here.name}
            };
        }
    }

    can add_new_certifications with Memory entry {

        print("Visiting Certification nodes to delete..\n");
        visit [-->(`?Certification)] else {
            report {
                "status": "Info",
                "message": "No certifications found",
                "body": {}
            };
        }
        print(f"Adding new certifications...{self.updated_certifications}\n");
        for cert in self.updated_certifications {
            let title = cert["title"];
            let provider = cert["provider"];
            let url = cert["url"];

            if not [-->(`?Certification)](?title==title) {
                let new_cert = Certification(title=title, provider=provider, url=url);
                here +>:has_certification:+> new_cert;

                report {
                    "status": "Success",
                    "message": "Certification added successfully",
                    "body": {title}
                };
            }
            else {
                report {
                    "status": "Fail",
                    "message": "Certification already exists",
                    "body": {title}
                };
            }
        }
        
    }

    can delete_certification with Certification entry {
        print("Deleting certifications if not in updated list...\n");
        let titles = [c["title"] for c in self.updated_certifications];

        if here.title not in titles {
            let removed = here.title;
            del here;
            report {
                "status": "Success",
                "message": "Certification deleted",
                "body": {removed}
            };
        }
        else {
            report {
                "status":"Fail",
                "message": "Certification not deleted because it exists in updated list",
                "body": {here.title}
            };
        }
    }
}


# delete entire user profile
walker delete_user_profile {
    can visit_memory with `root entry {
        visit [-->(`?Memory)] else {
            report {"status": "Failed", "message": "User memory was never initiated", "body": {}};
            disengage;
        }
    }

    can delete_memory with Memory entry {
        visit [-->] else {
            report{"status": "Failed", "message": "Nothing to be deleted", "body": {}};
        };
        try {
            del here;
            report {"status": "Success", "message": "User Memory deleted", "body": {}};
        }
        except Exception as err {
            report {"status": "Success", "message": "Failed to delete user memory", "body": {}};
        }
        
    }

    can delete_skill with Skill entry {
        deleted_skill = here.name;
        try {
            del here;
            report {"status": "Success", "message": "Skill deleted Succesfully", "body": {delete_skill}};
        }
        except Exception as err {
            report {"status": "Failed", "message": "Skill not deleted!", "body": {here.name}};
        }
    }

    can delete_interest with Interest entry {
        deleted_interest = here.name;
        try {
            del here;
            report {"status": "Success", "message": "Interest deleted Succesfully", "body": {delete_interest}};
        }
        except Exception as err {
            report {"status": "Failed", "message": "Interest not deleted!", "body": {here.name}};
        }
    }

    can delete_certification with Certification entry {
        deleted_certification = here.name;
        try {
            del here;
            report {"status": "Success", "message": "Certification deleted Succesfully", "body": {delete_certification}};
        }
        except Exception as err {
            report {"status": "Failed", "message": "Certification not deleted!", "body": {here.name}};
        }
    }
}

# create role requirements graph
walker create_role_requirements_graph {
    has role_title: str = "";
    has role_description: str = "";
    has required_skills: list = [];
    has required_certifications: list = [];

    can create_role with `root entry {
        print("Creating Role Requirements Graph...\n");

        let role_node = here ++> Role(
            title=self.role_title,
            description=self.role_description
        );

        if not self.required_skills or len(self.required_skills) == 0 {
            print("No required skills provided.\n");
            report {
                "status": "warning",
                "message": "No required skills provided",
                "body": {}
            };
        }
        else {
            print("Saving required skills...\n");
            for skill in self.required_skills {
                role_node +>:requires_skill:+> skill;
            }
            report {
                "status": "success",
                "message": "Required skills saved",
                "body": {}
            };
        }

        if not self.required_certifications or len(self.required_certifications) == 0 {
            print("No required certifications provided.\n");
            report {
                "status": "warning",
                "message": "No required certifications provided",
                "body": {}
            };
        }
        else {
            print("Saving required certifications...\n");
            for cert in self.required_certifications {
                role_node +>:requires_certification:+> cert;
            }
            report {
                "status": "success",
                "message": "Required certifications saved",
                "body": {}
            };
        }

        print("Role requirements graph created successfully.\n");

        report {
            "status": "success",
            "message": "Role requirements graph created successfully",
            "body": {}
        };
    }

}


# retrieve roles from graph 
walker get_all_role_requirements {
    has role_title: str = "";
    has required_skills: list = [];
    has required_certifications: list = [];
    has role_requirements: RoleProfile = RoleProfile([], []);

    can visit_role with `root entry {
        print("Fetching all role requirements from graph...\n");

        visit [-->(`?Role)](?title==self.role_title) else {
            report {
                "status": "Fail",
                "message": "No Role nodes found",
                "body": {}
            };
            disengage;
        }
    }

    can fetch_role_requirements with Role entry {
        self.required_skills = [-->(`?Skill)];
        self.required_certifications = [-->(`?Certification)];
        self.role_requirements = RoleProfile(
            skills=self.required_skills,
            certifications=self.required_certifications
        );
        report {
            "status": "Success",
            "message": "Role requirements retrieved successfully from graph",
            "body": {
                "role_title": here.title,
                "role_description": here.description,
                "skills": [
                    {"name": s.name, "description": s.description}
                    for s in self.required_skills
                ],
                "certifications": [
                    {"title": c.title, "provider": c.provider, "url": c.url}
                    for c in self.required_certifications
                ]
            }
        };
    }
}

# Fetch live skills and certs fron the web for a given role
walker collect_role_requirements {
    has role_title: str = "";
    has role_description: str = "";
    has role_requirements: RoleProfile = RoleProfile([], []);

    # LLM function: extract skills + certs from title + description
    """
    You are now a career advisor
    Use you knowledge, reasoning and the tool `search_job_requirements`  to search the web for skills and
    certifications required for the given job title. Analyze the tool results
    and extract only skills and certifications that are relevant and most in demand (i.e those that appear frequently)
    If a a job title seems to not exist just fill it a most relevant similar role.
    """

    def get_role_requirements(role_title: str, role_description: str) -> RoleProfile
    by llm(method="ReAct",
    tools=([search_job_requirements]));

    can check_existing_target_role with `root entry {
       if [-->(`?Role)](?title==self.role_title) {
            print("Role requirements already exist in graph. Fetching from Memory.\n");

            fetched_role_requirements = root spawn get_all_role_requirements(role_title=self.role_title);
            self.role_requirements = fetched_role_requirements.role_requirements;
            report {
                "status": "Info",
                "message": "Role requirements already exist in graph. Fetched from memory.",
                "body": {}
            };
            disengage;
        }
    }

    can collect_certs_and_skills with `root entry {
        print("Collecting role requirements using LLM...\n");

        print("Role Title:", self.role_title);
        print("Role Description:", self.role_description, "\n");


        if self.role_title == None or self.role_title == "" {
            print("ERROR: Missing role title.\n");

            report {
                "status": "Fail",
                "message": "Missing required parameter: role_title",
                "body": {}
            };

            disengage;
        }

        if self.role_description == None {
            self.role_description = "";
        }

        print("Invoking LLM to get role requirements...\n");


        try {
            self.role_requirements = self.get_role_requirements(self.role_title, self.role_description);
        } except Exception as e {
            print("ERROR: LLM call failed:", e, "\n");

            report {
                "status": "Fail",
                "message": "Failed to fetch role requirements: " + str(e),
                "body": {}
            };

            disengage;
        }

        let required_skills = self.role_requirements.skills;
        let required_certifications = self.role_requirements.certifications;

        if (len(required_skills) == 0) and (len(required_certifications) == 0) {
        report {
            "status": "NoRequirements",
            "message": "This role does not specify any skill or certification requirements.",
            "body": {
                "skills": [],
                "certifications": []
            }
        };
        disengage;
    }

        print("LLM returned role requirements.\n");

        if required_skills == None or not isinstance(required_skills, list) {
            required_skills = [];
        }

        if required_certifications == None or not isinstance(required_certifications, list) {
            required_certifications = [];
        }

        required_skills = [
            s for s in required_skills
            if isinstance(s, Skill)
        ];

        required_certifications = [
            c for c in required_certifications
            if isinstance(c, Certification)
        ];

        report {
            "status": "Success",
            "message": "Role requirements fetched from the web successfully",
            "body": {
                "skills": [
                    {"name": s.name, "description": s.description}
                    for s in required_skills
                ],
                "certifications": [
                    {"title": c.title, "provider": c.provider, "url": c.url}
                    for c in required_certifications
                ]
            }
        };

        print("Spawning graph creation for role requirements...\n");

        saved_role_requirements = root spawn create_role_requirements_graph(
            role_title=self.role_title,
            role_description=self.role_description,
            required_skills=self.role_requirements.skills,
            required_certifications=self.role_requirements.certifications
        );
                
    }

}


# find skill gaps for a given role
walker find_skill_and_certification_gaps {
    
    has role_title: str = "";
    has user_profile: UserProfile = UserProfile([], [], []);
    has role_requirements: RoleProfile = RoleProfile([], []);
    has gaps: RoleProfile = RoleProfile([], []);


    """
    Find the skills and certification gaps by comparing the user profile and role requirements.
    """
    def find_gaps_between_profiles(user_profile: UserProfile, role_requirements: RoleProfile) -> RoleProfile
    by llm(method="Reason");

    # collect skills and certs from user graph
    can fetch_user_profile with `root entry {
        print("Fetching user profile for gap analysis...\n");

        let fetched_profile = root spawn get_user_profile();
        
        # cease operation if user profile is not fetched
        if fetched_profile == None or fetched_profile.user_profile == None {
            print("ERROR: Failed to fetch user profile.\n");
            report {
                "status": "Fail",
                "message": "Unable to load user profile.",
                "body": {}
            };
            disengage;
        }

        self.user_profile = fetched_profile.user_profile;
    }


    # collect skills and certs from role requirements graph
    can fetch_role_requirements with `root entry {
        print("Fetching role requirements for gap analysis...\n");

        let fetched_requirements = root spawn get_all_role_requirements(
            role_title=self.role_title,
            required_skills=[],
            required_certifications=[]
        );
        

        # cease operation if role requirements are not fetched
        if fetched_requirements == None or fetched_requirements.role_requirements == None {
            print("ERROR: Failed to fetch role requirements.\n");
            report {
                "status": "Fail",
                "message": "Unable to load role requirements.",
                "body": {}
            };
            disengage;
        }


        self.role_requirements = fetched_requirements.role_requirements;

    }
    
    # compare and find gaps
    can find_gaps with `root entry {
        print("Finding skill and certification gaps using LLM...\n");
        try {
            self.gaps = self.find_gaps_between_profiles(
                user_profile=self.user_profile,
                role_requirements=self.role_requirements
            );
            report {
                "status": "Success",
                "message": "Skill and certification gaps found successfully",
                "body": {
                    "skills": [
                        {"name": s.name, "description": s.description}
                        for s in self.gaps.skills
                    ],
                    "certifications": [
                        {"title": c.title, "provider": c.provider, "url": c.url}
                        for c in self.gaps.certifications
                    ]
                }
            };
        } except Exception as e {
            print("ERROR: LLM call failed:", str(e), "\n");

            report {
                "status": "Fail",
                "message": "Failed to find skill and certification gaps: " + str(e),
                "body": {}
            };

            disengage;

        }
        if (len(self.gaps.skills) == 0) and (len(self.gaps.certifications) == 0) {
            report {
                "status": "Qualified",
                "message": "You already meet all the skills and certifications required for this role.",
                "body": {
                    "skills": [],
                    "certifications": []
                }
            };
            disengage;
        }

    }
    can save_identified_gaps_to_graph with `root entry {
        print("Saving identified gaps to skill gap graph...\n");

        let saved_gaps = root spawn create_skill_gap_graph(
            gaps=self.gaps,
            role_title=self.role_title
        );

        if saved_gaps.gaps {
            report {
                "status": "Success",
                "message": "Skills and certifications gaps graph saved to memory.", 
                "body": {}
            };
        }
    }

}
# create skill gap graph
walker create_skill_gap_graph {
    has gaps: RoleProfile = RoleProfile([], []);
    has role_title: str = "";

    can create_requirements_gap_node with `root entry {
        print("Creating RG node..\n");

        let requirements_node = RequirementsGap(role_title=self.role_title);
        here ++> requirements_node;

        print("Visiting requirements gap...\n");
        visit [-->(`?RequirementsGap)];
    }

    can create_role_requirements_gap_graph with RequirementsGap entry {
        print("Creating Skill Gap Graph...\n");

        if not self.gaps {
            report {
                "status": "warning",
                "message": "No gaps provided",
                "body": {}
            };
            disengage;
        }

        if not self.gaps.skills or len(self.gaps.skills) == 0 {
            report {
                "status": "warning",
                "message": "No skill gaps",
                "body": {}
            };
        }
        else {
            for skill in self.gaps.skills {
                here +>:has_skill_gap:+> skill;
            }

            report {
                "status": "success",
                "message": "Skill gaps added to graph",
                "body": {}
            };
        }

        if not self.gaps.certifications or len(self.gaps.certifications) == 0 {
            report {
                "status": "warning",
                "message": "No certification gaps",
                "body": {}
            };
        }
        else {
            for cert in self.gaps.certifications {
                here +>:has_certification_gap:+> cert;
            }

            report {
                "status": "success",
                "message": "Certification gaps added to graph",
                "body": {}
            };
        }
    }
   
}

# update Skill gap graph. Takes in a list of completed skill names and cert names and specific role title
walker update_skill_gap_graph {
    has completed_skills: list = [];
    has completed_certifications: list = [];
    has role_title: str = "";

    can visit_requirements_gap with `root entry {
        print("Visiting Requirements Gap node to update skill gaps...\n");
        visit [-->(`?RequirementsGap)](?role_title==self.role_title) else {
            report {
                "status": "Fail",
                "message": "No Requirements Gap node found",
                "body": {}
            };
            disengage;
        }
    }

    can visit_skills with RequirementsGap entry {
        for skill in self.completed_skills {
            visit [-->(`?Skill)](?name==skill) else {
                continue;
            }; 
        }
    }

    can visit_certifications with RequirementsGap entry {
        for cert in self.completed_certifications {
            visit [-->(`?Certification)](?title==cert) else {
                continue;
            }; 
        }
    }

    can update_skills with Skill entry {
        #call a walker to update main skill graph
        root spawn add_completed_skill_to_user_profile(
            completed_skill=here
        );
        let completed_skill = here.name;
        del here;
        report {
            "status": "Success",
            "message": "Completed skill removed from skill gap graph",
            "body": {completed_skill}
        };

    }

    can update_certifications with Certification entry {
        #call a walker to update main skill graph
        root spawn add_completed_certification_to_user_profile(
            completed_certification=here
        );
        let completed_certification = here.title;
        del here;
        report {
            "status": "Success",
            "message": "Completed certification removed from skill gap graph",
            "body": {completed_certification}
        };

    }

}

#adds completed skills to users main skill graph
walker add_completed_skill_to_user_profile {
    has completed_skill: Skill = Skill("", "");

    can visit_memory with `root entry {
        print("Visiting User Memory to add completed skill...\n");

        visit [-->(`?Memory)] else {
            report {
                "status": "Fail",
                "message": "User memory was never initialized",
                "body": {}
            };
            disengage;
        }
    }

    can add_skill with Memory entry {
        # EMPTY CHECK
        if not self.completed_skill.name or self.completed_skill.name == "" {
            report {
                "status": "Fail",
                "message": "Completed skill entry is empty. Skipping.",
                "body": {}
            };
            disengage;
        }

        if not [-->(`?Skill)](?name==self.completed_skill.name) {
            here +>:skilled_in:+> self.completed_skill;

            report {
                "status": "Success",
                "message": "Completed skill added to user profile",
                "body": {self.completed_skill.name}
            };
        }
        else {
            report {
                "status": "Fail",
                "message": "Skill already exists in user profile",
                "body": {self.completed_skill.name}
            };
        }
    }
}
# Add completed certifications to user's main skill graph
walker add_completed_certification_to_user_profile {
    has completed_certification: Certification = Certification("", "", "");

    can visit_memory with `root entry {
        print("Visiting User Memory to add completed certification...\n");

        visit [-->(`?Memory)] else {
            report {
                "status": "fail",
                "message": "User memory was never initialized",
                "body": {}
            };
            disengage;
        }
    }

    can add_certification with Memory entry {
        # EMPTY CHECK
        if not self.completed_certification.title or self.completed_certification.title == "" {
            report {
                "status": "Fail",
                "message": "Completed certification entry is empty. Skipping.",
                "body": {}
            };
            disengage;
        }

        if not [-->(`?Certification)](?title==self.completed_certification.title) {
            here +>:has_certification:+> self.completed_certification;

            report {
                "status": "Success",
                "message": "Completed certification added to user profile",
                "body": {self.completed_certification.title}
            };
        }
        else {
            report {
                "status": "Fail",
                "message": "Certification already exists in user profile",
                "body": {self.completed_certification.title}
            };
        }
    }
}



# recommend learning paths to fill skill gaps
walker recommend_learning_paths {
    has gaps: RoleProfile = RoleProfile([], []);
    has user_profile: UserProfile = UserProfile([], [], []);
    has target_role_requirements: RoleProfile = RoleProfile([], []);
    has role_title: str = "";


    """
    You are an expert career coach, instructional designer, and learning architect.
    Your task is to generate a complete, personalized, resource-driven learning path to help the user close their skill and certification gaps.
    You must use the provided tool search_learning_resources to discover highly relevant, accurate, up-to-date learning materials.
    Do not guess URLs—use the tool search_learning_links to find relevant URLs.
    Include only 2 most relevant and reliable links. Dont clutter the output with links. 2 are enough.

    Your output must strictly follow these requirements:
    

    1. Understand Inputs

    Use and interpret the following inputs at a high level:

    gaps: Missing skills and certifications

    user_profile: Skills, experience level, background, and preferences

    target_role_requirements: Full skill & certification list for the target job role

    Use them to build a learning path tailored to the user’s gaps and their existing strengths.

    2. Use the Tools

    When you need external resources to recommend:

    learning materials

    tutorials

    roadmaps

    guides

    courses

    certifications

    documentation

    you must use search_learning_resources(search_phrase) with properly crafted phrases, e.g.:

    "learn Kubernetes for beginners"

    "how to gain proficiency in cloud security"

    "best Python data engineering tutorials"

    "AWS certification study guide 2025"

    Use the results to populate URLs and resource summaries.
    you must use search_learning_links(search_phrase) with properly crafted phrases e.g.:
    "best online resources for learning python"

    3. Deliver a Comprehensive Learning Path

    The learning path must be exhaustive, structured, and ordered, containing:

    A. Timeline Overview

    Provide:

    Total estimated duration

    Weekly hour commitment

    Beginner / intermediate / advanced segments

    B. Stage-by-Stage Breakdown

    For every required skill or certification gap:

    Skill Definition

    Why It Matters for the Role

    Prerequisites (based on user’s profile)

    Learning Objectives

    Step-by-step Learning Plan

    Recommended URLs (must come from tool (search_learning_links) output)

    Hands-on Projects / Assignments

    Milestones & Progress Checks

    Estimated Time to Master (in weeks)

    C. Integrated Roadmap

    Show a combined timeline like:

    Week 1–2: Python Data Fundamentals

    Week 3–5: Machine Learning Foundations

    Week 6–9: Deep Learning + Practical Projects

    Week 10: Portfolio + Capstone Project

    D. Certification Guidance

    For each required certification:

    What it covers

    Best preparation strategy

    Recommended URLs from the tool (search_learning_links)  

    Study plan and weekly breakdown

    Practice exams and expected difficulty

    4. Quality Requirements

    Your answer must be:

    Accurate, up-to-date, resource-grounded

    Comprehensive and deeply detailed

    Role-specific (Never generic)

    Actionable—every step must be implementable

    User-tailored—based on background and skill level

    Explicitly reference URLs from the tool results
    Final Constraints

    Never fabricate URLs.

    If no URLs are found just skip the part. Dont mention that the tool did not find URLS

    Always rely on the tool for external sites.

    Provide enough clarity for a learner to follow with zero ambiguity.

    Be extremely detailed and comprehensive.
    """

    def suggest_learning_paths(gaps: RoleProfile, user_profile: UserProfile, target_role_requirements: RoleProfile) -> LearningPath
    by llm(method="ReAct", tools=([search_learning_resources, search_learning_links]));

    can check_existing_learning_path  with `root entry {
        if [-->(`?LearningPath)](?role_title==self.role_title) {
            print("Learning path already exists in graph. Fetching from Memory.\n");

            let existing_path = [-->(`?LearningPath)](?role_title==self.role_title);
            report {
                "status": "Info",
                "message": "Learning path already exists in graph. Fetched from memory.",
                "body": {
                    "role_title": existing_path.role_title,
                    "learning_path": existing_path.learning_path
                }
            };
            disengage;
        }
    }
    can fetch_gaps with `root entry {
        print("Fetching skill and certification gaps for learning path recommendation...\n");

        let fetched_gaps = root spawn find_skill_and_certification_gaps(
            role_title=self.role_title,
            user_profile=None,
            role_requirements=None
        );

        # cease operation if gaps are not fetched
        if fetched_gaps == None or fetched_gaps.gaps == None {
            print("ERROR: Failed to fetch skill and certification gaps.\n");
            report {
                "status": "Fail",
                "message": "Unable to load skill and certification gaps.",
                "body": {}
            };
            disengage;
        }

        self.gaps = fetched_gaps.gaps;

    }

    can fetch_role_requirements with `root entry {
        print("Fetching target role requirements for learning path recommendation...\n");

        let fetched_requirements = root spawn get_all_role_requirements(
            role_title=self.role_title,
            required_skills=[],
            required_certifications=[]
        );

        # cease operation if role requirements are not fetched
        if fetched_requirements == None or fetched_requirements.role_requirements == None {
            print("ERROR: Failed to fetch role requirements.\n");
            report {
                "status": "Fail",
                "message": "Unable to load role requirements.",
                "body": {}
            };
            disengage;
        }

        self.target_role_requirements = fetched_requirements.role_requirements;

    }

    can fetch_user_profile with `root entry {
        print("Fetching user profile for learning path recommendation...\n");

        let fetched_profile = root spawn get_user_profile();
        
        # cease operation if user profile is not fetched
        if fetched_profile == None or fetched_profile.user_profile == None {
            print("ERROR: Failed to fetch user profile.\n");
            report {
                "status": "Fail",
                "message": "Unable to load user profile.",
                "body": {}
            };
            disengage;
        }

        self.user_profile = fetched_profile.user_profile;
    }

    can recommend_path with `root entry {
        print("Recommending learning path using LLM...\n");

        try {
            let learning_path = self.suggest_learning_paths(
                gaps=self.gaps,
                user_profile=self.user_profile,
                target_role_requirements=self.target_role_requirements
            );

            # save learning path to graph
            here ++> learning_path;

            # create subdir if it doesn't exist
            if not os.path.exists("learning_paths"){
                os.makedirs("learning_paths");
            }
            # sanitize role title to use as filename
            let safe_title = learning_path.role_title.replace(" ", "_").replace("/", "-");
            let file_path = "learning_paths/" + safe_title + ".md";

            # convert escaped newlines to real newlines
            let md_content = learning_path.learning_path.encode('utf-8').decode('unicode_escape');

            # write to file
            with open(file_path, "w", encoding="utf-8") as f {
                f.write(md_content);
            }
            print("Learning path saved to:", file_path, "\n");

            report {
                "status": "Success",
                "message": "Learning path recommended and saved to graph successfully",
                "body": {
                    "role_title": learning_path.role_title,
                    "learning_path": learning_path.learning_path.encode('utf-8').decode('unicode_escape')
                }
            };
        } except Exception as e {
            print("ERROR: LLM call failed:", e, "\n");

            report {
                "status": "Fail",
                "message": "Failed to recommend learning path: " + str(e),
                "body": {}
            };

            disengage;

        }

    }
}