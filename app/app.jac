import from byllm.lib { Model }
import datetime;
import time;
import from dotenv { load_dotenv }
import base64;
import re;
import os;
import PyPDF2;
import docx;
import requests;
import json;
import from firecrawl { FirecrawlApp }
import from backend.models.Models { Memory, Resume, Skill, Role, Certification, Interest, RequirementsGap, LearningPath, UserProfile, RoleProfile }
import from backend.relationships.Relationships { skilled_in, has_certification, interested_in, requires_skill, requires_certification, has_skill_gap, has_certification_gap }
import from backend.tools.Tools { is_valid_url, search_job_urls, search_job_requirements, fetch_careerjet_descriptions, search_urls, extract_markdown, search_learning_resources, is_learning_url, search_learning_links, fetch_remotive_jobs, fetch_remoteok_jobs, fetch_arbeitnow_jobs }
import from backend.helpers.Helpers { read_document_text, _utc_now_dt, _iso_from_dt, _eat_from_utc_dt, _safe_str, _contains, _normalize_title_for_freq, _freq_top, _build_snapshot_from_jobs, _filter_jobs_by_focus, clean_reply_text }


glob llm = Model(model_name="gemini/gemini-2.5-flash", verbose=True);
glob career_llm =
    Model(model_name="gemini/gemini-2.5-flash", temperature=0.2, verbose=False);
glob history_by_user = {};


node End {
    has user_profile: UserProfile = UserProfile([], [], []);

    can aggregate_user_info with get_user_profile entry {
        self.user_profile = visitor.user_profile;
        print("Finished Aggregating User Profile...Now reporting..\n");
        report
        {"status" : "Success" , "message" : "User profile fetched successfully" , "body" :
        {"skills" : [ {"name" : s.name , "description" : s.description } for s in self.user_profile.skills ] , "interests" : [ {"name" : i.name , "description" : i.description } for i in self.user_profile.interests ] , "certifications" : [ {"title" : c.title , "provider" : c.provider , "url" : c.url } for c in self.user_profile.certifications ] } } ;
    }
}


walker initialize_memory {
    has email: str = "";
    has full_name: str = "";

    can initialize_memory with `root entry;
}


walker create_resume_node {
    can create_resume_node with `root entry;
}


walker upload_resume {
    has file: bytes = b"";
    has name: str = "";
    has mime: str = "";

    can visit_resume_node with `root entry;
    can upload_resume with Resume entry;
}


walker update_resume_upload_status {
    can check_memory with `root entry;
    can update_resume_upload_status with Memory entry;
}


walker check_resume_upload_status {
    can check_memory with `root entry;
    can check_resume_upload_status with Memory entry;
}


walker save_resume {
    can visit_resume with `root entry;
    can save_resume with Resume entry;
}


walker retrieve_resume {
    can visit_resume with `root entry;
    can retrieve_resume with Resume entry;
}


walker analyze_cv {
    has user_profile: UserProfile = UserProfile([], [], []);

    def extract_user_skills_from_cv(resume_text: str) -> UserProfile | None by llm(
        method="Reason"
    );

    can visit_resume with `root entry;
    can extract_user_skills with Resume entry;
}


walker get_user_details {
    can visit_memory with `root entry;
    can get_user_details with Memory entry;
}


walker create_user_graph {
    has user_profile: UserProfile = UserProfile([], [], []);

    can visit_memory with `root entry;
    can create_user_graph with Memory entry;
}


walker generate_role_suggestions {
    has user_profile: UserProfile = UserProfile([], [], []);

    def suggest_roles_based_on_profile(user_profile: UserProfile) -> list[Role] by llm(
        method="Reason"
    );

    can fetch_user_profile with `root entry;
    can suggest_roles with `root entry;
}


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


walker get_user_target_roles {
    has target_roles: list[Role] = [];

    can fetch_target_roles with `root entry;
}


walker get_road_map {
    has role_title: str = "";
    has learning_path: str | any = "";
    has disk_path: str = "";

    can fetch_learning_path with `root entry;
    can return_learning_path with LearningPath entry;
}


walker update_user_profile {
    has updated_skills: list[dict] = [];
    has updated_interests: list[dict] = [];
    has updated_certifications: list[dict] = [];
    has append_only: bool = False;

    can visit_memory with `root entry;
    can add_new_skills with Memory entry;
    can delete_skill with Skill entry;
    can add_new_interests with Memory entry;
    can delete_interest with Interest entry;
    can add_new_certifications with Memory entry;
    can delete_certification with Certification entry;
}


walker delete_user_profile {
    can visit_memory with `root entry;
    can delete_memory with Memory entry;
    can delete_skill with Skill entry;
    can delete_interest with Interest entry;
    can delete_certification with Certification entry;
}


walker remove_profile_item {
    has item_name: str;
    has item_type: str;
    has success: bool = False;
    has message: str = "Item not found";

    can visit_memory with `root entry;
    can find_item with Memory entry;
    can check_and_delete_skill with Skill entry;
    can check_and_delete_interest with Interest entry;
    can check_and_delete_certification with Certification entry;
}


walker create_role_requirements_graph {
    has role_title: str = "";
    has role_description: str = "";
    has required_skills: list = [];
    has required_certifications: list = [];

    can create_role with `root entry;
}


walker get_all_role_requirements {
    has role_title: str = "";
    has required_skills: list = [];
    has required_certifications: list = [];
    has role_requirements: RoleProfile = RoleProfile([], []);

    can visit_role with `root entry;
    can fetch_role_requirements with Role entry;
}


walker collect_role_requirements {
    has role_title: str = "";
    has role_description: str = "";
    has role_requirements: RoleProfile = RoleProfile([], []);

    def get_role_requirements(role_title: str, role_description: str) -> RoleProfile by llm(
        method="ReAct",
        tools=([search_job_requirements])
    );

    can check_existing_target_role with `root entry;
    can collect_certs_and_skills with `root entry;
}


walker find_skill_and_certification_gaps {
    has role_title: str = "";
    has user_profile: UserProfile = UserProfile([], [], []);
    has role_requirements: RoleProfile = RoleProfile([], []);
    has gaps: RoleProfile = RoleProfile([], []);

    def find_gaps_between_profiles(
        user_profile: UserProfile,
        role_requirements: RoleProfile
    ) -> RoleProfile by llm(method="Reason");

    can fetch_user_profile with `root entry;
    can fetch_role_requirements with `root entry;
    can find_gaps with `root entry;
    can save_identified_gaps_to_graph with `root entry;
}


walker create_skill_gap_graph {
    has gaps: RoleProfile = RoleProfile([], []);
    has role_title: str = "";
    has initial_gap: int = 0;
    has cert_count: int = 0;
    has skill_count: int = 0;

    can create_requirements_gap_node with `root entry;
    can create_role_requirements_gap_graph with RequirementsGap entry;
}


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


walker add_completed_skill_to_user_profile {
    has completed_skill: Skill = Skill("", "");

    can visit_memory with `root entry;
    can add_skill with Memory entry;
}


walker add_completed_certification_to_user_profile {
    has completed_certification: Certification = Certification("", "", "");

    can visit_memory with `root entry;
    can add_certification with Memory entry;
}


walker check_progress {
    has current_gap: int = 0;
    has initial_gap: int = 0;
    has progress: float = 0.0;
    has role_title: str = "";
    has success: bool = False;
    has error_message: str = "";

    can visit_requirements_gap_node with `root entry;
    can check_learning_progress with RequirementsGap entry;
    def maximize_role_match(role_title: str, available_roles: list) -> str by llm(
        method="Reason"
    );
}


walker retrieve_skill_gaps {
    has gaps: RoleProfile = RoleProfile([], []);
    has role_title: str = "";

    can visit_requirements_gap_node with `root entry;
    can visit_skills with RequirementsGap entry;
    can visit_certs with RequirementsGap entry;
    can retrieve_skills with Skill entry;
    can retrieve_certifications with Certification entry;
}


walker recommend_learning_paths {
    has gaps: RoleProfile = RoleProfile([], []);
    has user_profile: UserProfile = UserProfile([], [], []);
    has target_role_requirements: RoleProfile = RoleProfile([], []);
    has role_title: str = "";

    def suggest_learning_paths(
        gaps: RoleProfile,
        user_profile: UserProfile,
        target_role_requirements: RoleProfile
    ) -> str by llm(
        method="ReAct",
        tools=([search_learning_resources, search_learning_links])
    );

    can check_existing_learning_path with `root entry;
    can fetch_gaps with `root entry;
    can fetch_role_requirements with `root entry;
    can fetch_user_profile with `root entry;
    can recommend_path with `root entry;
}


walker live_job_market_trends_notifications {
    has location: str = "Kenya";
    has focus: str = "all";
    has max_jobs_per_source: int = 25;
    has max_notifications: int = 12;

    obj __specs__ {
        static has methods: list = ["post"];
        static has auth: bool = False;
    }

    can run with `root entry;
}


walker career_chat {
    has user_id: str = "";
    has message: str = "";
    has focus_area: str = "General guidance";
    has user_profile: UserProfile = UserProfile([], [], []);

    can chat with `root entry;
}


# Local Tools
 # Local Tools
 def add_skill_tool(name: str, description: str = "") -> str {
    if name {
        let sanitized_skills = [{"name" : name , "description" : description }];
        root spawn update_user_profile(
            updated_skills=sanitized_skills,
            append_only=True
        );
        return f"Skill '{name}' added successfully.";
    }
    return "No valid skill name provided.";
}


def add_certification_tool(title: str, provider: str = "", url: str = "") -> str {
    if title {
        let sanitized_certs = [{"name" : title , "provider" : provider , "url" : url }];
        root spawn update_user_profile(
            updated_certifications=sanitized_certs,
            append_only=True
        );
        return f"Certification '{title}' added successfully.";
    }
    return "No valid certification title provided.";
}


def add_interest_tool(name: str, description: str = "") -> str {
    if name {
        let sanitized_interests = [{"name" : name , "description" : description }];
        root spawn update_user_profile(
            updated_interests=sanitized_interests,
            append_only=True
        );
        return f"Interest '{name}' added successfully.";
    }
    return "No valid interest name provided.";
}


def get_target_roles_tool()  -> str {
    let roles_walker = root spawn get_user_target_roles();
    if roles_walker.target_roles {
        let roles_list =
            [ f"{r.title}: {r.description}" for r in roles_walker.target_roles ];
        return "Current target roles:\n" + "\n".join(roles_list);
    }
    return "No target roles found.";
}


def get_skill_gaps_tool(role_title: str) -> str {
    let gaps_walker = root spawn retrieve_skill_gaps(role_title=role_title);
    let out = f"Skill gaps for {role_title}:\n";
    let has_gaps = False;
    if gaps_walker.gaps.skills {
        out += "Missing Skills:\n";
        for s in gaps_walker.gaps.skills {
            out += f"- {s.name}: {s.description}\n";
        }
        has_gaps = True;
    }
    if gaps_walker.gaps.certifications {
        out += "Missing Certifications:\n";
        for c in gaps_walker.gaps.certifications {
            out += f"- {c.title} (Provider: {c.provider})\n";
        }
        has_gaps = True;
    }
    if not has_gaps {
        return f"No gaps identified for {role_title}. You seem to meet all identified requirements!";
    }
    return out;
}


def add_target_role_tool(role: str, description: str = "") -> str {
    if role {
        # Spawn the walker that collects requirements and creates the Role node
         # Spawn the walker that collects requirements and creates the Role node
         root spawn collect_role_requirements(
            role_title=role,
            role_description=description
        );
        return f"Target role '{role}' added successfully. I am now analyzing industry requirements for this role...";
    }
    return "No valid role title provided.";
}


def check_progress_tool(role: str) -> str {
    if not role {
        return "No role provided to check progress.";
    }
    try {
        let progress_walker = root spawn check_progress(role_title=role);
        if progress_walker.success {
            return f"Your progress for **{progress_walker.role_title}**: {progress_walker.progress}% complete. Remaining gaps: {progress_walker.current_gap} out of {progress_walker.initial_gap} total requirements.";
        } else {
            if progress_walker.error_message {
                return f"Could not calculate progress for {role}. {progress_walker.error_message}";
            }
            return f"Could not calculate progress for {role}. Please ensure you have this target role set up with requirements.";
        }
    } except Exception as e {
        return f"Error checking progress for {role}: {str(e)}";
    }
}


def get_roadmap_tool(role: str) -> str {
    if not role {
        return "Please specify a role to view the roadmap for.";
    }
    try {
        let walker = root spawn get_road_map(role_title=role);
        if walker.learning_path and len(walker.learning_path) > 0  {
            return f"**Roadmap for {role}**\n\n{walker.learning_path}";
        }
        return f"No existing roadmap found for {role}. You can ask me to 'generate a roadmap' for this role.";
    } except Exception as e {
        return f"Error retrieving roadmap: {str(e)}";
    }
}


def get_user_profile_tool()  -> str {
    try {
        let walker = root spawn get_user_profile();
        if not walker.user_profile {
            return "Your profile is currently empty. Tell me about your skills!";
        }
        let p = walker.user_profile;
        let skill_list =
            ", ".join([ s.name for s in p.skills ]) if p.skills else "None";
        let cert_list =
            ", ".join([ c.title for c in p.certifications ])
            if p.certifications
            else "None";
        let interest_list =
            ", ".join([ i.name for i in p.interests ]) if p.interests else "None";
        return f"**User Profile**\n\n- **Skills**: {skill_list}\n- **Certifications**: {cert_list}\n- **Interests**: {interest_list}";
    } except Exception as e {
        return f"Error fetching profile: {str(e)}";
    }
}


def get_job_notifications_tool()  -> str {
    try {
        # Limit to 5 per source for speed
        let walker =
            root spawn live_job_market_trends_notifications(
                max_jobs_per_source=5,
                location="Remote"
            );
        if walker.success {
            let notifications = walker.notifications;
            if not notifications {
                return "No current job notifications found.";
            }
            let out = "**Live Job Market Trends:**\n\n";
            let count = 0;
            for n in notifications {
                # Filter for actual job entries (type='success')
                 if n.get("type") == "success" {
                    let title = n.get("title");
                    let url = n.get("url");
                    let desc = n.get("description");
                    out += f"- **[{title}]({url})**\n  {desc}\n\n";
                    count += 1;
                    if count >= 5 {
                        break;
                    }
                }
            }
            if count == 0 {
                return "No specific job openings found right now.";
            }
            return out;
        }
        if walker.error_message {
            return f"Unable to fetch job notifications: {walker.error_message}";
        }
        return "Unable to fetch job notifications at this time.";
    } except Exception as e {
        return f"Error checking job market: {str(e)}";
    }
}


def get_role_requirements_tool(role: str) -> str {
    if not role {
        return "Please specify a role to check requirements for.";
    }
    try {
        let walker = root spawn get_all_role_requirements(role_title=role);
        if walker.role_requirements {
            let r = walker.role_requirements;
            if not r.skills and not r.certifications  {
                return f"No requirements found for {role}.";
            }
            let skills =
                ", ".join([ s.name for s in r.skills ]) if r.skills else "None";
            let certs =
                ", ".join([ c.title for c in r.certifications ])
                if r.certifications
                else "None";
            return f"**Requirements for {role}**\n\n- **Skills**: {skills}\n- **Certifications**: {certs}";
        }
        return f"Could not find requirements for {role}.";
    } except Exception as e {
        return f"Error retrieving requirements: {str(e)}";
    }
}


def remove_skill_tool(skill: str) -> str {
    if not skill {
        return "Please provide the skill name to remove.";
    }
    try {
        let walker = root spawn remove_profile_item(item_name=skill, item_type="skill");
        if walker.success {
            return f"✅ removed **{skill}** from your profile.";
        }
        return f"Could not remove **{skill}**. {walker.message}";
    } except Exception as e {
        return f"Error removing skill: {str(e)}";
    }
}


def remove_certification_tool(certification: str) -> str {
    if not certification {
        return "Please provide the certification name to remove.";
    }
    try {
        let walker =
            root spawn remove_profile_item(
                item_name=certification,
                item_type="certification"
            );
        if walker.success {
            return f"✅ removed **{certification}** from your profile.";
        }
        return f"Could not remove **{certification}**. {walker.message}";
    } except Exception as e {
        return f"Error removing certification: {str(e)}";
    }
}


def remove_interest_tool(interest: str) -> str {
    if not interest {
        return "Please provide the interest name to remove.";
    }
    try {
        let walker =
            root spawn remove_profile_item(item_name=interest, item_type="interest");
        if walker.success {
            return f"✅ removed **{interest}** from your profile.";
        }
        return f"Could not remove **{interest}**. {walker.message}";
    } except Exception as e {
        return f"Error removing interest: {str(e)}";
    }
}


"""You are a helpful, professional, and concise career assistant named Arise AI.

Your goal is to have a natural conversation.
- If the user greets you or engages in small talk, respond warmly and briefly without diving into career advice immediately.
- Only use the provided `user_profile` (skills, certifications, interests) when it is relevant to the user's query or when they ask for personalized guidance.
- If a user mentions new skills, certifications, or interests they have acquired, use the appropriate tools to add them to their profile.
- If a user asks about their skill gaps for a specific role, use `get_skill_gaps_tool`.
- If a user asks about their progress or how much they have completed for a role, use `check_progress_tool` with the exact role title.
- If a user asks about progress for ALL their target roles or "my roles", first use `get_target_roles_tool` to get the list of roles, then use `check_progress_tool` for EACH role individually and combine the results in your response.
- If a user asks to see, view, or get their learning path or roadmap for a role, use `get_roadmap_tool`.
- If a user asks to see their profile, skills, or what you know about them, use `get_user_profile_tool`.
- If a user asks about job trends, open positions, or market data, use `get_job_notifications_tool`.
- If a user asks about the requirements for a specific role (without asking for gaps), use `get_role_requirements_tool`.
- If a user asks what target roles they have or what roles they are working towards, use `get_target_roles_tool`.
- If a user wants to add, set, or pursue a new target role, use `add_target_role_tool`. This will also automatically fetch requirements for that role.
- Always confirm with the user after successfully adding new information to their profile.
- If a user asks to remove a skill, certification, or interest, use the appropriate removal tool (`remove_skill_tool` etc.).
- Keep your responses concise and direct. Avoid being overly verbose or repetitive.
- Use Markdown (bold, lists) for clarity when helpful, but don't force a specific structure if a simple paragraph is better.
- When tools return successful results, USE those results in your response. Do not claim a tool failed if it returned valid data.
"""
def generate_career_answer(
    user_id: str,
    message: str,
    focus_area: str,
    history: list,
    user_profile: UserProfile
) -> str by career_llm(
    method="ReAct",
    tools=
    [add_skill_tool,
    add_certification_tool,
    add_interest_tool,
    get_target_roles_tool,
    get_skill_gaps_tool,
    add_target_role_tool,
    check_progress_tool,
    get_roadmap_tool,
    get_user_profile_tool,
    get_job_notifications_tool,
    get_role_requirements_tool,
    remove_skill_tool,
    remove_certification_tool,
    remove_interest_tool]
);


with entry {
    load_dotenv();
    let SERPER_API_KEY = os.getenv('SERPER_API_KEY');
    let FIRECRAWL_API_KEY = os.getenv('FIRECRAWL_API_KEY');
    let firecrawl = FirecrawlApp(api_key=FIRECRAWL_API_KEY);
}
