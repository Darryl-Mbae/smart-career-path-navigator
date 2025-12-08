# Backend Models
node Memory {
    has email: str = "";
    has full_name: str = "";
    has resume_uploaded: bool = False;
    
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

node RequirementsGap {
    has role_title: str = "";
    has progress: int = 0;
}

# learning path node
node LearningPath {
    has role_title: str = "";
    has learning_path: str = "";
}

# Used by get_user_profile agent to aggregate user's skills. interests and certifications and report back to FE
node End{
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