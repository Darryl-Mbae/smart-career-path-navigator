cl import from .pages.Website { Website }
cl import from react { useEffect }
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
        
        let viewport = document.createElement('meta');
        viewport.name = 'viewport';
        viewport.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
        document.head.appendChild(viewport);

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
import from backend.models.Models { 
    Memory,
    Resume,
    Skill,
    Role,
    Certification,
    Interest,
    RequirementsGap,
    LearningPath
}

import from backend.relationships.Relationships {
    skilled_in,
    has_certification,
    interested_in,
    requires_skill,
    requires_certification,
    has_skill_gap,
    has_certification_gap
}

import from backend.tools.Tools {
    is_valid_url,
    search_job_urls,
    search_job_requirements,
    fetch_careerjet_descriptions,
    search_urls,
    extract_markdown,
    search_learning_resources,
    is_learning_url,
    search_learning_links
}
import from backend.helpers.Helpers { read_document_text }


glob llm = Model(model_name="gemini/gemini-2.5-flash", verbose=True);

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


    def suggest_learning_paths(gaps: RoleProfile, user_profile: UserProfile, target_role_requirements: RoleProfile) -> str
    by llm(method="ReAct", tools=([search_learning_resources, search_learning_links]));

    can check_existing_learning_path  with `root entry;

    can fetch_gaps with `root entry;

    can fetch_role_requirements with `root entry;

    can fetch_user_profile with `root entry;

    can recommend_path with `root entry;
}

def _utc_now_dt() -> any {
    return datetime.datetime.utcnow().replace(microsecond=0);
}

def _iso_from_dt(dt:any) -> str {
    return dt.isoformat() + "Z";
}

def _eat_from_utc_dt(dt:any) -> str {
    let eat_dt = dt + datetime.timedelta(hours=3);
    return eat_dt.strftime("%Y-%m-%d %H:%M:%S EAT");
}

def _safe_str(x:any) -> str {
    if x == None { return ""; }
    return str(x);
}

def _contains(hay:any, needle:any) -> bool {
    let h = _safe_str(hay).lower();
    let n = _safe_str(needle).lower();
    if h == "" or n == "" { return False; }
    return h.find(n) != -1;
}

def _normalize_title_for_freq(title:any) -> str {
    let t = _safe_str(title).strip();
    if t == "" { return ""; }

    let lowers = t.lower();

    let tokens = ["senior", "jr", "junior", "lead", "principal", "intern", "internship", "mid-level", "mid level"];
    for w in tokens {
        lowers = lowers.replace(w, "");
    }

    let parts = lowers.split();
    let out = "";
    for p in parts {
        if p.strip() == "" { continue; }
        if out == "" { out = p; }
        else { out = out + " " + p; }
    }

    return out.title();
}


def fetch_remotive_jobs(max_items:int = 25) -> list[dict] {
    let url = "https://remotive.com/api/remote-jobs";

    try {
        let resp = requests.get(
            url,
            timeout=25,
            headers={
                "User-Agent":"Mozilla/5.0",
                "Accept":"application/json"
            }
        );

        let ct = _safe_str(resp.headers.get("Content-Type", "")).lower();
        print("[REMOTIVE]", resp.status_code, ct);

        if resp.status_code != 200 { return []; }
        if ct.find("application/json") == -1 { return []; }

        let data = None;
        try { data = resp.json(); }
        except Exception as e {
            try { data = json.loads(resp.text); }
            except Exception as e2 { return []; }
        }

        let jobs = data.get("jobs", []) if data else [];
        if jobs == None { jobs = []; }

        let out = [];
        for j in jobs {
            if len(out) >= max_items { break; }
            if j == None { continue; }

            let title = _safe_str(j.get("title", ""));
            let urlj = _safe_str(j.get("url", ""));
            if title.strip() == "" or urlj.strip() == "" { continue; }

            out.append({
                "id": "remotive:" + _safe_str(j.get("id", "x" + _safe_str(len(out)))),
                "title": title,
                "company": _safe_str(j.get("company_name", "")),
                "location": _safe_str(j.get("candidate_required_location", "Remote")),
                "url": urlj,
                "tags": j.get("tags", []) if j else [],
                "source": "Remotive",
                "posted": _safe_str(j.get("publication_date", ""))
            });
        }

        return out;

    } except Exception as e {
        print("[REMOTIVE ERROR]", e);
        return [];
    }
}

def fetch_remoteok_jobs(max_items:int = 25) -> list[dict] {
    let url = "https://remoteok.com/api";

    try {
        let resp = requests.get(
            url,
            timeout=25,
            headers={
                "User-Agent":"Mozilla/5.0",
                "Accept":"application/json",
                "Referer":"https://remoteok.com/"
            }
        );

        let ct = _safe_str(resp.headers.get("Content-Type", "")).lower();
        print("[REMOTEOK]", resp.status_code, ct);

        if resp.status_code != 200 { return []; }
        if ct.find("application/json") == -1 { return []; }

        let data = None;
        try { data = resp.json(); }
        except Exception as e {
            try { data = json.loads(resp.text); }
            except Exception as e2 { return []; }
        }

        if data == None or len(data) == 0 { return []; }

        let out = [];
        for j in data {
            if len(out) >= max_items { break; }
            if j == None { continue; }

            let position = _safe_str(j.get("position", ""));
            if position.strip() == "" { continue; }

            let urlj = _safe_str(j.get("url", ""));
            if urlj.strip() == "" { urlj = _safe_str(j.get("apply_url", "")); }
            if urlj.strip() == "" { continue; }

            out.append({
                "id": "remoteok:" + _safe_str(j.get("id", "x" + _safe_str(len(out)))),
                "title": position,
                "company": _safe_str(j.get("company", "")),
                "location": _safe_str(j.get("location", "Remote")),
                "url": urlj,
                "tags": j.get("tags", []) if j else [],
                "source": "RemoteOK",
                "posted": _safe_str(j.get("date", ""))
            });
        }

        return out;

    } except Exception as e {
        print("[REMOTEOK ERROR]", e);
        return [];
    }
}

def fetch_arbeitnow_jobs(max_items:int = 25) -> list[dict] {
    let url = "https://www.arbeitnow.com/api/job-board-api";

    try {
        let resp = requests.get(
            url,
            timeout=25,
            headers={
                "User-Agent":"Mozilla/5.0",
                "Accept":"application/json"
            }
        );

        let ct = _safe_str(resp.headers.get("Content-Type", "")).lower();
        print("[ARBEITNOW]", resp.status_code, ct);

        if resp.status_code != 200 { return []; }
        if ct.find("application/json") == -1 { return []; }

        let data = None;
        try { data = resp.json(); }
        except Exception as e {
            try { data = json.loads(resp.text); }
            except Exception as e2 { return []; }
        }

        let jobs = data.get("data", []) if data else [];
        if jobs == None { jobs = []; }

        let out = [];
        for j in jobs {
            if len(out) >= max_items { break; }
            if j == None { continue; }

            let title = _safe_str(j.get("title", ""));
            let urlj = _safe_str(j.get("url", ""));
            if title.strip() == "" or urlj.strip() == "" { continue; }

            out.append({
                "id": "arbeitnow:" + _safe_str(j.get("slug", "x" + _safe_str(len(out)))),
                "title": title,
                "company": _safe_str(j.get("company_name", "")),
                "location": _safe_str(j.get("location", "")),
                "url": urlj,
                "tags": j.get("tags", []) if j else [],
                "source": "Arbeitnow",
                "posted": ""
            });
        }

        return out;

    } except Exception as e {
        print("[ARBEITNOW ERROR]", e);
        return [];
    }
}

# ---------------------------
#          helpers 
# ---------------------------

def _filter_jobs_by_focus(jobs:any, focus:any) -> list[dict] {
    if focus == None { return jobs if jobs else []; }

    let f = _safe_str(focus).strip().lower();
    if f == "" or f == "all" { return jobs if jobs else []; }

    let out = [];
    for j in (jobs if jobs else []) {
        if j == None { continue; }

        let title = _safe_str(j.get("title", "")).lower();
        let tags = j.get("tags", []) if j else [];

        let tag_join = "";
        for t in (tags if tags else []) {
            let ts = _safe_str(t).lower();
            if ts.strip() == "" { continue; }
            if tag_join == "" { tag_join = ts; }
            else { tag_join = tag_join + " " + ts; }
        }

        if _contains(title, f) or _contains(tag_join, f) {
            out.append(j);
        }
    }

    return out;
}

def _freq_top(items:any, top_n:int = 10) -> list[str] {
    let freq = {};

    for x in (items if items else []) {
        let s = _safe_str(x).strip();
        if s == "" { continue; }

        if s in freq { freq[s] = freq[s] + 1; }
        else { freq[s] = 1; }
    }

    let pairs = [];
    for k in freq.keys() {
        pairs.append({"k": k, "v": freq[k]});
    }

    let i = 0;
    while i < len(pairs) {
        let j = i + 1;
        while j < len(pairs) {
            if pairs[j]["v"] > pairs[i]["v"] {
                let tmp = pairs[i];
                pairs[i] = pairs[j];
                pairs[j] = tmp;
            }
            j = j + 1;
        }
        i = i + 1;
    }

    let out = [];
    let idx = 0;
    while idx < len(pairs) and len(out) < top_n {
        out.append(_safe_str(pairs[idx]["k"]));
        idx = idx + 1;
    }

    return out;
}

def _build_snapshot_from_jobs(jobs:any) -> dict {
    let role_titles = [];
    let tags = [];

    for j in (jobs if jobs else []) {
        if j == None { continue; }

        let t = _normalize_title_for_freq(j.get("title", ""));
        if t != "" { role_titles.append(t); }

        let jt = j.get("tags", []) if j else [];
        for tag in (jt if jt else []) {
            let tg = _safe_str(tag).strip();
            if tg != "" { tags.append(tg); }
        }
    }

    let top_roles = _freq_top(role_titles, top_n=12);
    let top_skills = _freq_top(tags, top_n=16);

    return {
        "top_roles": top_roles,
        "top_skills": top_skills
    };
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

impl live_job_market_trends_notifications.run {
    let utc_dt = _utc_now_dt();
    let generated_time_utc = _iso_from_dt(utc_dt);
    let generated_time_local = _eat_from_utc_dt(utc_dt);

    let jobs_list = [];

    let r1 = fetch_remotive_jobs(max_items=self.max_jobs_per_source);
    time.sleep(1);
    let r2 = fetch_remoteok_jobs(max_items=self.max_jobs_per_source);
    time.sleep(1);
    let r3 = fetch_arbeitnow_jobs(max_items=self.max_jobs_per_source);

    print("[COUNTS] remotive=", len(r1), " remoteok=", len(r2), " arbeitnow=", len(r3));

    for j in (r1 if r1 else []) { jobs_list.append(j); }
    for j in (r2 if r2 else []) { jobs_list.append(j); }
    for j in (r3 if r3 else []) { jobs_list.append(j); }

    jobs_list = _filter_jobs_by_focus(jobs_list, self.focus);

    if jobs_list == None or len(jobs_list) == 0 {
        report {
            "status": "Fail",
            "message": "No live jobs found (all sources returned empty after parsing).",
            "body": {
                "generated_time_utc": generated_time_utc,
                "generated_time_local": generated_time_local,
                "debug_counts": {
                    "remotive": len(r1),
                    "remoteok": len(r2),
                    "arbeitnow": len(r3)
                },
                "summary": "",
                "notifications": [],
                "highlighted_roles": [],
                "high_demand_skills": [],
                "jobs": [],
                "sources": ["Remotive", "RemoteOK", "Arbeitnow"]
            }
        };
        return;
    }

    let snap = _build_snapshot_from_jobs(jobs_list);
    let top_roles = snap.get("top_roles", []) if snap else [];
    let top_skills = snap.get("top_skills", []) if snap else [];

    let notifications = [];

    let role_str = "";
    let i = 0;
    while i < len(top_roles) and i < 8 {
        if role_str == "" { role_str = _safe_str(top_roles[i]); }
        else { role_str = role_str + ", " + _safe_str(top_roles[i]); }
        i = i + 1;
    }

    let skill_str = "";
    let k = 0;
    while k < len(top_skills) and k < 10 {
        if skill_str == "" { skill_str = _safe_str(top_skills[k]); }
        else { skill_str = skill_str + ", " + _safe_str(top_skills[k]); }
        k = k + 1;
    }

    notifications.append({
        "id": "snapshot:" + utc_dt.strftime("%Y%m%d%H%M%S"),
        "type": "event",
        "title": "Live global hiring snapshot",
        "description": (
            "Top roles trending now: " + role_str + ". "
            + "High-demand skills: " + skill_str + ". "
            + "Open jobs below are pulled live from public sources."
        ),
        "time": generated_time_utc,
        "local_time": generated_time_local,
        "url": jobs_list[0].get("url", "") if jobs_list and len(jobs_list) > 0 else "",
        "read": False
    });

    let idx = 0;
    while idx < len(jobs_list) and len(notifications) < (self.max_notifications + 1) {
        let j = jobs_list[idx];
        if j == None { idx = idx + 1; continue; }

        let title = _safe_str(j.get("title", ""));
        let company = _safe_str(j.get("company", ""));
        let loc = _safe_str(j.get("location", ""));
        let src = _safe_str(j.get("source", ""));
        let urlj = _safe_str(j.get("url", ""));
        let tags = j.get("tags", []) if j else [];

        if title.strip() == "" or urlj.strip() == "" { idx = idx + 1; continue; }

        let tag_line = "";
        let t = 0;
        while t < len(tags) and t < 6 {
            let tg = _safe_str(tags[t]).strip();
            if tg != "" {
                if tag_line == "" { tag_line = tg; }
                else { tag_line = tag_line + ", " + tg; }
            }
            t = t + 1;
        }

        let desc = "";
        if loc.strip() != "" { desc = "Location: " + loc + ". "; }
        if src.strip() != "" { desc = desc + "Source: " + src + ". "; }
        if tag_line != "" { desc = desc + "Skills: " + tag_line + "."; }

        notifications.append({
            "id": _safe_str(j.get("id", "job:" + _safe_str(idx))),
            "type": "success",
            "title": (title + (" — " + company if company.strip() != "" else "")),
            "description": desc,
            "time": generated_time_utc,
            "local_time": generated_time_local,
            "url": urlj,
            "read": False
        });

        idx = idx + 1;
    }

    report {
        "status": "Success",
        "message": "Live job openings + trending roles/skills generated",
        "body": {
            "generated_time_utc": generated_time_utc,
            "generated_time_local": generated_time_local,
            "summary": "Live jobs pulled from Remotive, RemoteOK, and Arbeitnow (public endpoints).",
            "notifications": notifications,
            "highlighted_roles": top_roles,
            "high_demand_skills": top_skills,
            "jobs": jobs_list,
            "sources": ["Remotive", "RemoteOK", "Arbeitnow"]
        }
    };
}



glob career_llm = Model(
    model_name="gemini/gemini-2.5-flash",
    temperature=0.2,
    max_tokens=600,
    verbose=False
);
 
import re;

def clean_reply_text(text: str) -> str {
    if not text { return ""; }

    let s = "" + text;
    try {
        s = re.sub(r"(?i)^\s*smart\s+career\s+path\s+navigator\s*:\s*", "", s);
    } except Exception as e { }

    return s.strip();
}

glob history_by_user = {};

"""Generate a helpful, structured career guidance reply.
It should:
- Do NOT write or mention any assistant name (e.g., "Smart Career Path Navigator", "Arise", "Navigator").
- Do NOT prefix the answer with a name. Start directly with the content.
- Give clear, practical advice (short paragraphs + bullet-like lines).
- Consider the student's interests, skills and level.
- Suggest next actions (courses, projects, internships, skills).
- Ask at most ONE follow-up question when clarification is needed.

Style:
- Sound human and warm (1 short greeting line only during greetings).
- Then give structured, practical guidance.
- Plain text only (no Markdown like **bold**).
- Use compact sections if needed, but don’t over-label.
- some part should be in bullet points

Output format rules:
- DO NOT use Markdown syntax like **bold**, *italics*, or '- ' bullets.
- Use plain text only
use inform of paragaraph
  • ...
  Next Steps:
  1) ...
- Keep the answer compact but clear (around 10–15 short lines).
"""
def generate_career_answer(
    user_id: str,
    message: str,
    focus_area: str,
    history: list
) -> str by career_llm();

walker career_chat {
    has user_id: str = "";
    has message: str = "";
    has focus_area: str = "General guidance";

    obj __specs__ {
        static has methods: list = ["post"];
        static has auth: bool = False;
    }

    can chat with `root entry;
}

impl career_chat.chat {
    let uid = self.user_id;
    if not uid {
        uid = "anonymous";
    }

    if uid not in history_by_user {
        history_by_user[uid] = [];
    }

    let history = history_by_user[uid];
    let raw_reply = generate_career_answer(
        uid,
        self.message,
        self.focus_area,
        history
    );

    let reply_text = clean_reply_text(raw_reply);


    history.append({
        "from_user": True,
        "text": self.message,
        "focus_area": self.focus_area
    });

    history.append({
        "from_user": False,
        "text": reply_text,
        "focus_area": self.focus_area
    });

    history_by_user[uid] = history;

    report {
        "reply": reply_text,
        "history": history
    };
}


with entry {
    load_dotenv();
    let SERPER_API_KEY = os.getenv('SERPER_API_KEY');
    let FIRECRAWL_API_KEY = os.getenv('FIRECRAWL_API_KEY');
    let firecrawl = FirecrawlApp(api_key=FIRECRAWL_API_KEY);
}
