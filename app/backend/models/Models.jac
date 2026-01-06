node Memory {
    has email: str = "";
    has full_name: str = "";
    has resume_uploaded: bool = False;
}


node Resume {
    has name: str = "";
    has file_path: str = "";
    has mime: str = "";
    has content: any = None;
# will store decoded bytes
 }


node Skill {
    has name: str = "";
    has description: str = "";
}


node Role {
    has title: str = "";
    has description: str = "";
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
    has initial_gap: int = 0;
    has progress: int = 0;
}


# learning path node
 node LearningPath {
    has role_title: str = "";
    has learning_path: str = "";
    # Actual learning path in markdown format
     has disk_path: str = "";
# Path where learning path markdown is saved in memory
 }


obj UserProfile {
    has skills: list[Skill];
    has certifications: list[Certification];
    has interests: list[Interest];
}


obj RoleProfile {
    has skills: list[Skill];
    has certifications: list[Certification];
}
