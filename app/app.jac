import from byllm.lib { Model }
import from dotenv { load_dotenv }
import base64;
import re;
import os;
import PyPDF2;
import docx;

glob llm = Model(model_name="gemini/gemini-2.5-flash", verbose=False);

# Helpers 
def read_document_text(file_path: str) -> str{

    if not os.path.exists(file_path){

        return "";
    }
    file_path_lower = file_path.lower();

    try{
 
        # PDF READER
        if file_path_lower.endswith(".pdf"){
            text = "";
            with open(file_path, "rb") as f {
                reader = PyPDF2.PdfReader(f);
                for page in reader.pages {
                    text += page.extract_text() or "";
                }
            }
            return text.strip();
        }

        # DOCX READER
        elif file_path_lower.endswith(".docx"){
            doc = docx.Document(file_path);
            text = "\n".join([para.text for para in doc.paragraphs]);
            return text.strip();
        }
        else{
            return "";
        }
    }
    except Exception as e {
        print(f"[ERROR] Failed to read document: {e}");
        return "";
    }

}

# Backend Nodes
node Memory {
    has email: str = "";
    has full_name: str = "";
    has resume_uploaded: bool = False;
    # optional: preserve suggested roles for quick retrieval
    has suggested_roles_cache: list[Role] = [];
}

node Resume {
    has name: str = "";
    has file_path: str = "";
    has mime: str = "";
    has content: any = None;   # will store decoded bytes
}

node Skill {
    has name: str = "";
    has description: str = "";
}

node Role {
    has title: str = "";
    has description: str = "";
}

node Course {
    has title: str = "";
    has provider: str = "";
}

node Certification {
    has title: str = "";
    has provider: str = "";
    has url: str = "";
}

node Interest {
    has name: str = "";
    has description: str = "";
}


# Edges
edge skilled_in {}
edge has_certification {}
edge interested_in {}
edge recommended_role {}

obj UserProfile {
    has skills: list[Skill];
    has certifications: list[Certification];
    has interests: list[Interest];
    has suggested_roles: list[Role];
}


# Walkers

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

# Upload resume
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


# Check resume upload status
walker check_resume_upload_status {
    can check_memory with `root entry {
        visit [-->(`?Memory)];
    }

    can check_resume_upload_status with Memory entry {
        report {"status": "Success", "message": "", "body": here.resume_uploaded};
    }
}


# Save resume to disk
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

# extract user skills, certifications, and interests from uploaded CV
walker extract_user_skills {
    has user_profile: UserProfile = UserProfile([], [], [], []);

    """
    You are an AI that extracts structured information ONLY from real CV/resume text.

    ### TASK
    Given a block of text, determine whether it represents a CV/resume using common CV structure and words such as Experience, Skills, Referees, Education.
    Do not analyze anything that does not look like a CV. Return None if it is not a CV.  If it is a CV, extract:

    - skills: list of Skill objects (Skill{name, description})
    - certifications: list of Certification objects (Certification{title, provider, url})
    - interests: list of Interest objects (Interest{name, description})
    - Generate suggested career path/roles (list of Role objects) based ONLY on the extracted skills, certifications, and interests. DO NOT HALLUCINATE extra skills or certifications. Use only what exists in the text.

    Return a populated UserProfile.

    If the text is NOT a CV/resume, return None.

    ### IMPORTANT
    The output MUST be a well-structured UserProfile object with lists of Skill, Certification, Interest and Role objects.
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
                    ],
                    "suggested_roles":[
                        {"title": r.title, "description": r.description} for r in self.user_profile.suggested_roles
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

walker create_user_graph {
    has user_profile: UserProfile = UserProfile([], [], [], []);

    can visit_memory with `root entry {
        print("Checking User Memory...");
        visit [-->(`?Memory)] else {
            report {"status": "Fail", "message": "User memory not initialized", "body": {}};
            disengage;
        }
    }

    can create_user_graph with Memory entry {
        print(f"Found user: {here.resume_uploaded}");

        for skill in self.user_profile.skills {

            # Check if Skill exists
            if [-->(`?Skill)](?name == skill.name) {
                print(f"Skipping duplicate skill: {skill.name}");
                continue;
            }

            here +>:skilled_in:+> skill;
        }

        for cert in self.user_profile.certifications {

            # Check if Certification exists
            if [-->(`?Certification)](?title == cert.title) {
                continue;
            }
            here +>:has_certification:+> cert;
        }

        for interest in self.user_profile.interests {

            # Check if Interest exists
            if [-->(`?Interest)](?name == interest.name) {

                continue;
            }
            here +>:interested_in:+> interest;
        }

        # Save suggested roles as Role nodes and link to Memory
        for role in self.user_profile.suggested_roles {
            # avoid duplicates
            if [-->(`?Role)](?title == role.title) {
                # still create the edge if missing
                if not (here -- recommended_role->(`?Role))(?title == role.title) {
                    here +>:recommended_role:+> [-->(`?Role)](?title == role.title)[0];
                }
                continue;
            }

            new_role = here ++> Role(title=role.title, description=role.description);
            here +>:recommended_role:+> new_role;
        }

        # Optionally cache suggested roles on Memory for quick API reads
        here.suggested_roles_cache = self.user_profile.suggested_roles;

        report {
            "status": "Success",
            "message": "User knowledge graph created",
            "body": {
                "skills": [s.name for s in self.user_profile.skills],
                "certifications": [c.title for c in self.user_profile.certifications],
                "interests": [i.name for i in self.user_profile.interests],
                "suggested_roles": [r.title for r in self.user_profile.suggested_roles]
            }
        };
    }
}

with entry {
    load_dotenv();
}
