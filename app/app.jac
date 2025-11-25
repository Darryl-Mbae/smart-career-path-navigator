import from byllm.lib { Model }
import from dotenv { load_dotenv }
import base64;
import re;
import os;
import PyPDF2;
import docx;

glob llm = Model(model_name="gemini/gemini-2.5-flash", verbose=False);

# --------------- Helpers ----------------
def read_document_text(file_path: str) -> str{
    """
    Reads a PDF or Word document (.docx) and returns extracted text.
    Returns an empty string if unreadable or unsupported.
    """;

    if not os.path.exists(file_path){
        print(f"[ERROR] File not found: {file_path}");
        return "";
    }
    file_path_lower = file_path.lower();

    try{
        # ----------------------
        # PDF READER
        # ----------------------
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
        # ----------------------
        # DOCX READER
        # ----------------------
        elif file_path_lower.endswith(".docx"){
            doc = docx.Document(file_path);
            text = "\n".join([para.text for para in doc.paragraphs]);
            return text.strip();
        }
        else{
            print(f"[ERROR] Unsupported file type: {file_path}");
            return "";
        }
    }
    except Exception as e {
        print(f"[ERROR] Failed to read document: {e}");
        return "";
    }

}

# ---------------- Backend Nodes ----------------

# Track resume upload status
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

# ---------------- Edges ----------------
edge skilled_in {}
edge has_certification {}
edge interested_in {}

obj UserProfile {
    has skills: list[Skill];
    has certifications: list[Certification];
    has interests: list[Interest];
}


# ---------------- Walkers ----------------

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
    has user_profile: UserProfile = UserProfile([], [], []);

    """
    You are an AI that extracts structured information ONLY from real CV/resume text.

    -------------------------------------
    ### TASK
    Given a block of text, determine whether it represents a CV/resume using common CV structure and words such as Experience, Skills, Referees, Education. 
    Do not analyze anything that does not look like a CV. Return None if it is not a CV.  If it is a CV, extract:

    - skills: list of Skill objects (Skill{name, description})
    - certifications: list of Certification objects (Certification{title, provider, url})
    - interests: list of Interest objects (Interest{name, description})

    Return a populated UserProfile.

    If the text is NOT a CV/resume, return None.

    If the document is not a CV → return None.

    -------------------------------------
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

        # ---------------- Edge Case Checks ----------------
        if not here.file_path {
            print("[WARN] No resume file path found");
            report {
                "status": "Fail",
                "message": "No resume file path found",
                "body": {}
            };
            disengage;
        }

        if not os.path.exists(here.file_path) {
            print(f"[WARN] File does not exist at path: {here.file_path}");
            report {
                "status": "Fail",
                "message": "Resume file does not exist on disk",
                "body": {}
            };
            disengage;
        }

        print(f"[INFO] Found resume file at: {here.file_path}");

        # ---------------- Extract Text ----------------
        let text = read_document_text(here.file_path);

        if not text {
            print("[WARN] Unable to extract text from resume");
            report {
                "status": "Fail",
                "message": "Unable to extract text from resume",
                "body": {}
            };
            disengage;
        }

        # ---------------- LLM Extraction ----------------
        try {
            self.user_profile = self.extract_user_skills_from_cv(text);
            print(f"[INFO] Extraction complete: {self.user_profile}");
        } except Exception as err {
            print(f"[ERROR] LLM extraction failed: {err}");
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
        


        # ---------------- Final Report ----------------
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
                "message": "User does not exist",
                "body": {}
            };
            disengage;
        }
    }

    can get_user_details with Memory entry {

        # ---------------- Edge Case Checks ----------------

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

        # ---------------- Final Success Report ----------------

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
    has user_profile: UserProfile = UserProfile([], [], []);

    can visit_memory with `root entry {
        print("Checking User Memory...");
        visit [-->(`?Memory)] else {
            report {"status": "Fail", "message": "No user found", "body": {}};
            disengage;
        }
    }

    can create_user_graph with Memory entry {
        print(f"Found user: {here.full_name}");

        # --------------------
        # Connect Skills
        # --------------------
        print("Saving skills...");
        for skill in self.user_profile.skills {

            # Check if Skill exists (by name)
            if [-->(`?Skill)](?name == skill.name) {
                print(f"Skipping duplicate skill: {skill.name}");
                continue;
            }

            # Create + link
            here +>:skilled_in:+> skill;
        }

        # --------------------
        # Connect Certifications (dedup by title)
        # --------------------
        print("Saving certifications...");
        for cert in self.user_profile.certifications {

            # Check if Certification exists
            if [-->(`?Certification)](?title == cert.title) {
                print(f"Skipping duplicate certification: {cert.title}");
                continue;
            }

            # Create + link
            here +>:has_certification:+> cert;
        }

        # --------------------
        # Connect Interests (dedup by name)
        # --------------------
        print("Saving interests...");
        for interest in self.user_profile.interests {

            # Check if Interest exists
            if [-->(`?Interest)](?name == interest.name) {
                print(f"Skipping duplicate interest: {interest.name}");
                continue;
            }

            # Create + link
            here +>:interested_in:+> interest;
        }

        # --------------------
        # Report
        # --------------------
        report {
            "status": "Success",
            "message": "User knowledge graph created",
            "body": {
                "skills": [s.name for s in self.user_profile.skills],
                "certifications": [c.title for c in self.user_profile.certifications],
                "interests": [i.name for i in self.user_profile.interests]
            }
        };
    }
}
 


with entry {
    load_dotenv();
}

cl import from react { useState }
cl import from 'lucide-react' { Mail, ChevronUp, ChevronLeft }
cl import from react { useState,useEffect }
cl import from 'lucide-react' { Mail,Brain, CloudUpload, Check, Goal, Route as Node, ChevronUp, ChevronLeft }
cl import from 'radix-ui' { Accordion }
cl import from "@jac-client/utils" {
    Router,
    Routes,
    Route,
    Link,
    useNavigate,
}



cl {

    def Website() -> any {

        def NavBar()  -> any {
            let links = ["CHANGELOG", "PRICING", "FAQs", "RESOURCES"];
            let [navbtnHover, setNavBtnHover] = useState("");
            let navigate = useNavigate();

            return <div
                style={{
                    "position": "sticky",
                    "border": "1px solid transparent",
                    "top": "1rem",
                    "zIndex": "99999",
                    "width": "calc(92% - 6px)",
                    "marginInline": "auto",
                    "paddingBlock": "1rem",
                    "paddingInline": "1.5rem",
                    "display": "flex",
                    "alignItems": "center",
                    "justifyContent": "space-between",
                    "color": "white",
                    "borderRadius": "0.375rem",
                    "transition": "all 200ms ease-in",
                    "backgroundColor": "rgba(0,0,0,.5)",
                    "backdropFilter": "blur(12px)"
                }}
            >
                <a
                    href="/app"
                    style={{
                        "fontSize": "1.125rem",
                        "fontWeight": "600",
                        "cursor": "pointer",
                        "color": "white",
                        "textDecoration": "none"
                    }}>
                    Arise
                </a>

                <div
                    style={{
                        "display": "flex", 
                        "alignItems": "center", 
                        "gap": "2rem"
                    }}
                >
                    <ul
                        style={{
                            "position": "relative",
                            "zIndex": "10",
                            "display": "flex",
                            "alignItems": "center",
                            "gap": "10px",
                            "listStyle": "none"
                        }}
                    >
                        {links.map(
                            lambda  link: any  -> any{ return <li
                                key={link}
                                style={{
                                    "position": "relative",
                                    "fontSize": "14px",
                                    "cursor": "pointer",
                                    "padding": "4px 8px",
                                    "borderRadius": "4px"
                                }}
                            >
                                {link}
                            </li>; }
                        )}
                    </ul>
                    <button
                        type="button"
                        onClick={lambda  e: any  -> None{navigate("/auth");}}
                        onMouseEnter={lambda  e: any  -> None{ setNavBtnHover(true);} }
                        onMouseLeave={lambda  e: any  -> None{ setNavBtnHover(false);} }
                        style={{
                            "width": "auto",
                            "backgroundColor": "#6e11b0",
                            "color": "white",
                            "border": "none",
                            "paddingInline": "2.5rem",
                            "paddingBlock": "1rem",
                            "borderRadius": "5px",
                            "cursor": "pointer",
                            "fontSize": "16px",
                            "transform": (
                                "translateY(0.25rem)" if navbtnHover else "translateY(0)"
                            ),
                            "transition": "transform 0.2s ease"
                        }}
                    >
                            Get Started
                    </button>

                </div>
            </div>;
        }

        def Homepage()  -> any {
            let [btn1Hover, setBtn1Hover] = useState(false);
            let [btn2Hover, setBtn2Hover] = useState(false);

            return <div
                style={{
                    "height": "70vh",
                    "width": "80%",
                    "marginInline": "auto",
                    "display": "flex",
                    "flexDirection": "column",
                    "color": "white",
                    "marginTop": "5vh"
                }}
            >
                <div
                    style={{
                        "padding": "0.635rem 1.375rem",
                        "borderRadius": "20px",
                        "backgroundColor": "#6e11b0",
                        "color": "white",
                        "width": "fit-content",
                        "marginBottom": "0.5rem"
                    }}
                >
                    Find Your Future
                </div>
                <h1
                    style={{
                        "fontWeight": "700",
                        "fontSize": "3.75rem",
                        "width": "60%",
                        "fontFamily": "'Zalando Sans SemiExpanded', sans-serif",
                        "lineHeight": "1"
                    }}
                >
                    AI-Powered Career Mapping for the Modern Workforce
                </h1>
                <p
                    style={{"fontSize": "18px", "width": "55%",}}
                >
                    Your skills tell a story. We analyze them, match them to emerging roles, and create a personalized growth roadmap — turning uncertainty into clarity and ambition into direction.
                </p>
                <div
                    style={{
                        "width": "40%",
                        "marginTop": "2rem",
                        "display": "flex",
                        "flexDirection": "row",
                        "gap": "1rem",
                        "alignItems": "center"
                    }}
                >
                    <button
                        type="button"
                        onMouseEnter={lambda  e: any  -> None{ setBtn1Hover(true);} }
                        onMouseLeave={lambda  e: any  -> None{ setBtn1Hover(false);} }
                        style={{
                            "width": "auto",
                            "backgroundColor": "#6e11b0",
                            "color": "white",
                            "border": "none",
                            "paddingInline": "2.5rem",
                            "paddingBlock": "1rem",
                            "borderRadius": "5px",
                            "cursor": "pointer",
                            "fontSize": "16px",
                            "transform": (
                                "translateY(0.25rem)" if btn1Hover else "translateY(0)"
                            ),
                            "transition": "transform 0.2s ease"
                        }}
                    >
                        Get Started
                    </button>
                    <button
                        type="button"
                        onMouseEnter={lambda  e: any  -> None{ setBtn2Hover(true);} }
                        onMouseLeave={lambda  e: any  -> None{ setBtn2Hover(false);} }
                        onClick={lambda  e: any  -> None{ let section = document.getElementById(
                            "demo"
                        );section?.scrollIntoView({behavior: "smooth"});} }
                        style={{
                            "width": "auto",
                            "border": "1px solid white",
                            "backgroundColor": "transparent",
                            "color": "white",
                            "paddingInline": "2.5rem",
                            "paddingBlock": "1rem",
                            "borderRadius": "5px",
                            "cursor": "pointer",
                            "fontSize": "16px",
                            "transform": (
                                "translateY(0.25rem)" if btn2Hover else "translateY(0)"
                            ),
                            "transition": "transform 0.2s ease"
                        }}
                    >
                        View Demo
                    </button>
                </div>
            </div>;
        }

        def Demo()  -> any {
            return <div
                id="demo"
                style={{
                    "width": "100%",
                    "height": "102vh",
                    "marginTop": "0.25rem",
                    "borderRadius": "50px",
                    "backgroundColor": "#6e11b0"
                }}
            ></div>;
        }

        def Features()  -> any {
            return <div>
                <h1>
                    Features
                </h1>
            </div>;
        }

        def Pricing()  -> any {
            return <div>
                <h1>
                    Pricing
                </h1>
            </div>;
        }

        def NewsletterSubscribe()  -> any {
            let [email, setEmail] = useState("");
            let [isSubmitting, setIsSubmitting] = useState(false);
            let [btnHover, setBtnHover] = useState(false);

            return <div
                style={{
                    "width": "88%",
                    "borderRadius": "1.5rem",
                    "marginInline": "auto",
                    "color": "white",
                    "padding": "4rem 1.5rem",
                    "marginTop": "4rem",
                    "marginBottom": "4rem",
                    "display": "flex",
                    "flexDirection": "column",
                    "alignItems": "center",
                    "justifyContent": "center",
                    "boxShadow": "0 25px 50px -12px rgba(0,0,0,0.25)"
                }}
            >
                <Mail
                    style={{
                        "width": "40px",
                        "height": "40px",
                        "marginBottom": "1rem",
                        "color": "#d8b4fe"
                    }}
                />
                <h2
                    style={{
                        "fontWeight": "bold",
                        "fontSize": "2.25rem",
                        "textAlign": "center",
                        "marginBottom": "1.75rem",
                        "width": "60%",
                        "fontFamily": "'Zalando Sans SemiExpanded', sans-serif"
                    }}
                >
                    Stay Ahead of the Curve
                </h2>
                <p
                    style={{
                        "fontSize": "16px",
                        "color": "#f5f5f5",
                        "textAlign": "center",
                        "marginBottom": "2rem",
                        "maxWidth": "36rem"
                    }}
                >
                    Get exclusive insights, product updates, and early accessdelivered straight to your inbox.
                </p>
                <form
                    style={{
                        "width": "50%",
                        "display": "flex",
                        "flexDirection": "row",
                        "gap": "1rem",
                        "marginInline": "auto"
                    }}
                >
                    <input
                        type="email"
                        placeholder="Enter your email"
                        value={email}
                        disabled={isSubmitting}
                        required
                        onChange={lambda  e: any  -> None{ setEmail(e.target.value);} }
                        style={{
                            "flexGrow": 1,
                            "padding": "1rem 1.25rem",
                            "borderRadius": "0.5rem",
                            "border": "none",
                            "backgroundColor": "#0b0b0b",
                            "color": "white",
                            "outline": "none",
                            "transition": "border 0.2s ease"
                        }}
                    />
                    <button
                        type="submit"
                        disabled={isSubmitting}
                        style={{
                            "width": "auto",
                            "padding": "1rem 1.5rem",
                            "border": "none",
                            "borderRadius": "0.5rem",
                            "backgroundColor": "#5b21b6",
                            "color": "white",
                            "fontWeight": "600",
                            "textTransform": "uppercase",
                            "fontSize": "0.875rem",
                            "cursor": "pointer",
                            "transform": (
                                "translateY(0.25rem)" if btnHover else "translateY(0)"
                            ),
                            "transition": "all 0.2s eFase",
                            "opacity": (0.5 if isSubmitting else 1),

                        }}
                    >
                        {"Subscribing..." if isSubmitting else "Subscribe"}
                    </button>
                </form>
            </div>;
        }

        def FAQs() -> any {
            let [arrow, setArrow] = useState(null);
            console.log(arrow);
            let faqData = [
                {
                    question: "How does Arise generate personalized career paths?",
                    answer: "Our **AI Career Engine** analyzes your skills, interests, work values, and personality traits through comprehensive assessments. It then matches these insights with labor market data, industry trends, and millions of career trajectories to generate tailored pathway recommendations with actionable steps.",
                    value: "career-generation",
                },
                {
                    question: "What is the accuracy of your job matching algorithm?",
                    answer: "Our matching algorithm achieves **92% accuracy** in identifying suitable roles based on user profiles and preferences. We continuously refine our models using feedback from successful placements and evolving job market data to improve match quality.",
                    value: "accuracy",
                },
                {
                    question: "Can Arise help me if I'm looking to change careers?",
                    answer: "Absolutely! **Career transition** is one of our core strengths. We identify transferable skills from your current experience, map them to new industries, and create step-by-step transition plans including skill gaps, recommended training, and timeline projections.",
                    value: "career-change",
                },
                {
                    question: "What platforms and integrations do you support?",
                    answer: "Arise integrates with **LinkedIn, Indeed, Glassdoor, and major job boards** to provide real-time opportunities. We also connect with learning platforms like Coursera and Udemy to recommend relevant courses, and offer a mobile app for on-the-go career guidance.",
                    value: "integrations",
                },
                {
                    question: "How is my personal data and career information protected?",
                    answer: "We prioritize your privacy with **end-to-end encryption** and strict data protection policies. Your career data, assessments, and job search activity are never shared with third parties without explicit consent. We comply with GDPR, CCPA, and industry-standard security protocols.",
                    value: "privacy-security",
                },
                {
                    question: "Do you provide ongoing career guidance or just one-time recommendations?",
                    answer: "Arise offers **continuous career guidance** that evolves with you. Our AI tracks your progress, updates recommendations based on skill development, monitors market changes, and provides quarterly career check-ins to ensure you stay on track toward your goals.",
                    value: "ongoing-support",
                },
                {
                    question: "Can I customize my career preferences and filters?",
                    answer: "Yes! You have full control to customize preferences including **salary expectations, location flexibility, work-life balance priorities, company culture, remote work options, and industry preferences**. Our recommendations adapt in real-time to your updated preferences.",
                    value: "customization",
                },
            ];
            return <div
                id="FAQs"
                style={{
                    "width": "88%",
                    "maxWidth": "56rem",
                    "marginInline": "auto",
                    "paddingBlock": "5rem",
                }}
            >
                <h2
                    style={{
                        "fontSize": "2.25rem",
                        "fontWeight": "bold",
                        "textAlign": "center",
                        "mmarginBottom": "2.5rem",
                        "color": "white"
                    }}
                >
                    Frequently Asked Questions
                </h2>
                <Accordion.Root
                    type="single"
                    collapsible
                >
                    {faqData.map(
                        lambda faq: any -> any { return <div>
                            <Accordion.Item
                                value={faq.value}
                                key={faq.value}
                                style={{
                                    "borderBottom": "1px solid rgba(255,255,255,0.1)",
                                    "backgroundColor": "#6e11b0",
                                    "padding": "1.75rem 1rem",
                                    "borderRadius": "0.5rem",
                                    "transition": "background-color 0.2s ease",
                                    "marginTop": "10px"
                                }}
                            >
                                <Accordion.Trigger
                                    onClick={lambda e: any -> None { setArrow(
                                        faq.value
                                    )
                                    if arrow != faq.value
                                    else setArrow(""); } }
                                    style={{
                                        "textAlign": "left",
                                        "fontSize": "1rem",
                                        "color": "white",
                                        "background": "none",
                                        "border": "none",
                                        "width": "100%",
                                        "cursor": "pointer",
                                        "display": "flex",
                                        "flexDirection": "row",
                                        "justifyContent": "space-between",
                                        "alignItems": "center"
                                    }}
                                >
                                    {faq.question}
                                    <ChevronUp
                                        style={{
                                            "transform": (
                                                "rotate(180deg)"
                                                if arrow == faq.value
                                                else "none"
                                            ),
                                            "transition": "all ease 0.3s"
                                        }}
                                    />
                                </Accordion.Trigger>
                                <Accordion.Content
                                    style={{
                                        "paddingTop": "0.5rem",
                                        "paddingBottom": "0",
                                        "color": "#d1d5db"
                                    }}
                                >
                                    {faq.answer}
                                </Accordion.Content>
                            </Accordion.Item>
                        </div>; }
                    )}
                </Accordion.Root>
            </div>;
        }

        def Footer() -> any {
            let currentYear = "2025";

            let socialLinks = [
                {
                    name: "Twitter",
                    href: "https://twitter.com/arisecareer",
                    path: "M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"
                },
                {
                    name: "Instagram",
                    href: "https://instagram.com/arisecareer",
                    path: "M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"
                },
                {
                    name: "GitHub",
                    href: "https://github.com/arisecareer",
                    path: "M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"
                },
                {
                    name: "LinkedIn",
                    href: "https://linkedin.com/company/arisecareer",
                    path: "M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"
                }
            ];

            let footerSections = [
                {
                    title: "Platform",
                    links: [
                        {label: "Career Assessment", href: "/assessment"},
                        {label: "Path Generator", href: "/paths"},
                        {label: "Job Matching", href: "/jobs"}
                    ]
                },
                {
                    title: "Resources",
                    links: [
                        {label: "Career Guides", href: "/guides"},
                        {label: "Skill Library", href: "/skills"},
                        {label: "Success Stories", href: "/stories"}
                    ]
                },
                {
                    title: "Company",
                    links: [
                        {label: "About Us", href: "/about"},
                        {label: "Contact", href: "/contact"},
                        {label: "Careers", href: "/careers"}
                    ]
                },
                {
                    title: "Support",
                    links: [
                        {label: "Help Center", href: "/help"},
                        {label: "API Docs", href: "/docs"},
                        {label: "Community", href: "/community"},
                        {label: "Report Issue", href: "/report"}
                    ]
                }
            ];

            let legalLinks = [
                {label: "Privacy Policy", href: "/privacy"},
                {label: "Terms of Service", href: "/terms"},
                {label: "Data Usage", href: "/data-policy"}
            ];

            return <footer
                style={{"paddingBlock": "3rem", "width": "100%"}}
            >
                <div
                    style={{
                        "width": "100%",
                        "maxWidth": "80rem",
                        "marginInline": "auto",
                        "paddingInline": "2rem"
                    }}
                >
                    <div
                        style={{
                            "backgroundColor": "#0b0b0b",
                            "borderRadius": "30px",
                            "boxShadow": "0 10px 15px -3px rgba(0, 0, 0, 0.1)",
                            "padding": "3rem"
                        }}
                    >
                        <div
                            style={{
                                "display": "grid",
                                "gridTemplateColumns": "repeat(5, 1fr)",
                                "gap": "2rem",
                                "paddingBottom": "2.5rem",
                                "borderBottom": "1px solid #2d2d2d"
                            }}
                        >
                            <div
                                style={{
                                    "gridColumn": "span 2",
                                    "display": "flex",
                                    "flexDirection": "column",
                                    "gap": "1.5rem"
                                }}
                            >
                                <div
                                    style={{
                                        "display": "flex",
                                        "alignItems": "center",
                                        "gap": "0.5rem"
                                    }}
                                >
                                    <svg
                                        style={{
                                            "width": "24px",
                                            "height": "24px",
                                            "color": "#10b981"
                                        }}
                                        fill="none"
                                        stroke="currentColor"
                                        viewBox="0 0 24 24"
                                    >
                                        <path
                                            strokeLinecap="round"
                                            strokeLinejoin="round"
                                            strokeWidth={2}
                                            d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"
                                        />
                                    </svg>
                                    <span
                                        style={{
                                            "fontSize": "1.5rem",
                                            "fontWeight": "700",
                                            "color": "white"
                                        }}
                                    >
                                        Arise
                                    </span>
                                </div>
                                <p
                                    style={{
                                        "fontSize": "0.875rem",
                                        "color": "#9ca3af",
                                        "maxWidth": "20rem",
                                        "lineHeight": "1.5"
                                    }}
                                >
                                    Empowering individuals to discover and navigate their ideal career paths through AI-driven insights, personalized recommendations, and continuous guidance.
                                </p>
                                <div
                                    style={{
                                        "display": "flex",
                                        "gap": "1rem",
                                        "paddingTop": "0.5rem"
                                    }}
                                >
                                    {socialLinks.map(
                                        lambda social: any -> any { return <a
                                            key={social.name}
                                            href={social.href}
                                            target="_blank"
                                            rel="noopener noreferrer"
                                            style={{
                                                "color": "#9ca3af",
                                                "cursor": "pointer",
                                                "transition": "color 0.2s"
                                            }}
                                        >
                                            <svg
                                                style={{
                                                    "width": "20px",
                                                    "height": "20px"
                                                }}
                                                fill="currentColor"
                                                viewBox="0 0 24 24"
                                            >
                                                <path
                                                    d={social.path}
                                                />
                                            </svg>
                                        </a>; }
                                    )}
                                </div>
                            </div>
                            <div
                                style={{
                                    "gridColumn": "span 3",
                                    "display": "grid",
                                    "gridTemplateColumns": "repeat(4, 1fr)",
                                    "gap": "1.5rem"
                                }}
                            >
                                {footerSections.map(
                                    lambda section: any -> any { return <div
                                        key={section.title}
                                        style={{
                                            "display": "flex",
                                            "flexDirection": "column",
                                            "gap": "1rem"
                                        }}
                                    >
                                        <h3
                                            style={{
                                                "fontSize": "1rem",
                                                "fontWeight": "600",
                                                "color": "white",
                                                "marginBottom": "0.5rem"
                                            }}
                                        >
                                            {section.title}
                                        </h3>
                                        {section.links.map(
                                            lambda link: any -> any { return <a
                                                key={link.href}
                                                href={link.href}
                                                style={{
                                                    "fontSize": "0.875rem",
                                                    "color": "#9ca3af",
                                                    "textDecoration": "none",
                                                    "cursor": "pointer"
                                                }}
                                            >
                                                {link.label}
                                            </a>; }
                                        )}
                                    </div>; }
                                )}
                            </div>
                        </div>
                        <div
                            style={{
                                "display": "flex",
                                "justifyContent": "space-between",
                                "alignItems": "center",
                                "paddingTop": "1.5rem",
                                "flexWrap": "wrap",
                                "gap": "1rem"
                            }}
                        >
                            <p
                                style={{"fontSize": "0.875rem", "color": "#6b7280"}}
                            >
                                © {currentYear} Arise. All rights reserved.
                            </p>
                            <div
                                style={{
                                    "display": "flex",
                                    "gap": "1.5rem",
                                    "fontSize": "0.875rem"
                                }}
                            >
                                {legalLinks.map(
                                    lambda link: any -> any { return <a
                                        key={link.href}
                                        href={link.href}
                                        style={{
                                            "color": "#6b7280",
                                            "textDecoration": "none",
                                            "cursor": "pointer",
                                            "whiteSpace": "nowrap"
                                        }}
                                    >
                                        {link.label}
                                    </a>; }
                                )}
                            </div>
                        </div>
                    </div>
                </div>
            </footer>;
        }

         return <div
            style={{
                "width": "100%",
                "minHeight": "100vh",
                "margin": "0px",
                "padding": "0px",
                "background": "black",
                "position": "relative",
                "fontFamily": "system-ui, sans-serif"
            }}
        > 
           
            <NavBar />
            <Homepage />
            <Demo />
            <Features />
            <Pricing />
            <NewsletterSubscribe />
            <FAQs />
            <Footer />
            
        </div>;
    }

    def Auth() -> any {
         let navigate = useNavigate();

        let [loginEmail, setLoginEmail] = useState("");
        let [loginPassword, setLoginPassword] = useState("");

        let [signupName, setSignupName] = useState("");
        let [signupEmail, setSignupEmail] = useState("");
        let [signupPassword, setSignupPassword] = useState("");

        let [isSignIn, setIsSignIn] = useState(True);
        let [error, setError] = useState("");

        def handleLogin(e: any) -> None {
            e.preventDefault();
            setError("");

            navigate("/onboarding");
            
        }

        def handleSignup(e: any) -> None {
            e.preventDefault();
            setError("");

          
            navigate("/onboarding");
        } 

        def Header(title: str) -> any {
            return <div
                style={{
                    "width": "calc(70% + 1.25rem)",
                    "textAlign": "left",
                    "marginBottom": "16px"
                }}
            >
                <div
                    onClick={lambda e: any -> None { navigate("/"); }}
                    style={{
                        "display": "flex",
                        "flexDirection": "row",
                        "alignItems": "center",
                        "color": "grey",
                        "cursor": "pointer",
                        "marginBottom": "8px"
                    }}
                >
                    <span><ChevronLeft /></span>
                    Back
                </div>
                <h2
                    style={{
                        "color": "white",
                        "margin": 0
                    }}
                >
                    {title}
                </h2>
            </div>;
        }


        return <div
            style={{
                "width": "100%",
                "height": "100vh",
                "display": "grid",
                "gridTemplateColumns": "50% 50%",
                "position": "relative",
                "color": "white"
            }}
            >
            <div
                style={{
                    "width": "100%",
                    "height": "100%",
                    "display": "flex",
                    "justifyContent": "center",
                    "alignItems": "center"
                }}
             >
                <div
                    style={{
                        "width": "100%",
                        "display": "flex",
                        "flexDirection": "column",
                        "alignItems": "center",
                        "padding": "24px",
                        "fontFamily": "'Inter', sans-serif"
                    }}
                    >
                    {Header("Welcome back")}
                    <form
                        onSubmit={handleLogin}
                        style={{
                            "width": "100%",
                            "display": "flex",
                            "flexDirection": "column",
                            "alignItems": "center"
                        }}
                    >
                        <input
                            type="email"
                            placeholder="Email"
                            value={loginEmail}
                            onChange={lambda e: any -> None { setLoginEmail(e.target.value); }}
                            style={{
                                "flexGrow": 1,
                                "padding": "1.25rem",
                                "borderRadius": "0.5rem",
                                "border": "none",
                                "backgroundColor": "#0b0b0b",
                                "color": "white",
                                "fontSize": "16px",
                                "width": "70%",
                                "outline": "none",
                                "marginBottom": "16px"
                            }}
                        />
                        <input
                            type="password"
                            placeholder="Password"
                            value={loginPassword}
                            onChange={lambda e: any -> None { setLoginPassword(e.target.value); }}
                            style={{
                                "flexGrow": 1,
                                "padding": "1.25rem",
                                "borderRadius": "0.5rem",
                                "border": "none",
                                "backgroundColor": "#0b0b0b",
                                "color": "white",
                                "fontSize": "16px",
                                "width": "70%",
                                "outline": "none",
                                "marginBottom": "16px"
                            }}
                        />
                        <button
                            type="submit"
                            style={{
                                "width": "calc(70% + 12px + 1.25rem)",
                                "padding": "1.25rem",
                                "borderRadius": "8px",
                                "border": "none",
                                "backgroundColor": "#6e11b0",
                                "color": "white",
                                "fontWeight": "600",
                                "fontSize": "15px",
                                "cursor": "pointer"
                            }}
                        >
                            Sign In
                        </button>
                    </form>
                    <p
                        style={{
                            "marginTop": "19px",
                            "fontSize": "14px",
                            "color": "#bbbbbb",
                            "textAlign": "center"
                        }}
                    >
                        Don't have an account?
                        <span
                            onClick={lambda e: any -> None { setIsSignIn(False); }}
                            style={{
                                "color": "#6e11b0",
                                "cursor": "pointer",
                                "fontWeight": "600",
                                "marginLeft": "5px"
                            }}
                        >
                            Sign Up
                        </span>
                    </p>
                </div>
            </div>

            <div
                style={{
                    "width": "100%",
                    "height": "100%",
                    "display": "flex",
                    "justifyContent": "center",
                    "alignItems": "center"
                }}
                >
                <div
                    style={{
                        "width": "100%",
                        "display": "flex",
                        "flexDirection": "column",
                        "alignItems": "center",
                        "padding": "24px",
                        "fontFamily": "'Inter', sans-serif"
                    }}
                >
                    {Header("Create your account")}
                    <form
                        onSubmit={handleSignup}
                        style={{
                            "width": "100%",
                            "display": "flex",
                            "flexDirection": "column",
                            "alignItems": "center"
                        }}
                    >
                        <input
                            type="text"
                            placeholder="Full Name"
                            value={signupName}
                            onChange={lambda e: any -> None { setSignupName(e.target.value); }}
                            style={{
                                "flexGrow": 1,
                                "padding": "1.25rem",
                                "borderRadius": "0.5rem",
                                "border": "none",
                                "backgroundColor": "#0b0b0b",
                                "color": "white",
                                "fontSize": "16px",
                                "width": "70%",
                                "outline": "none",
                                "marginBottom": "16px"
                            }}
                        />
                        <input
                            type="email"
                            placeholder="Email"
                            value={signupEmail}
                            onChange={lambda e: any -> None { setSignupEmail(e.target.value); }}
                            style={{
                                "flexGrow": 1,
                                "padding": "1.25rem",
                                "borderRadius": "0.5rem",
                                "border": "none",
                                "backgroundColor": "#0b0b0b",
                                "color": "white",
                                "fontSize": "16px",
                                "width": "70%",
                                "outline": "none",
                                "marginBottom": "16px"
                            }}
                        />
                        <input
                            type="password"
                            placeholder="Password"
                            value={signupPassword}
                            onChange={lambda e: any -> None { setSignupPassword(e.target.value); }}
                            style={{
                                "flexGrow": 1,
                                "padding": "1.25rem",
                                "borderRadius": "0.5rem",
                                "border": "none",
                                "backgroundColor": "#0b0b0b",
                                "color": "white",
                                "fontSize": "16px",
                                "width": "70%",
                                "outline": "none",
                                "marginBottom": "16px"
                            }}
                        />
                        <button
                            type="submit"
                            style={{
                                "width": "calc(70% + 12px + 1.25rem)",
                                "padding": "1.25rem",
                                "borderRadius": "8px",
                                "border": "none",
                                "backgroundColor": "#6e11b0",
                                "color": "white",
                                "fontWeight": "600",
                                "fontSize": "15px",
                                "cursor": "pointer"
                            }}
                        >
                            Sign Up
                        </button>
                    </form>
                    <p
                        style={{
                            "marginTop": "19px",
                            "fontSize": "14px",
                            "color": "#bbbbbb",
                            "textAlign": "center"
                        }}
                    >
                        Already have an account?
                        <span
                            onClick={lambda e: any -> None { setIsSignIn(True); }}
                            style={{
                                "color": "#6e11b0",
                                "cursor": "pointer",
                                "fontWeight": "600",
                                "marginLeft": "5px"
                            }}
                        >
                            Sign In
                        </span>
                    </p>
                </div>
            </div>

            <div
                style={{
                    "width": "50%",
                    "height": "100%",
                    "position": "absolute",
                    "top": "0px",
                    "left": ("50%" if isSignIn else "0px"),
                    "transition": "all 300ms ease-in",
                    "display": "flex",
                    "justifyContent": "center",
                    "alignItems": "center",
                    "pointerEvents": "none"
                }}
             >
                <div
                    style={{
                        "margin": "auto",
                        "backgroundColor": "#6e11b0",
                        "width": "97%",
                        "height": "97%",
                        "zIndex": "9999",
                        "borderRadius": "10px",
                        "display": "flex",
                        "justifyContent": "center",
                        "alignItems": "center",
                        "overflow": "hidden"
                    }}
                >
                    
                </div>
            </div>

        </div>;
    }

    def Onboarding() -> any {

        let [currentStep, setCurrentStep] = useState(1);
        let [stepCompleted,setStepCompleted] = useState(0);
        let [navbtnHover, setNavBtnHover] = useState("");
        let [progress,setProgress] = useState(25);
        let [resumeHover,setResumeHover] = useState(false);


        useEffect(lambda -> None {
            let percent = (currentStep / 4) * 100;
            setProgress(percent + "%");
        }, [currentStep]);


        let steps = [
            {
                id: 1,
                title: "Upload Your CV",
                description: "Let our AI analyze your experience and extract your current skills.",
                icon: <CloudUpload style={{
                    "fontSize":"0.75rem"
                }}/>,
                completed: false
            },
            {
                id: 2,
                title: "Review & Update Skills",
                description: "Confirm AI-detected skills and add any we might have missed.",
                icon:<Brain style={{
                    "fontSize":"0.75rem"
                }} />,
                completed: false
            },
            {
                id: 3,
                title: "Set Career Goals",
                description: "Choose your target roles, industries, and career aspirations.",
                icon:  <Goal style={{
                    "fontSize":"0.75rem"
                }}/>,
                completed: false
            },
            {
                id: 4,
                title: "Get Your Roadmap",
                description: "Explore your personalized learning path and skill gap analysis.",
                icon: <Node style={{
                    "fontSize":"0.75rem"
                }} />,
                completed: false
            }
        ];


        def Step(props:any) -> any {
            console.log(props);
            return <div style={{
                "display":"flex",
                "flexDirection":"row",
                "gap":"36px",
                "alignItems":"center",
                "width":"75%",
                "marginInline":"auto",
                "marginBottom":"45px"
            }}>
                <div style={{
                    "width":"40px",
                    "aspectRatio":"1",
                    "borderRadius":"50%",
                    "display":"flex",
                    "alignItems":"center",
                    "justifyContent":"center",
                    "color":"white",
                    "position":"relative",
                    "zIndex":"1",
                    "transition": "all 0.2s ease",
                    "boxShadow": ("0 0 20px rgba(110, 17, 176, 0.5)" if props.step.id == currentStep else "none"),
                    "backgroundColor":("#6e11b0" if props.step.id <= currentStep else "black")
                }}>
                    <div style={{
                        "display":"flex",
                        "alignItems":"center",
                        "justifyContent":"center",
                    }}>
                        { props.step.icon }
                        { props.step.id != 4 &&
                        <div style={{
                            "position":"absolute",
                            "height":"calc(100% + 65px)",
                            "width":"2px",
                            "left":"calc(50% + 1px)",
                            "top":"100%",
                            "transform":"translateX(-50%)",
                            "zIndex":"-1",
                            "transition": "all 0.2s ease",
                            "borderLeft": ("2px dashed #6e11b0" if props.step.id < currentStep else "2px dashed grey")

                        }}
                        ></div>
                        }
                    </div>
                    
                </div>
                <div>
                    <h1 style={{
                        "marginBottom":"0px",
                        "fontWeight":"600",
                        "color":("white" if props.step.id <= currentStep else "rgba(255, 255, 255, 0.6); "),
                        "fontSize":"1.15rem"
                    }}>{props.step.title}</h1>
                    <p style={{
                        "color":"grey",
                        "marginBlock":"0px",
                        "marginTop":"10px"
                    }}>{props.step.description}</p>
                </div>
            </div>;
        }


         return <div style={{
            "width": "100%",
            "height": "100vh",
            "display": "grid",
            "gridTemplateColumns": "45% 55%",
            "position": "relative",
            "color": "white",
            "fontFamily": "system-ui, sans-serif"

         }}>
                <div style={{
                        "width": "100%",
                        "height": "100%",
                        "display": "flex",
                        "justifyContent": "center",
                        "alignItems": "center"
                    }}>
                    <div
                        style={{
                            "margin": "auto",
                            "backgroundColor": "#0b0b0b",
                            "width": "95%",
                            "height": "90%",
                            "zIndex": "9999",
                            "borderRadius": "10px",
                            "display": "flex",
                            "flexDirection" :"column",
                            "justifyContent": "center",
                            "alignItems": "center",
                            "overflow": "hidden"
                        }}
                    >
                     {steps.map(
                        lambda step:any -> any { return 
                        <Step
                        key={step.id}
                        step={step}
                        isActive={currentStep == step.id}
                        />;
                        })}   
                    </div>
                </div>
                <div style={{
                        "width": "100%",
                        "height": "95%",
                        "marginBlock":"auto",
                        "display": "flex",
                        "justifyContent": "center",
                        "alignItems": "center"
                    }}>
                    <div style={{
                        "width":"90%",
                        "height":"90%",
                        "display":"flex",
                        "flexDirection":"column",
                        "justifyContent":"center"
                        
                     }}>
                        <div style={{
                            "color":"grey",
                            "textTransform":"uppercase"
                         }}>Step {currentStep} of 4</div>
                        
                        <div style={{
                            "width":"80%",
                            "height":"11px",
                            "borderRadius":"20px",
                            "backgroundColor": "#0b0b0b",
                            "overflow":"hidden",
                            "marginBlock":"20px"
                         }}>
                             <div
                                style={{
                                "height": "100%",
                                "width":(progress),     
                                "backgroundColor": "#6e11b0",
                                "transition": "0.3s ease",
                                "borderRadius":"20px"
                                }}
                             ></div>
                        </div>

                        { currentStep == 1 &&
                        <div style={{
                            "height":"60vh"
                            }}>
                            <div style={{
                                "marginBottom":"0px",
                                "fontWeight":"600",
                                "color":"white",
                                "fontSize":"1.15rem"
                            }}>Upload your CV</div>
                            <p style={{
                                "color":"grey",
                                "marginBlock":"0px",
                                "marginTop":"10px"
                                }}>Let us start by understanding your background</p>
                            <div    
                                onMouseEnter={lambda  e: any  -> None{ setResumeHover(true);} }
                                onMouseLeave={lambda  e: any  -> None{ setResumeHover(false);} }
                                style={{
                                    "marginBlock":"30px",
                                    "height":"40vh",
                                    "width":"80%",
                                    "borderRadius":"15px",
                                    "border":("2px dashed #6e11b0" if resumeHover else "2px dashed grey"),
                                    "backgroundColor": ( "#0b0b0b" if resumeHover else "#101010ff"),
                                    "display":"flex",
                                    "flexDirection":"column",
                                    "justifyContent":"center",
                                    "alignItems":"center"

                                }}>
                                    <div style={{
                                        "width":"55px",
                                        "aspectRatio":"1",
                                        "borderRadius":"50%",
                                        "backgroundColor":"black",
                                        "display":"flex",
                                        "alignItems":"center",
                                        "justifyContent":"center",
                                        "marginBottom":"15px"

                                    }}>
                                     <CloudUpload style={{
                                        "fontSize":"0.75rem",
                                        "color":"#6e11b0"

                                    }} /></div>
                                    <p style={{
                                         "color":"grey",
                                        "marginBlock":"0px",
                                        "marginBlock":"20px",
                                        "fontSize":".9em"
                                    }}>
                                    Supported formats: PDF, DOC, DOCX (Max 5MB)</p>
                                    <div></div>
                                    <div style={{
                                        "width": "auto",
                                        "padding": "1rem 1.5rem",
                                        "border": "none",
                                        "borderRadius": "0.5rem",
                                        "backgroundColor": "#6e11b0",
                                        "color": "white",
                                        "fontWeight": "600",
                                        "fontSize": "0.875rem",
                                        "cursor": "pointer",
                                        "transition": "all 0.2s ease",
                                        "marginTop":"10px",
                                        "boxShadow": "0 0 20px rgba(110, 17, 176, 0.2)"
                                    }}>Upload from Computer</div>
                                </div>
                        </div>}

                        { currentStep == 2 && 
                        <div style={{
                            "height":"60vh"
                        }}>hello</div>
                        }

                        { currentStep == 3 && 
                        <div style={{
                            "height":"60vh"
                        }}>hello</div>
                        }

                        { currentStep == 4 && 
                        <div style={{
                            "height":"60vh"
                        }}>hello</div>
                        }

                        <div style={{
                            "display":"flex",
                            "flexDirection":"row",
                            "gap":"25px",
                            "alignItems":"center"
                            }}>

                            { currentStep > 1 &&
                            <div 
                                onClick={lambda  e: any  -> None{setCurrentStep(currentStep - 1);}}
                                style={{
                                    "display":"flex",
                                    "flexDirection":"row",
                                    "alignItems":"center"
                                }}> 
                                <ChevronLeft/>
                                Back
                            </div>
                            }

                            <button
                                type="button"
                                onClick={lambda  e: any  -> None{setCurrentStep(currentStep + 1);}}
                                onMouseEnter={lambda  e: any  -> None{ setNavBtnHover(true);} }
                                onMouseLeave={lambda  e: any  -> None{ setNavBtnHover(false);} }
                                style={{
                                    "width": "180px",
                                    "backgroundColor": "#6e11b0",
                                    "color": "white",
                                    "border": "none",
                                    "paddingInline": "2.5rem",
                                    "paddingBlock": "1rem",
                                    "borderRadius": "5px",
                                    "cursor": "pointer",
                                    "fontSize": "16px",
                                    "transform": (
                                        "translateY(0.25rem)" if navbtnHover else "translateY(0)"
                                    ),
                                    "transition": "transform 0.2s ease"
                                }}
                                >
                                Next
                            </button>
                        </div>
                    </div>
                    
                </div>
            </div>;
    }

    def Dashboard() -> any {
         return <div>
        </div>;
    }

    def app() -> any {

        # Styling
        document.body.style.margin = '0';
        document.body.style.padding = '0';
        document.body.style.backgroundColor = 'black';

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