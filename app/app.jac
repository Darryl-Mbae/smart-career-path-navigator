cl import from .pages.Website { Website }
cl import from .pages.Auth { Auth }
cl import from .pages.Dashboard { Dashboard }
cl import from .pages.Onboarding { Onboarding }
cl import from "@jac-client/utils" {
    Router,
    Routes,
    Route,
}
cl import ".global.css";

cl {
    def app() -> any {

        let meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0';

        document.getElementsByTagName('head')[0].appendChild(meta);

         # 1. Preconnect to Google Fonts
        preconnect1 = document.createElement('link');
        preconnect1.rel = 'preconnect';
        preconnect1.href = 'https://fonts.googleapis.com';
        document.head.appendChild(preconnect1);

        # 2. Preconnect to fonts static content (with crossorigin)
        preconnect2 = document.createElement('link');
        preconnect2.rel = 'preconnect';
        preconnect2.href = 'https://fonts.gstatic.com';
        preconnect2.crossOrigin = 'anonymous';
        document.head.appendChild(preconnect2);

        # 3. Load the actual font
        fontLink = document.createElement('link');
        fontLink.href = 'https://fonts.googleapis.com/css2?family=Zalando+Sans+SemiExpanded:ital,wght@0,200..900;1,200..900&display=swap';
        fontLink.rel = 'stylesheet';
        document.head.appendChild(fontLink);
        

       return <Router>
            <div>
                <Routes>
                    <Route
                        path="/"
                        element={<Website />}
                    />
                    <Route
                        path="/auth"
                        element={<Auth />}
                    />
                     <Route
                        path="/onboarding"
                        element={<Onboarding />}
                    />
                     <Route
                        path="/dashboard"
                        element={<Dashboard />}
                    />
                </Routes>
            </div>
        </Router>;
    }
}

import from byllm.lib { Model }
import from dotenv { load_dotenv }
import base64;
import re;
import os;
import PyPDF2;
import docx;
import requests;
import json;
import from firecrawl { FirecrawlApp }
import from models.Models { Memory, Resume, Skill, Role, Certification, Interest, RequirementsGap, LearningPath }
import from relationships.Relationships { skilled_in, has_certification, interested_in, requires_skill, requires_certification, has_skill_gap, has_certification_gap }
import from tools.Tools { is_valid_url, search_job_urls, extract_markdown, search_job_requirements, fetch_careerjet_descriptions,
is_valid_url, search_urls, extract_markdown, search_learning_resources, is_learning_url, search_learning_links }
import from helpers.Helpers { read_document_text }


glob llm = Model(model_name="gemini/gemini-2.5-flash", verbose=False);

# Helpers 



# Backend Models

# Used by get_user_profile agent to aggregate user's skills. interests and certifications and report back to FE
node End {
    has user_profile: UserProfile = UserProfile([], [], []);

    can aggregate_user_info with get_user_profile entry {
        self.user_profile = visitor.user_profile;
        print("Finished Aggregating User Profile...Now reporting..\n");
        report {
            "status": "Success",
            "message": "User profile fetched successfully",
            "body": {
                "skills": [
                    {"name": s.name, "description": s.description}
                    for s in self.user_profile.skills
                ],
                "interests": [
                    {"name": i.name, "description": i.description}
                    for i in self.user_profile.interests
                ],
                "certifications": [
                    {
                        "title": c.title,
                        "provider": c.provider,
                        "url": c.url
                    }
                    for c in self.user_profile.certifications
                ]
            }
        };
    }
}



# User profile object
obj UserProfile {
    has skills: list[Skill];
    has certifications: list[Certification];
    has interests: list[Interest];
}

# Role requires skills and certifications
obj RoleProfile {
    has skills: list[Skill];
    has certifications: list[Certification];
}



# User Agents
# Initialize Memory for a new user
walker initialize_memory {
    has email: str = "";
    has full_name: str= "";

    can initialize_memory with `root entry;
}

# Create a new Resume node
walker create_resume_node {
    can create_resume_node with `root entry;
}

# Save CV contents to Resume node as bytes
walker upload_resume {
    has file: bytes = b"";      # Base64 string from frontend
    has name: str = "";
    has mime: str = "";

    can visit_resume_node with `root entry;

    can upload_resume with Resume entry;
}

# Update resume upload status in memory
walker update_resume_upload_status {
    can check_memory with `root entry;

    can update_resume_upload_status with Memory entry;
}


# Check if CV is uploaded or not
walker check_resume_upload_status {
    can check_memory with `root entry;

    can check_resume_upload_status with Memory entry;
}


# Save CV to disk
walker save_resume {

    can visit_resume with `root entry;

    can save_resume with Resume entry;
}

# Retrieve resume/cv
walker retrieve_resume {

    can visit_resume with `root entry;
    
    can retrieve_resume with Resume entry;
}

# analyze CV and report findings to FE
walker analyze_cv {
    has user_profile: UserProfile = UserProfile([], [], []);

    
    def extract_user_skills_from_cv(resume_text: str) -> UserProfile | None by llm(method="Reason");

    can visit_resume with `root entry;

    can extract_user_skills with Resume entry;
}


# extract full names and email
walker get_user_details {

    can visit_memory with `root entry;

    can get_user_details with Memory entry;
}


# create and store user profile (Internal API: used by analyze_cv agent)
walker create_user_graph {
    has user_profile: UserProfile = UserProfile([], [], []);

    can visit_memory with `root entry;

    can create_user_graph with Memory entry;
}


# Suggest roles based on user profile
walker generate_role_suggestions {
    has user_profile: UserProfile = UserProfile([], [], []);

    def suggest_roles_based_on_profile(user_profile: UserProfile) -> list[Role] by llm(method="Reason");

    # Fetch Profile 
    can fetch_user_profile with `root entry;

    # Suggest Roles
    can suggest_roles with `root entry;
}


# Retrieve user profile i.e skills, interests and certification
walker get_user_profile {
    has user_profile: UserProfile = UserProfile([], [], []);

    can visit_memory with `root entry;

    can visit_skills with Memory entry;

    can add_skill with Skill entry;

    can visit_interests with Memory entry;

    can add_interest with Interest entry;

    can visit_certifications with Memory entry;

    can add_certification with Certification entry;

}

# Retrieve user target roles (Used in dashboard to display user's target roles)
walker get_user_target_roles {
    has target_roles: list[Role] = [];

    can fetch_target_roles with `root entry;
}

# Retrieve roadmap for a target role 
walker get_road_map {
    has role_title: str = "";
    has learning_path: str | any = "";
    has disk_path: str = "";

    can fetch_learning_path with `root entry;

    can return_learning_path with LearningPath entry;

}

# Update user profile i.e add/remove skills, interests and certs
walker update_user_profile {

    has updated_skills: list[dict] = [];
    has updated_interests: list[dict] = [];
    has updated_certifications: list[dict] = [];

    can visit_memory with `root entry;

    can add_new_skills with Memory entry;

    can delete_skill with Skill entry;

    can add_new_interests with Memory entry;

    can delete_interest with Interest entry;

    can add_new_certifications with Memory entry;

    can delete_certification with Certification entry;
}

# delete entire user profile
walker delete_user_profile {
    can visit_memory with `root entry;

    can delete_memory with Memory entry;

    can delete_skill with Skill entry;

    can delete_interest with Interest entry;

    can delete_certification with Certification entry;
}

# Target role Agents
# create role requirements graph (Skills and certs required for a particular role)
walker create_role_requirements_graph {
    has role_title: str = "";
    has role_description: str = "";
    has required_skills: list = [];
    has required_certifications: list = [];

    can create_role with `root entry;

}


# retrieve roles from graph (Traverse target role graph and retrieve required certs and skills)
walker get_all_role_requirements {
    has role_title: str = "";
    has required_skills: list = [];
    has required_certifications: list = [];
    has role_requirements: RoleProfile = RoleProfile([], []);

    can visit_role with `root entry;

    can fetch_role_requirements with Role entry;
}

# Fetch live skills and certs from the web for a given target role
walker collect_role_requirements {
    has role_title: str = "";
    has role_description: str = "";
    has role_requirements: RoleProfile = RoleProfile([], []);

    # LLM function: extract skills + certs from title + description
    

    def get_role_requirements(role_title: str, role_description: str) -> RoleProfile
    by llm(method="ReAct", tools=([search_job_requirements]));

    can check_existing_target_role with `root entry;

    can collect_certs_and_skills with `root entry;

}


# Skill Gap Agents
# find skill gaps for a given role (Internal) (Compare target role graph and user profile)
walker find_skill_and_certification_gaps {
    
    has role_title: str = "";
    has user_profile: UserProfile = UserProfile([], [], []);
    has role_requirements: RoleProfile = RoleProfile([], []);
    has gaps: RoleProfile = RoleProfile([], []);


    
    def find_gaps_between_profiles(user_profile: UserProfile, role_requirements: RoleProfile) -> RoleProfile
    by llm(method="Reason");

    # collect skills and certs from user graph
    can fetch_user_profile with `root entry;


    # collect skills and certs from role requirements graph
    can fetch_role_requirements with `root entry;
    
    # compare and find gaps
    can find_gaps with `root entry;

    can save_identified_gaps_to_graph with `root entry;

}

# create skill-and-cert gap graph (Fully Internal)
walker create_skill_gap_graph {
    has gaps: RoleProfile = RoleProfile([], []);
    has role_title: str = "";
    has initial_gap: int = 0;
    has cert_count: int = 0;
    has skill_count: int = 0;

    can create_requirements_gap_node with `root entry;

    can create_role_requirements_gap_graph with RequirementsGap entry;
   
}

# update Skill gap graph.
walker update_skill_gap_graph {
    has completed_skills: list = [];
    has completed_certifications: list = [];
    has role_title: str = "";

    can visit_requirements_gap with `root entry;

    can visit_skills with RequirementsGap entry;

    can visit_certifications with RequirementsGap entry;

    can update_skills with Skill entry;

    can update_certifications with Certification entry;

}

# adds completed skills  to main user profile graph (Fully Internal)
walker add_completed_skill_to_user_profile {
    has completed_skill: Skill = Skill("", "");

    can visit_memory with `root entry;

    can add_skill with Memory entry;
}

# Add completed certifications to user's main profile graph (Fully Internal)
walker add_completed_certification_to_user_profile {
    has completed_certification: Certification = Certification("", "", "");

    can visit_memory with `root entry;

    can add_certification with Memory entry;
}

# Check skill/certification progress
walker check_progress {
    has current_gap: int = 0;
    has role_title: str = "";

    can visit_requirements_gap_node with `root entry;

    can check_learning_progress with RequirementsGap entry;
}

# Retrieve Skill gap graph
walker retrieve_skill_gaps {
    has gaps: RoleProfile = RoleProfile([], []);
    has role_title: str = "";

    can visit_requirements_gap_node with `root entry;

    can visit_skills with RequirementsGap entry;

    can visit_certs with RequirementsGap entry;

    can retrieve_skills with Skill entry;

    can retrieve_certifications with Certification entry;
}


# recommend learning paths to fill skill gaps
walker recommend_learning_paths {
    has gaps: RoleProfile = RoleProfile([], []);
    has user_profile: UserProfile = UserProfile([], [], []);
    has target_role_requirements: RoleProfile = RoleProfile([], []);
    has role_title: str = "";


    def suggest_learning_paths(gaps: RoleProfile, user_profile: UserProfile, target_role_requirements: RoleProfile) -> LearningPath
    by llm(method="ReAct", tools=([search_learning_resources, search_learning_links]));

    can check_existing_learning_path  with `root entry;

    can fetch_gaps with `root entry;

    can fetch_role_requirements with `root entry;

    can fetch_user_profile with `root entry;

    can recommend_path with `root entry;
}

with entry {
    load_dotenv();
    let SERPER_API_KEY = os.getenv('SERPER_API_KEY');
    let FIRECRAWL_API_KEY = os.getenv('FIRECRAWL_API_KEY');
    let firecrawl = FirecrawlApp(api_key=FIRECRAWL_API_KEY);
}
