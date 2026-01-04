impl initialize_memory.initialize_memory{
    new_memory = here ++> Memory(email=self.email, full_name=self.full_name);
    report
    {"status" : "Success" , "message" : "Memory initialized" , "body" : new_memory } ;
}


impl create_resume_node.create_resume_node{
    new_resume = here ++> Resume();
    report
    {"status" : "Success" , "message" : "Resume node created" , "body" : new_resume } ;
}


impl upload_resume.visit_resume_node{
    print("Visiting Resume Node");
    visit [-->( ` ? Resume ) ];
}


impl upload_resume.upload_resume{
    here.name = self.name;
    here.mime = self.mime;
    try {
        let decoded_bytes = base64.b64decode(self.file);
        here.content = decoded_bytes;
    } except Exception as e {
        print(f"Base64 decode error: {e}");
        report
        {"status" : "Fail" , "message" : "Failed to decode resume file" , "body" : {} } ;
        disengage;
    }
    print(f"File bytes saved, size = {len(here.content)} bytes");
    report
    {"status" : "Success" , "message" : "Resume uploaded" , "body" :
    {"name" : here.name , "mime" : here.mime , "size_bytes" : len(here.content) } } ;
}


impl update_resume_upload_status.check_memory{
    visit [-->( ` ? Memory ) ];
}


impl update_resume_upload_status.update_resume_upload_status{
    here.resume_uploaded = True;
    report
    {"status" : "Success" , "message" : "Resume upload status updated" , "body" : here.resume_uploaded } ;
}


impl check_resume_upload_status.check_memory{
    visit [-->( ` ? Memory ) ];
}


impl check_resume_upload_status.check_resume_upload_status{
    report {"status" : "Success" , "message" : "" , "body" : here.resume_uploaded } ;
}


impl save_resume.visit_resume{
    visit [-->( ` ? Resume ) ];
}


impl save_resume.save_resume{
    if not here.content {
        print("No resume content found");
        report
        {"status" : "Fail" , "message" : "No resume content to save" , "body" : {} } ;
        disengage;
    }
    print("Saving resume file to disk...");
    let dir = "./resumes";
    if not os.path.exists(dir) {
        os.makedirs(dir);
    }
    let base_name = here.name;
    let path = f"{dir}/{base_name}";
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
    try {
        with open(path, "wb") as f  {
            f.write(here.content);
        }
    } except Exception as e {
        print(f"Error writing file: {e}");
        report
        {"status" : "Fail" , "message" : "Error saving resume to disk" , "body" : {} } ;
        disengage;
    }
    here.file_path = path;
    print(f"File saved at: {path}");
    report
    {"status" : "Success" , "message" : "Resume saved to disk" , "body" : {"file_path" : here.file_path } } ;
}


impl retrieve_resume.visit_resume{
    print("Visiting resume node...\n");
    visit [-->( ` ? Resume ) ] else {
        report {"status" : "Fail" , "message" : "No Resume node found" , "body" : {} } ;
        disengage;
    }
}


impl retrieve_resume.retrieve_resume{
    if not here.file_path or here.file_path == ""  {
        report
        {"status" : "Fail" , "message" : "No resume file path found" , "body" : {} } ;
        disengage;
    }
    if not os.path.exists(here.file_path) {
        report
        {"status" : "Fail" , "message" : "Resume file does not exist on disk" , "body" : {} } ;
        disengage;
    }
    # Read file bytes
     # Original file path
     # Handle duplicate filenames
     # No extension
     try {
        with open(here.file_path, "rb") as f  {
            let file_bytes = f.read();
        }
    } except Exception as e {
        print(f"Error reading resume file: {e}");
        report
        {"status" : "Fail" , "message" : "Error reading resume file from disk" , "body" : {} } ;
        disengage;
    }
    # Encode to base64 for transmission
    # Read file bytes
    # Original file path
    # Handle duplicate filenames
    # No extension
    # Encode to base64 for transmission
    let encoded =
        base64.b64encode(file_bytes).decode('utf-8');
    report
    {"status" : "Success" , "message" : "Resume retrieved successfully" , "body" : {"name" : here.name , "mime" : here.mime , "file_base64" : encoded } } ;
}


sem analyze_cv. extract_user_skills_from_cv= """
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
""";


impl analyze_cv.visit_resume{
    visit [-->( ` ? Resume ) ] else {
        report {"status" : "Fail" , "message" : "No Resume node found" , "body" : {} } ;
        disengage;
    }
}


impl analyze_cv.extract_user_skills{
    # Edge Case Checks
     if not here.file_path {
        report
        {"status" : "Fail" , "message" : "No resume file path found" , "body" : {} } ;
        disengage;
    }
    if not os.path.exists(here.file_path) {
        report
        {"status" : "Fail" , "message" : "Resume file does not exist on disk" , "body" : {} } ;
        disengage;
    }
    # Extract Text
    let text =
        read_document_text(here.file_path);
    if not text {
        report
        {"status" : "Fail" , "message" : "Unable to extract text from resume" , "body" : {} } ;
        disengage;
    }
    # LLM Extraction
     try {
        self.user_profile = self.extract_user_skills_from_cv(text);
    } except Exception as err {
        report {"status" : "Fail" , "message" : {err} , "body" : {} } ;
        disengage;
    }
    # create User graph
    print(
        "Saving User Profile to Memory...\n"
    );
    root spawn create_user_graph(user_profile=self.user_profile);
    # Final Report
     # Save file bytes
     # Ensure file_path exists on Resume node
     # Edge Case Checks
     # Extract Text
     # LLM Extraction
     # create User graph
     # Final Report
     # Save file bytes
     # Ensure file_path exists on Resume node
     report
    {"status" : "Success" , "message" : "Resume processed successfully" , "body" :
    {"skills" : [ s.name for s in self.user_profile.skills ] , "certifications" : [ {"title" : c.title , "provider" : c.provider , "url" : c.url } for c in self.user_profile.certifications ] , "interests" : [ {"name" : i.name , "description" : i.description } for i in self.user_profile.interests ] } } ;
}


impl get_user_details.visit_memory{
    visit [-->( ` ? Memory ) ] else {
        report {"status" : "Fail" , "message" : "No user found" , "body" : {} } ;
        disengage;
    }
}


impl get_user_details.get_user_details{
    # Edge Case Checks
     # Edge Case Checks
     if here.full_name == None or here.email == None  {
        report
        {"status" : "Fail" , "message" : "User details missing in memory" , "body" : {} } ;
        disengage;
    }
    let name_clean = here.full_name.strip() if here.full_name else "";
    let email_clean = here.email.strip() if here.email else "";
    if name_clean == "" and email_clean == ""  {
        report {"status" : "Fail" , "message" : "No user details found" , "body" : {} } ;
        disengage;
    }
    # Final Success Report
     report
    {"status" : "Success" , "message" : "User details fetched successfully" , "body" : {"full_name" : name_clean , "email" : email_clean } } ;
}


impl create_user_graph.visit_memory{
    print("Checking User Memory...");
    visit [-->( ` ? Memory ) ] else {
        report
        {"status" : "Fail" , "message" : "User memory not initialized" , "body" : {} } ;
        disengage;
    }
}


impl create_user_graph.create_user_graph{
    print(f"Found user: {here.resume_uploaded}");
    end_node = End();
    for skill in self.user_profile.skills {
        # Check if Skill exists
         if [-->( ` ? Skill ) ]( ? name == skill.name )  {
            print(f"Skipping duplicate skill: {skill.name}");
            continue;
        }
        here +>: skilled_in :+> skill ++> end_node;
    }
    for cert in self.user_profile.certifications {
        # Check if Certification exists
         # Read file bytes
         # Encode to base64 for transmission
         # Edge Case Checks
         # Extract Text
         # LLM Extraction
         # create User graph
         # Final Success Report
         # Check if Skill exists
         # Check if Certification exists
         # Read file bytes
         # Encode to base64 for transmission
         # Edge Case Checks
         # Extract Text
         # LLM Extraction
         # create User graph
         if [-->( ` ? Certification ) ]( ? title == cert.title )  {
            continue;
        }
        here +>: has_certification :+> cert ++> end_node;
    }
    for interest in self.user_profile.interests {
        # Check if Interest exists
         if [-->( ` ? Interest ) ]( ? name == interest.name )  {
            continue;
        }
        here +>: interested_in :+> interest ++> end_node;
    }
    report
    {"status" : "Success" , "message" : "Resume analyzed successfully" , "body" :
    {"skills" : [ s.name for s in self.user_profile.skills ] , "certifications" : [ c.title for c in self.user_profile.certifications ] , "interests" : [ i.name for i in self.user_profile.interests ] } } ;
}


sem generate_role_suggestions. suggest_roles_based_on_profile= """
Analyze the user’s skills, interests, and certifications. Suggest top 5 realistic career roles that match their strengths.
Each role must include a short title and a concise description explaining why I am a good fit.
Avoid generic suggestions and prioritize roles where the user's skill combination provides a clear advantage.
""";


impl generate_role_suggestions.fetch_user_profile{
    print("Fetching user profile for role suggestion...\n");
    let fetched_profile = root spawn get_user_profile();
    # cease operation if user profile is not fetched
     if fetched_profile == None or fetched_profile.user_profile == None  {
        print("ERROR: Failed to fetch user profile.\n");
        report
        {"status" : "Fail" , "message" : "Unable to load user profile." , "body" : [] } ;
        disengage;
    }
    self.user_profile = fetched_profile.user_profile;
    print("Fetched user profile:\n");
    print(self.user_profile);
    print("\n");
}


impl generate_role_suggestions.suggest_roles{
    print("Using LLM to suggest roles based on user profile...\n");
    # Edge case: empty or weak profile
     if len(self.user_profile.skills) == 0
    and len(self.user_profile.interests) == 0
    and len(self.user_profile.certifications) == 0
     {
        print("WARNING: User profile is empty. LLM suggestions may be inaccurate.\n");
    }
    let suggested_roles = self.suggest_roles_based_on_profile(self.user_profile);
    # LLM returned nothing
     # Check if Interest exists
     # cease operation if user profile is not fetched
     # Edge case: empty or weak profile
     # LLM returned nothing
     if suggested_roles == None {
        print("ERROR: LLM returned no roles.\n");
        report
        {"status" : "Error" , "message" : "LLM failed to generate any role suggestions." , "body" : [] } ;
        disengage;
    }
    # LLM returned empty list
     if len(suggested_roles) == 0 {
        print("No roles returned by LLM.\n");
        report
        {"status" : "Empty" , "message" : "No roles could be suggested for the provided profile." , "body" : [] } ;
        disengage;
    }
    print("Suggested Roles:\n");
    let valid_roles = [];
    # Validate each LLM-generated role object
     for role in suggested_roles {
        if role == None or role.title == None or role.description == None  {
            print("Skipping malformed role suggestion returned by LLM.\n");
            continue;
        }
        print(f"- {role.title}: {role.description}\n");
        valid_roles += [role];
    }
    # All roles were invalid
     if len(valid_roles) == 0 {
        print("ERROR: All LLM suggestions were malformed.\n");
        report
        {"status" : "Fail" , "message" : "LLM returned invalid role objects." , "body" : [] } ;
        disengage;
    }
    # Final response
     # Final Report
     # Edge Case Checks
     # Final Success Report
     # Check if Skill exists
     # Check if Certification exists
     # Check if Interest exists
     # LLM returned empty list
     # Validate each LLM-generated role object
     # All roles were invalid
     # Final response
     # Final Report
     # Edge Case Checks
     # Final Success Report
     # Check if Skill exists
     # Check if Certification exists
     # Check if Interest exists
     report
    {"status" : "Success" , "message" : "Roles suggested successfully" , "body" : [ {"title" : role.title , "description" : role.description } for role in valid_roles ] } ;
}


impl get_user_profile.visit_memory{
    print("get_user_profile walker visiting memory..\n");
    visit [-->( ` ? Memory ) ] else {
        report
        {"status" : "Fail" , "message" : "User memory not initialized" , "body" : {} } ;
        disengage;
    }
}


impl get_user_profile.visit_skills{
    print("get_user_profile walker visiting skills..\n");
    visit [-->( ` ? Skill ) ] else {
        print("No Skills found");
        report {"status" : "Fail" , "message" : "No Skills found" , "body" : {} } ;
    }
}


impl get_user_profile.add_skill{
    print("get_user_profile adding skills..\n");
    self.user_profile.skills.append(here);
    visit [-->( ` ? End ) ] else {
        print("No End node...creating one..\n");
        end_node = End();
        here ++> end_node;
        visit [-->( ` ? End ) ];
    }
    ;
}


impl get_user_profile.visit_interests{
    visit [-->( ` ? Interest ) ];
}


impl get_user_profile.add_interest{
    self.user_profile.interests.append(here);
    visit [-->( ` ? End ) ] else {
        print("No End node...creating one..\n");
        end_node = End();
        here ++> end_node;
        visit [-->( ` ? End ) ];
    }
    ;
}


impl get_user_profile.visit_certifications{
    visit [-->( ` ? Certification ) ];
}


impl get_user_profile.add_certification{
    self.user_profile.certifications.append(here);
    visit [-->( ` ? End ) ] else {
        print("No End node...creating one..\n");
        end_node = End();
        here ++> end_node;
        visit [-->( ` ? End ) ];
    }
    ;
}


impl get_user_target_roles.fetch_target_roles{
    print("Fetching user target roles from Memory...\n");
    if not [-->( ` ? Role ) ] {
        report {"status" : "Fail" , "message" : "No target roles found" , "body" : [] } ;
        disengage;
    } else {
        self.target_roles = [ r for r in [-->( ` ? Role ) ] ];
        report
        {"status" : "Success" , "message" : "Target roles fetched successfully" , "body" :
        {"roles" : [ {"title" : role.title , "description" : role.description } for role in self.target_roles ] } } ;
    }
}


impl get_road_map.fetch_learning_path{
    print("Starting roadmap retrieval...\n");
    if self.role_title != "" {
        print("Role title provided. Visiting LearningPath node...\n");
        visit [-->( ` ? LearningPath ) ]( ? role_title == self.role_title )  else {
            report
            {"status" : "Fail" , "message" : "No learning path found for the specified role" , "body" : {} } ;
            disengage;
        }
    } else {
        print("No role title provided. Using provided disk path directly...\n");
        if not self.disk_path or self.disk_path == ""  {
            report
            {"status" : "Fail" , "message" : "No role title or disk path provided" , "body" : {} } ;
            disengage;
        } else {
            print("Using provided disk path...\n");
            let path = self.disk_path;
            if os.path.exists(path) {
                with open(path, "r", encoding="utf-8") as f  {
                    let content = f.read();
                }
                self.learning_path = content;
                report
                {"status" : "Success" , "message" : "Learning path fetched successfully" , "body" :
                {"role_title" : self.role_title , "learning_path" : self.learning_path } } ;
            } else {
                report
                {"status" : "Fail" , "message" : "Provided disk path does not exist" , "body" : {} } ;
            }
        }
    }
}


impl get_road_map.return_learning_path{
    print("Checking stored learning path in LearningPath Node...\n");
    let path = "";
    if not self.disk_path or self.disk_path == ""  {
        print("Using internal path from LearningPath  node...\n");
        path = here.disk_path;
    } else {
        print("Using provided disk path...\n");
        path = self.disk_path;
    }
    if os.path.exists(path) {
        with open(path, "r", encoding="utf-8") as f  {
            let content = f.read();
        }
        self.learning_path = content;
        report
        {"status" : "Success" , "message" : "Learning path fetched successfully" , "body" :
        {"role_title" : here.role_title , "learning_path" : self.learning_path } } ;
    } else {
        report
        {"status" : "Fail" , "message" : "Learning path file missing on disk" , "body" : {} } ;
    }
}


impl update_user_profile.visit_memory{
    print("Visiting User Memory to update profile...\n");
    visit [-->( ` ? Memory ) ] else {
        report
        {"status" : "Fail" , "message" : "User memory was never initialized" , "body" : {} } ;
        disengage;
    }
}


impl update_user_profile.add_new_skills{
    print("Arrived at Memory node..\n");
    if not self.append_only {
        print("Visiting Skill nodes to delete..\n");
        visit [-->( ` ? Skill ) ] else {
            report {"status" : "Info" , "message" : "No skills found" , "body" : {} } ;
        }
    }
    print(f"Clone that remained at Memory Adding new skills...{self.updated_skills}\n");
    for skill in self.updated_skills {
        let name = skill["name"];
        let desc = skill["description"];
        if not [-->( ` ? Skill ) ]( ? name == name )  {
            let new_skill = Skill(name=name, description=desc);
            here +>: skilled_in :+> new_skill;
            root spawn update_skill_gap_graph(completed_skills=[name]);
            report
            {"status" : "Success" , "message" : "Skill added successfully" , "body" : {"name" : name } } ;
        } else {
            report
            {"status" : "Fail" , "message" : "Skill already exists" , "body" : {"name" : name } } ;
        }
    }
}


impl update_user_profile.delete_skill{
    print("Deleting skills if not in updated list...\n");
    let names = [ s["name"] for s in self.updated_skills ];
    if here.name not in names {
        let removed = here.name;
        del here ;
        report
        {"status" : "Success" , "message" : "Skill deleted" , "body" : {"name" : removed } } ;
    } else {
        report
        {"status" : "Fail" , "message" : "Skill not deleted because it exists in updated list" , "body" : {"name" : here.name } } ;
    }
}


impl update_user_profile.add_new_interests{
    if not self.append_only {
        print("Visiting Interest nodes to delete..\n");
        visit [-->( ` ? Interest ) ] else {
            report {"status" : "Info" , "message" : "No interests found" , "body" : {} } ;
        }
    }
    print("Adding new interests...\n");
    for interest in self.updated_interests {
        let name = interest["name"];
        let desc = interest["description"];
        if not [-->( ` ? Interest ) ]( ? name == name )  {
            let new_interest = Interest(name=name, description=desc);
            here +>: interested_in :+> new_interest;
            report
            {"status" : "Success" , "message" : "Interest added successfully" , "body" : {"name" : name } } ;
        } else {
            report
            {"status" : "Fail" , "message" : "Interest already exists" , "body" : {"name" : name } } ;
        }
    }
}


impl update_user_profile.delete_interest{
    print("Deleting interests if not in updated list...\n");
    let names = [ i["name"] for i in self.updated_interests ];
    if here.name not in names {
        let removed = here.name;
        del here ;
        report
        {"status" : "Success" , "message" : "Interest deleted" , "body" : {"name" : removed } } ;
    } else {
        report
        {"status" : "Fail" , "message" : "Interest not deleted because it exists in updated list" , "body" : {"name" : here.name } } ;
    }
}


impl update_user_profile.add_new_certifications{
    if not self.append_only {
        print("Visiting Certification nodes to delete..\n");
        visit [-->( ` ? Certification ) ] else {
            report
            {"status" : "Info" , "message" : "No certifications found" , "body" : {} } ;
        }
    }
    print(f"Adding new certifications...{self.updated_certifications}\n");
    for cert in self.updated_certifications {
        let title = cert["name"];
        let provider = cert.get("provider", "");
        let url = cert.get("url", "");
        if not [-->( ` ? Certification ) ]( ? title == title )  {
            let new_cert = Certification(title=title, provider=provider, url=url);
            here +>: has_certification :+> new_cert;
            root spawn update_skill_gap_graph(completed_certifications=[title]);
            report
            {"status" : "Success" , "message" : "Certification added successfully" , "body" : {"title" : title } } ;
        } else {
            report
            {"status" : "Fail" , "message" : "Certification already exists" , "body" : {"title" : title } } ;
        }
    }
}


impl update_user_profile.delete_certification{
    print("Deleting certifications if not in updated list...\n");
    let titles = [ c["title"] for c in self.updated_certifications ];
    if here.title not in titles {
        let removed = here.title;
        del here ;
        report
        {"status" : "Success" , "message" : "Certification deleted" , "body" : {"title" : removed } } ;
    } else {
        report
        {"status" : "Fail" , "message" : "Certification not deleted because it exists in updated list" , "body" : {"title" : here.title } } ;
    }
}


impl delete_user_profile.visit_memory{
    visit [-->( ` ? Memory ) ] else {
        report
        {"status" : "Failed" , "message" : "User memory was never initiated" , "body" : {} } ;
        disengage;
    }
}


impl delete_user_profile.delete_memory{
    visit [-->] else {
        report
        {"status" : "Failed" , "message" : "Nothing to be deleted" , "body" : {} } ;
    }
    ;
    try {
        del here ;
        report {"status" : "Success" , "message" : "User Memory deleted" , "body" : {} } ;
    } except Exception as err {
        report
        {"status" : "Success" , "message" : "Failed to delete user memory" , "body" : {} } ;
    }
}


impl delete_user_profile.delete_skill{
    deleted_skill = here.name;
    try {
        del here ;
        report
        {"status" : "Success" , "message" : "Skill deleted Succesfully" , "body" : {"name" : deleted_skill } } ;
    } except Exception as err {
        report
        {"status" : "Failed" , "message" : "Skill not deleted!" , "body" : {"name" : here.name } } ;
    }
}


impl delete_user_profile.delete_interest{
    deleted_interest = here.name;
    try {
        del here ;
        report
        {"status" : "Success" , "message" : "Interest deleted Succesfully" , "body" : {"name" : deleted_interest } } ;
    } except Exception as err {
        report
        {"status" : "Failed" , "message" : "Interest not deleted!" , "body" : {"name" : here.name } } ;
    }
}


impl delete_user_profile.delete_certification{
    deleted_certification = here.title;
    try {
        del here ;
        report
        {"status" : "Success" , "message" : "Certification deleted Succesfully" , "body" : {"title" : deleted_certification } } ;
    } except Exception as err {
        report
        {"status" : "Failed" , "message" : "Certification not deleted!" , "body" : {"title" : here.title } } ;
    }
}


impl create_role_requirements_graph.create_role{
    print("Creating Role Requirements Graph...\n");
    let role_node =
        here ++> Role(title=self.role_title, description=self.role_description);
    if not self.required_skills or len(self.required_skills) == 0  {
        print("No required skills provided.\n");
        report
        {"status" : "warning" , "message" : "No required skills provided" , "body" : {} } ;
    } else {
        print("Saving required skills...\n");
        for skill in self.required_skills {
            role_node +>: requires_skill :+> skill;
        }
        report
        {"status" : "success" , "message" : "Required skills saved" , "body" : {} } ;
    }
    if not self.required_certifications or len(self.required_certifications) == 0  {
        print("No required certifications provided.\n");
        report
        {"status" : "warning" , "message" : "No required certifications provided" , "body" : {} } ;
    } else {
        print("Saving required certifications...\n");
        for cert in self.required_certifications {
            role_node +>: requires_certification :+> cert;
        }
        report
        {"status" : "success" , "message" : "Required certifications saved" , "body" : {} } ;
    }
    print("Role requirements graph created successfully.\n");
    report
    {"status" : "success" , "message" : "Role requirements graph created successfully" , "body" : {} } ;
}


impl get_all_role_requirements.visit_role{
    print("Fetching all role requirements from graph...\n");
    visit [-->( ` ? Role ) ]( ? title == self.role_title )  else {
        report {"status" : "Fail" , "message" : "No such role found" , "body" : {} } ;
        disengage;
    }
}


impl get_all_role_requirements.fetch_role_requirements{
    self.required_skills = [-->( ` ? Skill ) ];
    self.required_certifications = [-->( ` ? Certification ) ];
    self.role_requirements =
        RoleProfile(
            skills=self.required_skills,
            certifications=self.required_certifications
        );
    report
    {"status" : "Success" , "message" : "Role requirements retrieved successfully from graph" , "body" :
    {"role_title" : here.title , "role_description" : here.description , "skills" : [ {"name" : s.name , "description" : s.description } for s in self.required_skills ] , "certifications" : [ {"title" : c.title , "provider" : c.provider , "url" : c.url } for c in self.required_certifications ] } } ;
}


sem collect_role_requirements. get_role_requirements= """
You are an expert career advisor and labor-market analyst.

Your task is to determine the most in-demand SKILLS and CERTIFICATIONS for a given job role.

TOOLS:
- You have access to the tool `search_job_requirements`, which searches the web.

INSTRUCTIONS:

1. ROLE VALIDATION (FIRST STEP)
- Evaluate whether `role_title` represents a real, recognizable job role used in the labor market.
- If the role title is clearly gibberish, random text, or not a profession (e.g. "asdasd123", "qwerty job", "!!!"),
immediately return.
- Do NOT hallucinate skills for invalid roles.

2. TOOL-FIRST SEARCH (MANDATORY)
- If the role is valid, you MUST attempt to use the tool `search_job_requirements` to gather real-world data.
- Search using:
- the role_title
- and role_description if provided
- Prefer recent and commonly referenced sources such as:
job descriptions, hiring requirements, professional frameworks, certification bodies.

3. EXTRACTION & SYNTHESIS
- From the tool results:
- Identify skills that appear frequently or are clearly emphasized.
- Identify certifications that are widely recognized or commonly required/preferred.
- Filter out:
- Soft or vague traits (e.g. "good attitude", "team player")
- Company-specific internal tools unless they are industry-standard.

4. FALLBACK LOGIC
- If the tool fails, returns no results, or errors:
- Use your internal knowledge as a fallback.
- Clearly infer only well-established, industry-standard skills and certifications.
- Tool data ALWAYS takes priority over internal knowledge.

GOAL:
Produce a concise, accurate, and market-relevant skills and certifications grounded in real hiring demand.

""";


impl collect_role_requirements.check_existing_target_role{
    if [-->( ` ? Role ) ]( ? title == self.role_title )  {
        print("Role requirements already exist in graph. Fetching from Memory.\n");
        fetched_role_requirements =
            root spawn get_all_role_requirements(role_title=self.role_title);
        self.role_requirements = fetched_role_requirements.role_requirements;
        report
        {"status" : "Info" , "message" : "Role requirements already exist in graph. Fetched from memory." , "body" : {} } ;
        disengage;
    }
}


impl collect_role_requirements.collect_certs_and_skills{
    print("Collecting role requirements using LLM...\n");
    print("Role Title:", self.role_title);
    print("Role Description:", self.role_description, "\n");
    if self.role_title == None or self.role_title == ""  {
        print("ERROR: Missing role title.\n");
        report
        {"status" : "Fail" , "message" : "Missing required parameter: role_title" , "body" : {} } ;
        disengage;
    }
    if self.role_description == None {
        self.role_description = "";
    }
    print("Invoking LLM to get role requirements...\n");
    try {
        self.role_requirements =
            self.get_role_requirements(self.role_title, self.role_description);
    } except Exception as e {
        print("ERROR: LLM call failed:", e, "\n");
        report
        {"status" : "Fail" , "message" : "Failed to fetch role requirements: " + str(e) , "body" : {} } ;
        disengage;
    }
    let required_skills = self.role_requirements.skills;
    let required_certifications = self.role_requirements.certifications;
    if (len(required_skills) == 0) and (len(required_certifications) == 0)  {
        report
        {"status" : "NoRequirements" , "message" : "This role does not specify any skill or certification requirements." , "body" : {"skills" : [] , "certifications" : [] } } ;
        disengage;
    }
    print("LLM returned role requirements.\n");
    if required_skills == None or not isinstance(required_skills, list)  {
        required_skills = [];
    }
    if required_certifications == None or not isinstance(required_certifications, list)  {
        required_certifications = [];
    }
    required_skills = [ s for s in required_skills if isinstance(s, Skill) ];
    required_certifications =
        [ c for c in required_certifications if isinstance(c, Certification) ];
    report
    {"status" : "Success" , "message" : "Role requirements fetched from the web successfully" , "body" :
    {"skills" : [ {"name" : s.name , "description" : s.description } for s in required_skills ] , "certifications" : [ {"title" : c.title , "provider" : c.provider , "url" : c.url } for c in required_certifications ] } } ;
    print("Spawning graph creation for role requirements...\n");
    saved_role_requirements =
        root spawn create_role_requirements_graph(
            role_title=self.role_title,
            role_description=self.role_description,
            required_skills=self.role_requirements.skills,
            required_certifications=self.role_requirements.certifications
        );
}


sem find_skill_and_certification_gaps. find_gaps_between_profiles= """
Find the skills and certification gaps by comparing the user profile and role requirements.
""";


impl find_skill_and_certification_gaps.fetch_user_profile{
    print("Fetching user profile for gap analysis...\n");
    let fetched_profile = root spawn get_user_profile();
    # cease operation if user profile is not fetched
     # Delete newly acquired certification from certification gap graph
     if fetched_profile == None or fetched_profile.user_profile == None  {
        print("ERROR: Failed to fetch user profile.\n");
        report
        {"status" : "Fail" , "message" : "Unable to load user profile." , "body" : {} } ;
        disengage;
    }
    self.user_profile = fetched_profile.user_profile;
}


impl find_skill_and_certification_gaps.fetch_role_requirements{
    print("Fetching role requirements for gap analysis...\n");
    let fetched_requirements =
        root spawn get_all_role_requirements(
            role_title=self.role_title,
            required_skills=[],
            required_certifications=[]
        );
    # cease operation if role requirements are not fetched
     # check if file exists
     # read markdown from disk
     # cease operation if user profile is not fetched
     # Edge case: empty or weak profile
     # LLM returned nothing
     # LLM returned empty list
     # Validate each LLM-generated role object
     # check if file exists
     # read markdown from disk
     # cease operation if user profile is not fetched
     # Edge case: empty or weak profile
     # LLM returned nothing
     # LLM returned empty list
     # Validate each LLM-generated role object
     # delete newly added skill from skill gap graph if it exists
     # All roles were invalid
     # Final response
     if fetched_requirements == None or fetched_requirements.role_requirements == None  {
        print("ERROR: Failed to fetch role requirements.\n");
        report
        {"status" : "Fail" , "message" : "Unable to load role requirements." , "body" : {} } ;
        disengage;
    }
    self.role_requirements = fetched_requirements.role_requirements;
}


impl find_skill_and_certification_gaps.find_gaps{
    print("Finding skill and certification gaps using LLM...\n");
    try {
        self.gaps =
            self.find_gaps_between_profiles(
                user_profile=self.user_profile,
                role_requirements=self.role_requirements
            );
        report
        {"status" : "Success" , "message" : "Skill and certification gaps found successfully" , "body" :
        {"skills" : [ {"name" : s.name , "description" : s.description } for s in self.gaps.skills ] , "certifications" : [ {"title" : c.title , "provider" : c.provider , "url" : c.url } for c in self.gaps.certifications ] } } ;
    } except Exception as e {
        print("ERROR: LLM call failed:", str(e), "\n");
        report
        {"status" : "Fail" , "message" : "Failed to find skill and certification gaps: " + str(e) , "body" : {} } ;
        disengage;
    }
    if (len(self.gaps.skills) == 0) and (len(self.gaps.certifications) == 0)  {
        report
        {"status" : "Qualified" , "message" : "You already meet all the skills and certifications required for this role." , "body" : {"skills" : [] , "certifications" : [] } } ;
        disengage;
    }
}


impl find_skill_and_certification_gaps.save_identified_gaps_to_graph{
    print("Saving identified gaps to skill gap graph...\n");
    let saved_gaps =
        root spawn create_skill_gap_graph(gaps=self.gaps, role_title=self.role_title);
    report
    {"status" : "Success" , "message" : "Skills and certifications gaps graph saved to memory." , "body" : {} } ;
}


impl create_skill_gap_graph.create_requirements_gap_node{
    if [-->( ` ? RequirementsGap ) ]( ? role_title == self.role_title )  {
        report
        {"status" : "Fail" , "message" : "Skill Gap Graph Already Exists!" , "body" : {} } ;
        disengage;
    }
    print("Creating RG node..\n");
    let requirements_node = RequirementsGap(role_title=self.role_title);
    here ++> requirements_node;
    print("Visiting requirements gap...\n");
    visit [-->( ` ? RequirementsGap ) ]( ? role_title == self.role_title ) ;
}


impl create_skill_gap_graph.create_role_requirements_gap_graph{
    print("Creating Skill Gap Graph...\n");
    if not self.gaps {
        report {"status" : "Fail" , "message" : "No gaps provided!" , "body" : {} } ;
        disengage;
    }
    if not self.gaps.skills or len(self.gaps.skills) == 0  {
        report {"status" : "warning" , "message" : "No skill gaps" , "body" : {} } ;
    } else {
        for skill in self.gaps.skills {
            here +>: has_skill_gap :+> skill;
            self.skill_count += 1;
        }
        report
        {"status" : "success" , "message" : "Skill gaps added to graph" , "body" : {} } ;
    }
    if not self.gaps.certifications or len(self.gaps.certifications) == 0  {
        report
        {"status" : "warning" , "message" : "No certification gaps" , "body" : {} } ;
    } else {
        for cert in self.gaps.certifications {
            here +>: has_certification_gap :+> cert;
            self.cert_count += 1;
        }
        report
        {"status" : "success" , "message" : "Certification gaps added to graph" , "body" : {} } ;
    }
    # Update progress
    self.initial_gap =
        self.cert_count + self.skill_count;
    here.initial_gap = self.initial_gap;
}


impl update_skill_gap_graph.visit_requirements_gap{
    print("Visiting Requirements Gap node to update skill gaps...\n");
    visit [-->( ` ? RequirementsGap ) ] else {
        report
        {"status" : "Fail" , "message" : "No Requirements Gap node found" , "body" : {} } ;
        disengage;
    }
}


impl update_skill_gap_graph.visit_skills{
    for skill in self.completed_skills {
        visit [-->( ` ? Skill ) ]( ? name == skill )  else {
            continue;
        }
        ;
    }
}


impl update_skill_gap_graph.visit_certifications{
    for cert in self.completed_certifications {
        visit [-->( ` ? Certification ) ]( ? title == cert )  else {
            continue;
        }
        ;
    }
}


impl update_skill_gap_graph.update_skills{
    #call a walker to update main skill graph
     root spawn add_completed_skill_to_user_profile(completed_skill=here);
    let completed_skill = here.name;
    del here ;
    report
    {"status" : "Success" , "message" : "Completed skill removed from skill gap graph" , "body" : {completed_skill} } ;
}


impl update_skill_gap_graph.update_certifications{
    #call a walker to update main skill graph
     root spawn add_completed_certification_to_user_profile(
        completed_certification=here
    );
    let completed_certification = here.title;
    del here ;
    report
    {"status" : "Success" , "message" : "Completed certification removed from skill gap graph" , "body" : {completed_certification} } ;
}


impl add_completed_skill_to_user_profile.visit_memory{
    print("Visiting User Memory to add completed skill...\n");
    visit [-->( ` ? Memory ) ] else {
        report
        {"status" : "Fail" , "message" : "User memory was never initialized" , "body" : {} } ;
        disengage;
    }
}


impl add_completed_skill_to_user_profile.add_skill{
    # EMPTY CHECK
     if not self.completed_skill.name or self.completed_skill.name == ""  {
        report
        {"status" : "Fail" , "message" : "Completed skill entry is empty. Skipping." , "body" : {} } ;
        disengage;
    }
    if not [-->( ` ? Skill ) ]( ? name == self.completed_skill.name )  {
        here +>: skilled_in :+> self.completed_skill;
        report
        {"status" : "Success" , "message" : "Completed skill added to user profile" , "body" : {self.completed_skill.name} } ;
    } else {
        report
        {"status" : "Fail" , "message" : "Skill already exists in user profile" , "body" : {self.completed_skill.name} } ;
    }
}


impl add_completed_certification_to_user_profile.visit_memory{
    print("Visiting User Memory to add completed certification...\n");
    visit [-->( ` ? Memory ) ] else {
        report
        {"status" : "fail" , "message" : "User memory was never initialized" , "body" : {} } ;
        disengage;
    }
}


impl add_completed_certification_to_user_profile.add_certification{
    # EMPTY CHECK
     # cease operation if user profile is not fetched
     # cease operation if role requirements are not fetched
     # delete newly added skill from skill gap graph if it exists
     # All roles were invalid
     # Final response
     if not self.completed_certification.title
    or self.completed_certification.title == ""
     {
        report
        {"status" : "Fail" , "message" : "Completed certification entry is empty. Skipping." , "body" : {} } ;
        disengage;
    }
    if not [-->( ` ? Certification ) ]( ? title == self.completed_certification.title )  {
        here +>: has_certification :+> self.completed_certification;
        report
        {"status" : "Success" , "message" : "Completed certification added to user profile" , "body" : {self.completed_certification.title} } ;
    } else {
        report
        {"status" : "Fail" , "message" : "Certification already exists in user profile" , "body" : {self.completed_certification.title} } ;
    }
}


impl check_progress.visit_requirements_gap_node{
    visit [-->( ` ? RequirementsGap ) ]( ? role_title == self.role_title )  else {
        report
        {"status" : "Fail" , "message" : "Progress for the specified role could not be fetched!" , "body" : {} } ;
        disengage;
    }
}


impl check_progress.check_learning_progress{
    self.current_gap = len([-->]);
    try {
        here.progress = 1 - (self.current_gap / here.initial_gap) * 100;
        report
        {"status" : "Success" , "message" : "Progress retrieved successfully!" , "body" : {here.progress} } ;
    } except Exception as e {
        report
        {"status" : "Fail" , "message" : "Could not fetch progress: " + str(e) , "body" : {} } ;
    }
}


impl retrieve_skill_gaps.visit_requirements_gap_node{
    if not [-->( ` ? RequirementsGap ) ]( ? role_title == self.role_title )  {
        report
        {"status" : "Fail" , "message" : "No gaps for the specified role" , "body" : {} } ;
        disengage;
    }
    print("Visiting RG Node to retrive gaps...\n");
    visit [-->( ` ? RequirementsGap ) ]( ? role_title == self.role_title ) ;
}


impl retrieve_skill_gaps.visit_skills{
    print("Visiting Skill gap nodes...\n");
    visit [-->( ` ? Skill ) ];
}


impl retrieve_skill_gaps.visit_certs{
    print("Visiting  gap nodes...\n");
    visit [-->( ` ? Certification ) ];
}


impl retrieve_skill_gaps.retrieve_skills{
    print("Now at skill node..retrieving..\n");
    self.gaps.skills.append(here);
    print("Finished retreiving skills..now reporting..\n");
    report
    {"status" : "Succcess" , "message" : "Skill gaps retrieved successfully" , "body" : self.gaps.skills } ;
}


impl retrieve_skill_gaps.retrieve_certifications{
    print("Now at cert node..retrieving..\n");
    self.gaps.certifications.append(here);
    print("Finished retreiving certs..now reporting..\n");
    report
    {"status" : "Succcess" , "message" : "Certification gaps retrieved successfully" , "body" : self.gaps.certifications } ;
}


sem recommend_learning_paths. suggest_learning_paths= """
You are an expert career coach, instructional designer, and learning architect.

Your task is to generate a complete, personalized, resource-driven learning path to help the me close my skill and certification gaps.

You must use the provided tool search_learning_resources to discover highly relevant, accurate, up-to-date learning materials.
Do not guess URLs—always rely on tool outputs.

IMPORTANT TOOL USAGE RULE :
- You MUST batch ALL search phrases into a SINGLE LIST.
- You MUST call search_learning_resources ONLY ONCE.
- You MUST NOT call the tool separately for each skill or certification gap.
- First, derive all required search phrases.
- Then, pass them together as one list in a single tool call.
- This batching is mandatory and non-optional.

Include only the 2 most relevant and reliable links per skill or certification.
Do not clutter the output with links—2 are sufficient.

For each skill gap or certification gap:
- You may generate AT MOST ONE search phrase.
- All generated search phrases MUST be bundled into a single list before calling the tool.

1. Understand Inputs

Use and interpret the following inputs at a high level:

- gaps: Missing skills and certifications
- user_profile: Skills, experience level, background, and preferences
- target_role_requirements: Full skill & certification list for the target job role

Use these inputs to build a learning path tailored to the user’s gaps while leveraging existing strengths.

2. Tool Usage Workflow (MANDATORY ORDER)


You MUST follow this exact workflow:

Step 1: Analyze all skill and certification gaps.
Step 2: Generate a complete list of search phrases (list[str]) covering all gaps.
Step 3: Call search_learning_resources(search_phrases) ONCE with the full list.
Step 4: Use the returned results to populate URLs and summaries.

Example of valid batched search phrases:
[
"learn Kubernetes for beginners",
"cloud security fundamentals roadmap",
"Python data engineering tutorials",
"AWS certification study guide 2025"
]

You must NOT call tools incrementally or per-gap.

3. Deliver a Comprehensive Learning Path


The learning path must be exhaustive, structured, and ordered.

A. Timeline Overview
- Total estimated duration
- Weekly hour commitment
- Beginner / Intermediate / Advanced segmentation

B. Stage-by-Stage Breakdown
For EACH skill or certification gap:

- Skill Definition
- Why It Matters for the Role
- Prerequisites (derived from user_profile)
- Learning Objectives
- Step-by-step Learning Plan
- Recommended URLs (ONLY from tool output)
- Hands-on Projects / Assignments
- Milestones & Progress Checks
- Estimated Time to Master (weeks)

C. Integrated Roadmap
Provide a unified timeline, for example:
- Week 1–2: Python Data Fundamentals
- Week 3–5: Machine Learning Foundations
- Week 6–9: Deep Learning + Projects
- Week 10: Portfolio + Capstone

D. Certification Guidance
For EACH required certification:

- What it covers
- Cost (if applicable)
- Best preparation strategy
- Recommended URLs (from tool output)
- Weekly study plan
- Practice exams & expected difficulty

4. Quality Requirements


Your output must be:

- Accurate and up-to-date
- Resource-grounded (tool-based)
- Deeply detailed and structured
- Role-specific (never generic)
- Actionable and unambiguous
- Tailored to the user’s background and level

Final Constraints

- Never fabricate URLs.
- If no URLs are returned for a topic, silently skip that section.
- Never mention missing tool results.
- Always rely on tool outputs for external resources.
- Be extremely detailed and comprehensive.
""";


impl recommend_learning_paths.check_existing_learning_path{
    if [-->( ` ? LearningPath ) ]( ? role_title == self.role_title )  {
        print("Learning path already exists in graph. Fetching from Memory.\n");
        let existing_path =
            [-->( ` ? LearningPath ) ]( ? role_title == self.role_title ) ;
        report
        {"status" : "Fail" , "message" : "Learning path already exists in graph. Fetched from memory." , "body" : {} } ;
        disengage;
    }
}


impl recommend_learning_paths.fetch_gaps{
    print("Fetching skill and certification gaps for learning path recommendation...\n");
    let fetched_gaps = root spawn retrieve_skill_gaps(role_title=self.role_title);
    # cease operation if gaps are not fetched
     # Delete newly acquired certification from certification gap graph
     # check if file exists
     # read markdown from disk
     # delete newly added skill from skill gap graph if it exists
     if fetched_gaps == None or fetched_gaps.gaps == None  {
        print("ERROR: Failed to fetch skill and certification gaps.\n");
        report
        {"status" : "Fail" , "message" : "Unable to load skill and certification gaps." , "body" : {} } ;
        disengage;
    }
    self.gaps = fetched_gaps.gaps;
}


impl recommend_learning_paths.fetch_role_requirements{
    print("Fetching target role requirements for learning path recommendation...\n");
    let fetched_requirements =
        root spawn get_all_role_requirements(
            role_title=self.role_title,
            required_skills=[],
            required_certifications=[]
        );
    # cease operation if role requirements are not fetched
     if fetched_requirements == None or fetched_requirements.role_requirements == None  {
        print("ERROR: Failed to fetch role requirements.\n");
        report
        {"status" : "Fail" , "message" : "Unable to load role requirements." , "body" : {} } ;
        disengage;
    }
    self.target_role_requirements = fetched_requirements.role_requirements;
}


impl recommend_learning_paths.fetch_user_profile{
    print("Fetching user profile for learning path recommendation...\n");
    let fetched_profile = root spawn get_user_profile();
    # cease operation if user profile is not fetched
     # and use here.title instead of here.name
     if fetched_profile == None or fetched_profile.user_profile == None  {
        print("ERROR: Failed to fetch user profile.\n");
        report
        {"status" : "Fail" , "message" : "Unable to load user profile." , "body" : {} } ;
        disengage;
    }
    self.user_profile = fetched_profile.user_profile;
}


impl recommend_learning_paths.recommend_path{
    print("Recommending learning path using LLM...\n");
    try {
        let learning_path =
            self.suggest_learning_paths(
                gaps=self.gaps,
                user_profile=self.user_profile,
                target_role_requirements=self.target_role_requirements
            );
        # save learning path to graph
        let learning_path_node =
            LearningPath(role_title=self.role_title, learning_path=learning_path);
        here ++> learning_path_node;
        # create subdir if it doesn't exist
         if not os.path.exists("learning_paths") {
            os.makedirs("learning_paths");
        }
        # sanitize role title to use as filename
        let safe_title =
            learning_path_node.role_title.replace(" ", "_").replace("/", "-");
        let base_path = "learning_paths/" + safe_title + ".md";
        let file_path = base_path;
        # check if file exists and increment
        let counter =
            1;
        while os.path.exists(file_path) {
            let numbered_title = safe_title + "(" + str(counter) + ")";
            file_path = "learning_paths/" + numbered_title + ".md";
            counter = counter + 1;
        }
        # convert escaped newlines to real newlines
        let md_content =
            learning_path_node.learning_path.encode("utf-8").decode("unicode_escape");
        # write to file
         # Update progress
         #call a walker to update main skill graph
         #call a walker to update main skill graph
         # EMPTY CHECK
         # EMPTY CHECK
         # cease operation if gaps are not fetched
         # cease operation if role requirements are not fetched
         # cease operation if user profile is not fetched
         # save learning path to graph
         # create subdir if it doesn't exist
         # sanitize role title to use as filename
         # check if file exists and increment
         # convert escaped newlines to real newlines
         # write to file
         # Delete newly acquired certification from certification gap graph
         # check if file exists
         # read markdown from disk
         # delete newly added skill from skill gap graph if it exists
         # and use here.title instead of here.name
         # cease operation if user profile is not fetched
         # Delete newly acquired certification from certification gap graph
         # cease operation if role requirements are not fetched
         # cease operation if user profile is not fetched
         # Delete newly acquired certification from certification gap graph
         # cease operation if role requirements are not fetched
         # Update progress
         #call a walker to update main skill graph
         #call a walker to update main skill graph
         # EMPTY CHECK
         # Update progress
         #call a walker to update main skill graph
         #call a walker to update main skill graph
         # EMPTY CHECK
         # EMPTY CHECK
         # cease operation if user profile is not fetched
         # cease operation if role requirements are not fetched
         # EMPTY CHECK
         # cease operation if user profile is not fetched
         # cease operation if role requirements are not fetched
         # cease operation if gaps are not fetched
         # cease operation if role requirements are not fetched
         # cease operation if user profile is not fetched
         # save learning path to graph
         # create subdir if it doesn't exist
         # sanitize role title to use as filename
         # check if file exists and increment
         # convert escaped newlines to real newlines
         # write to file
         # Update progress
         #call a walker to update main skill graph
         #call a walker to update main skill graph
         # EMPTY CHECK
         # EMPTY CHECK
         # cease operation if gaps are not fetched
         # cease operation if role requirements are not fetched
         # cease operation if user profile is not fetched
         # save learning path to graph
         # create subdir if it doesn't exist
         # sanitize role title to use as filename
         # check if file exists and increment
         # convert escaped newlines to real newlines
         # write to file
         # cease operation if gaps are not fetched
         # cease operation if role requirements are not fetched
         # cease operation if user profile is not fetched
         # save learning path to graph
         # create subdir if it doesn't exist
         # sanitize role title to use as filename
         # check if file exists and increment
         # convert escaped newlines to real newlines
         # write to file
         # Update progress
         #call a walker to update main skill graph
         #call a walker to update main skill graph
         # EMPTY CHECK
         # EMPTY CHECK
         # cease operation if gaps are not fetched
         # cease operation if role requirements are not fetched
         # cease operation if user profile is not fetched
         # save learning path to graph
         # create subdir if it doesn't exist
         # sanitize role title to use as filename
         # check if file exists and increment
         # convert escaped newlines to real newlines
         # write to file
         with open(file_path, "w", encoding="utf-8") as f  {
            f.write(md_content);
        }
        print("Learning path saved to:", file_path, "\n");
        learning_path_node.disk_path = file_path;
        report
        {"status" : "Success" , "message" : "Learning path recommended and saved to graph successfully" , "body" :
        {"role_title" : learning_path_node.role_title , "learning_path" : learning_path_node.learning_path.encode('utf-8').decode(
            'unicode_escape'
        ) } } ;
    } except Exception as e {
        print("ERROR: LLM call failed:", e, "\n");
        report
        {"status" : "Fail" , "message" : "Failed to recommend learning path: " + str(e) , "body" : {} } ;
        disengage;
    }
}


impl career_chat.chat{
    let uid = self.user_id;
    if not uid {
        uid = "anonymous";
    }
    if uid not in history_by_user {
        history_by_user[uid] = [];
    }
    let history = history_by_user[uid];
    print("Getting User Profile to Chatbot\n");
    let profile_walker = root spawn get_user_profile();
    self.user_profile = profile_walker.user_profile;
    print(f"User Profile fetched:\n {self.user_profile}\n");
    let raw_reply =
        generate_career_answer(
            uid,
            self.message,
            self.focus_area,
            history,
            self.user_profile
        );
    let reply_text = clean_reply_text(raw_reply);
    history.append(
        {"from_user" : True , "text" : self.message , "focus_area" : self.focus_area }
    );
    history.append(
        {"from_user" : False , "text" : reply_text , "focus_area" : self.focus_area }
    );
    history_by_user[uid] = history;
    report {"reply" : reply_text , "history" : history } ;
}
