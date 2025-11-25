cl import from react { useState }
cl import from 'lucide-react' { Mail, ChevronUp, ChevronLeft }
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
                            "transition": "all 0.2s ease",
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
                    <div
                        style={{
                            "color": "white",
                            "fontSize": "20px",
                            "fontWeight": "600"
                        }}
                    >
                        Smart Career Path Navigator
                    </div>
                </div>
            </div>

        </div>;
    }

    def Onboarding() -> any {
         return <div>
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