import from react { useState,useEffect }
import from 'lucide-react' { Mail,Brain, CloudUpload, LogOut, Check, Goal, Route as Node, ChevronUp, ChevronLeft }
import from 'radix-ui' { Accordion }
import from "@jac-client/utils" {
    Router,
    Routes,
    Route,
    Link,
    Navigate,
    useNavigate,
    jacSignup,
    jacLogin,
    jacLogout,
    jacIsLoggedIn
}
import from .fileutils {
    fileToBase64
}

import ".styles.css";

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

    async def handleLogin(e: any) -> None {
        e.preventDefault();
        setError("");

        if not loginEmail or not loginPassword {
            setError("Please fill all fields");
            return;
        }

        success = await jacLogin(loginEmail, loginPassword);

        if success {
            resume_status = await root spawn check_resume_upload_status();

            if resume_status.reports[0]["body"] == True {

                ## TODO: load memory here

                navigate("/dashboard");
            } else {
                navigate("/onboarding");
            }
        } else {
            setError("Wrong email or password");
        }
    }

    async def handleSignup(e: any) -> None {
        e.preventDefault();
        setError("");

        if not signupName or not signupEmail or not signupPassword {
            setError("Please fill in all fields");
            return;
        }

        result = await jacSignup(signupEmail, signupPassword);

        if result["success"] {
            new_memory = root spawn initialize_memory(full_name=signupName, email=signupEmail);
            console.log("New Memory initialized:");
            console.log(new_memory);
            navigate("/onboarding");
        } else {
            setError(result["error"] if result["error"] else "Signup failed");
        }
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
            <h2 style={{ "color": "white", "margin": 0 }}>{title}</h2>
        </div>;
    }


    let loginErrorBox = None;
    if error and isSignIn {
        loginErrorBox = <div
            style={{
                "color": "#dc2626",
                "marginBottom": "10px",
                "fontSize": "14px"
            }}
        >
            {error}
        </div>;
    }

    let signupErrorBox = None;
    if error and not isSignIn {
        signupErrorBox = <div
            style={{
                "color": "#dc2626",
                "marginBottom": "10px",
                "fontSize": "14px"
            }}
        >
            {error}
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

                {loginErrorBox}

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
                            "padding": "1.25rem",
                            "borderRadius": "0.5rem",
                            "border": "none",
                            "backgroundColor": "#0b0b0b",
                            "color": "white",
                            "fontSize": "16px",
                            "width": "70%",
                            "marginBottom": "16px"
                        }}
                    />

                    <input
                        type="password"
                        placeholder="Password"
                        value={loginPassword}
                        onChange={lambda e: any -> None { setLoginPassword(e.target.value); }}
                        style={{
                            "padding": "1.25rem",
                            "borderRadius": "0.5rem",
                            "border": "none",
                            "backgroundColor": "#0b0b0b",
                            "color": "white",
                            "fontSize": "16px",
                            "width": "70%",
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
                        onClick={lambda e: any -> None { setIsSignIn(False); setError(""); }}
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

                {signupErrorBox}

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
                            "padding": "1.25rem",
                            "borderRadius": "0.5rem",
                            "border": "none",
                            "backgroundColor": "#0b0b0b",
                            "color": "white",
                            "fontSize": "16px",
                            "width": "70%",
                            "marginBottom": "16px"
                        }}
                    />

                    <input
                        type="email"
                        placeholder="Email"
                        value={signupEmail}
                        onChange={lambda e: any -> None { setSignupEmail(e.target.value); }}
                        style={{
                            "padding": "1.25rem",
                            "borderRadius": "0.5rem",
                            "border": "none",
                            "backgroundColor": "#0b0b0b",
                            "color": "white",
                            "fontSize": "16px",
                            "width": "70%",
                            "marginBottom": "16px"
                        }}
                    />

                    <input
                        type="password"
                        placeholder="Password"
                        value={signupPassword}
                        onChange={lambda e: any -> None { setSignupPassword(e.target.value); }}
                        style={{
                            "padding": "1.25rem",
                            "borderRadius": "0.5rem",
                            "border": "none",
                            "backgroundColor": "#0b0b0b",
                            "color": "white",
                            "fontSize": "16px",
                            "width": "70%",
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
                        onClick={lambda e: any -> None { setIsSignIn(True); setError(""); }}
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

def LoadingDots() -> any {
    return <div style={{
        "display": "flex",
        "justifyContent": "center",
        "alignItems": "center",
        "gap": "6px",
        "height": "20px"
    }}>
        <span className="loading-dot"></span>
        <span className="loading-dot"></span>
        <span className="loading-dot"></span>
    </div>;
}


def Onboarding() -> any {

    let [currentStep, setCurrentStep] = useState(1);
    let [stepCompleted, setStepCompleted] = useState(0);
    let [navbtnHover, setNavBtnHover] = useState(False);
    let [progress, setProgress] = useState("25%");
    let [resumeHover, setResumeHover] = useState(False);

    # Alerts + skip
    let [alertMessage, setAlertMessage] = useState("");
    let [alertVisible, setAlertVisible] = useState(False);
    let [allowSkip, setAllowSkip] = useState(False);

    # File upload states for step 1
    let [dragActive, setDragActive] = useState(False);
    let [fileName, setFileName] = useState("");
    let [file, setFile] = useState(None);
    let [error, setError] = useState("");
    let [isLoading, setIsLoading] = useState(False);
    let [showManualEntry, setShowManualEntry] = useState(False);
    let [canProceed, setCanProceed] = useState(False);
    let navigate = useNavigate();

    # Step 2 States 
    let [skills, setSkills] = useState([]);
    let [interests, setInterests] = useState([]);
    let [certs, setCerts] = useState([]);
    let [newSkill, setNewSkill] = useState("");
    let [newInterest, setNewInterest] = useState("");
    let [newCert, setNewCert] = useState("");
    let [step2Loading, setStep2Loading] = useState(True);
    let [savingProfile, setSavingProfile] = useState(False);
    let [suggestedRoles, setSuggestedRoles] = useState([]);

    # Step 3 States
    let [currentRoleIndex, setCurrentRoleIndex] = useState(0);



    # Alert 
    def showAlert(msg: str) {
        setAlertMessage(msg);
        setAlertVisible(True);

        setTimeout(lambda -> None {
            setAlertVisible(False);
        }, 3500);
    }

    # Load User Profile (Step 2)
    async def loadStep2() -> None {
        setStep2Loading(True);

        try {
            let profile = await root spawn get_user_profile();

            if profile and profile.reports and profile.reports.length > 0 {
                let body = profile.reports[0]["body"];

                # Ensure data shapes: skills -> [{ name: "x" }], interests similarly, certs -> [{ title: "x" }]
                setSkills(body["skills"] if "skills" in body else []);
                setInterests(body["interests"] if "interests" in body else []);
                setCerts(body["certifications"] if "certifications" in body else []);
            } else {
                setSkills([]);
                setInterests([]);
                setCerts([]);
            }
        } except Exception as err {
            console.log(err);
            showAlert("Failed to load profile. Try again later.");
        } finally {
            setStep2Loading(False);
        }
    }

    useEffect(lambda -> None {
        if currentStep == 2 {
            loadStep2();
        }
    }, [currentStep]);

    # Add to UI
    def addSkill() {
        if newSkill.trim().length == 0 { return; }
        # Avoid duplicates by name (case-insensitive)
        let exists = skills.filter(lambda s: any -> bool { return s.name.toLowerCase() == newSkill.trim().toLowerCase(); }).length > 0;
        if not exists {
            setSkills(skills.concat([{"name": newSkill.trim(), "description": ""}]));
        }
        setNewSkill("");
    }

    def addInterest() {
        if newInterest.trim().length == 0 { return; }
        let exists = interests.filter(lambda i: any -> bool { return i.name.toLowerCase() == newInterest.trim().toLowerCase(); }).length > 0;
        if not exists {
            setInterests(interests.concat([{"name": newInterest.trim(), "description": ""}]));
        }
        setNewInterest("");
    }

    def addCert() {
        if newCert.trim().length == 0 { return; }
        let exists = certs.filter(lambda c: any -> bool { return ("title" in c and c.title.toLowerCase() == newCert.trim().toLowerCase()); }).length > 0;
        if not exists {
            setCerts(certs.concat([{"title": newCert.trim(), "provider": "", "url": ""}]));
        }
        setNewCert("");
    }

    # Remove
    def removeSkill(name: str) {
        setSkills(skills.filter(lambda s: any -> bool { return s.name != name; }));
    }

    def removeInterest(name: str) {
        setInterests(interests.filter(lambda i: any -> bool { return i.name != name; }));
    }

    def removeCert(name: str) {
        setCerts(certs.filter(lambda c: any -> bool { return c.title != name; }));
    }

    # Save All (Step 2 Next)
    async def saveStep2() -> None {
        if savingProfile { return; }
        setSavingProfile(True);

        try {
            let result = await root spawn update_user_profile(
                updated_skills=skills,
                updated_interests=interests,
                updated_certifications=certs
            );

            if result {

                let rolesReport = await root spawn generate_role_suggestions();
                let latestReport = rolesReport.reports[rolesReport.reports.length - 1];

                if latestReport.status == "Success" {
                    # Store the array of suggestions in state
                    setSuggestedRoles(latestReport.body);

                    console.log("Suggested roles saved in state:", latestReport.body);
                } else {
                    showAlert("Failed to generate role suggestions: " + (latestReport.message or "Unknown error"));
                }

                setAllowSkip(False);
                setShowManualEntry(False);
                setCurrentStep(3);

            } else {
                showAlert("Failed to save profile. Please try again.");
            }

        } except Exception as err {
            console.log(err);
            showAlert("An error occurred while saving. Try again.");
        } finally {
            setSavingProfile(False);
        }
    }


    useEffect(lambda -> None {
        let percent = (currentStep / 4) * 100;
        setProgress(percent + "%");
    }, [currentStep]);

    let steps = [
        {
            id: 1,
            title: "Upload Your CV",
            description: "",
            icon: <CloudUpload style={{ "fontSize": "0.75rem" }} />,
            completed: False
        },
        {
            id: 2,
            title: "Review & Update Profile",
            description: "",
            icon: <Brain style={{ "fontSize": "0.75rem" }} />,
            completed: False
        },
        {
            id: 3,
            title: "Set Career Goals",
            description: "",
            icon: <Goal style={{ "fontSize": "0.75rem" }} />,
            completed: False
        },
        {
            id: 4,
            title: "Get Your Roadmap",
            description: "",
            icon: <Node style={{ "fontSize": "0.75rem" }} />,
            completed: False
        }
    ];

    def handleFileSelect(e: any) -> None {
        let pickedFile = e.target.files[0];
        if pickedFile {
            setFileName(pickedFile.name);
            setFile(pickedFile);
            setError("");
            setCanProceed(True);
        }
    }

    def handleDragOver(e: any) -> None {
        e.preventDefault();
        setDragActive(True);
    }

    def handleDragLeave(e: any) -> None {
        e.preventDefault();
        setDragActive(False);
    }

    def handleDrop(e: any) -> None {
        e.preventDefault();
        setDragActive(False);
        if e.dataTransfer.files and e.dataTransfer.files.length > 0 {
            let droppedFile = e.dataTransfer.files[0];
            setFileName(droppedFile.name);
            setFile(droppedFile);
            e.dataTransfer.clearData();
            setError("");
            setCanProceed(True);
        }
    }

    async def handleStep1Next() -> None {
        if not canProceed or isLoading or not file {
            return;
        }

        setIsLoading(True);
        setError("");
        setShowManualEntry(False);

        try {
            root spawn create_resume_node();

            let base64Data = await fileToBase64(file);

            let result = await root spawn upload_resume(
                file=base64Data,
                name=file.name,
                mime=file.type
            );

            if not result {
                showAlert("Resume upload failed");
                setShowManualEntry(True);
                setIsLoading(False);
                setAllowSkip(True);
                return;
            }

            root spawn save_resume();
            root spawn update_resume_upload_status();

            let user_skills = await root spawn analyze_cv();

            if not user_skills or not user_skills.reports or user_skills.reports.length == 0 {
                showAlert("Something went wrong. Please upload another document or enter details manually.");
                setAllowSkip(True);
                setShowManualEntry(True);
                setIsLoading(False);
                return;
            }

            if user_skills.reports[0]["status"] != "Success" {
                showAlert("Something went wrong. Please upload another document or enter details manually.");
                setAllowSkip(True);
                setShowManualEntry(True);
                setIsLoading(False);
                return;
            }

            # parse the analyzer output to prefill step2 states if present
            try {
                let body = user_skills.reports[0]["body"] if "body" in user_skills.reports[0] else {};
                let detected_skills = body["skills"] if "skills" in body else [];
                let detected_interests = body["interests"] if "interests" in body else [];
                let detected_certs = body["certifications"] if "certifications" in body else [];

                setSkills(detected_skills);
                setInterests(detected_interests);
                setCerts(detected_certs);
            } except Exception as e {
                console.log(e);
                # non-fatal; continue to step 2
            }

            # proceed to step 2
            setAllowSkip(False);
            setCurrentStep(2);

        } except Exception as err {
            console.log(err);
            showAlert("Something went wrong. Try again later");
            setAllowSkip(True);
            setShowManualEntry(True);
        } finally {
            setIsLoading(False);
        }
    }

    let wrapperStyle = {
        "width": "100%",
        "height": "100vh",
        "display": "grid",
        "gridTemplateColumns": "45% 55%",
        "position": "relative",
        "color": "white",
        "fontFamily": "system-ui, sans-serif"
    };

    let leftPanelInnerStyle = {
        "margin": "auto",
        "backgroundColor": "#0b0b0b",
        "width": "95%",
        "height": "90%",
        "zIndex": "9999",
        "borderRadius": "10px",
        "display": "flex",
        "flexDirection": "column",
        "justifyContent": "center",
        "alignItems": "center",
        "overflow": "hidden"
    };

    let rightInnerStyle = {
        "width":"90%",
        "height":"90%",
        "display":"flex",
        "flexDirection":"column",
        "justifyContent":"center"
    };

    let uploadBoxStyle = {
        "marginBlock":"30px",
        "height":"40vh",
        "width":"80%",
        "borderRadius":"15px",
        "display":"flex",
        "flexDirection":"column",
        "justifyContent":"center",
        "alignItems":"center",
        "transition":"0.2s ease"
    };

    if resumeHover {
        uploadBoxStyle["border"] = "2px dashed #6e11b0";
        uploadBoxStyle["backgroundColor"] = "#0b0b0b";
    } else {
        uploadBoxStyle["border"] = "2px dashed grey";
        uploadBoxStyle["backgroundColor"] = "#101010ff";
    }

    let uploadLabelStyle = {
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
    };

    let nextBtnBaseStyle = {
        "width": "180px",
        "border": "none",
        "paddingInline": "2.5rem",
        "paddingBlock": "1rem",
        "borderRadius": "5px",
        "cursor": "pointer",
        "fontSize": "16px",
        "transition": "transform 0.2s ease",
        "color": "white",
        "backgroundColor": "#6e11b0",
        "transform": ( "translateY(0.25rem)" if navbtnHover else "translateY(0)" )
    };

    # Disabled look for Step 1 Next:
    if currentStep == 1 and (not canProceed or isLoading) {
        nextBtnBaseStyle["opacity"] = "0.4";
        nextBtnBaseStyle["cursor"] = "not-allowed";
    }

    # Next button content computed 
    let nextBtnContent = None;
    if currentStep == 1 and isLoading {
        nextBtnContent = LoadingDots();
    } elif currentStep == 2 and savingProfile {
        nextBtnContent = LoadingDots();
    } else {
        nextBtnContent = <label>Next</label>;
    }

    

    # Steps list (left column)
    def Step(props: any) -> any {
        let isActive = (props.step.id == currentStep);
        let circleStyle = {
            "width": "40px",
            "aspectRatio": "1",
            "borderRadius": "50%",
            "display": "flex",
            "alignItems": "center",
            "justifyContent": "center",
            "color": "white",
            "position": "relative",
            "zIndex": "1",
            "transition": "all 0.2s ease",
            "boxShadow": "none",
            "backgroundColor": "#000000"
        };

        if isActive or props.step.id < currentStep {
            circleStyle["backgroundColor"] = "#6e11b0";
        } else {
            circleStyle["backgroundColor"] = "black";
        }

        if isActive {
            circleStyle["boxShadow"] = "0 0 20px rgba(110, 17, 176, 0.5)";
        }

        let connectorDisplay = None;
        if props.step.id != 4 {
            let connectorStyle = {
                "position":"absolute",
                "height":"calc(100% + 65px)",
                "width":"2px",
                "left":"calc(50% + 1px)",
                "top":"100%",
                "transform":"translateX(-50%)",
                "zIndex":"-1",
                "transition":"all 0.2s ease",
                "borderLeft":"2px dashed grey"
            };
            if props.step.id < currentStep {
                connectorStyle["borderLeft"] = "2px dashed #6e11b0";
            } else {
                connectorStyle["borderLeft"] = "2px dashed grey";
            }
            connectorDisplay = <div style={connectorStyle}></div>;
        }

        let titleStyle = {
            "marginBottom":"0px",
            "fontWeight":"600",
            "color":"rgba(255, 255, 255, 0.6)",
            "fontSize":"1.15rem"
        };
        if props.step.id <= currentStep {
            titleStyle["color"] = "white";
        }

        return <div style={{
            "display":"flex",
            "flexDirection":"row",
            "gap":"36px",
            "alignItems":"center",
            "width":"75%",
            "marginInline":"auto",
            "marginBottom":"45px"
        }}>
            <div style={circleStyle}>
                <div style={{
                    "display":"flex",
                    "alignItems":"center",
                    "justifyContent":"center",
                }}>
                    { props.step.icon }
                    { connectorDisplay }
                </div>
            </div>
            <div>
                <h1 style={titleStyle}>{props.step.title}</h1>
                <p style={{
                    "color":"grey",
                    "marginBlock":"0px",
                    "marginTop":"10px"
                }}>{props.step.description}</p>
            </div>
        </div>;
    }

    let stepsList = steps.map(
        lambda step: any -> any {
            return <Step key={step.id} step={step} />;
        }
    );

    # Uploaded file display block 
    let uploadedFileDisplay = None;
    if fileName and fileName != "" {
        uploadedFileDisplay = <div style={{
            "marginTop": "20px",
            "fontSize": "14px",
            "color": "white",
            "fontWeight": "500"
        }}>
            Uploaded: {fileName}
        </div>;
    }

    # Manual skip link block
    let manualSkipDisplay = None;
    if allowSkip and currentStep == 1 {
        manualSkipDisplay = <div
            style={{
                "fontSize": "15px",
                "cursor": "pointer",
                "color": "white",
                "textDecoration": "underline",
                "fontWeight": "500"
            }}
            onClick={lambda e: any -> None {
                setAllowSkip(False);
                setCurrentStep(2);
            }}
        >
            Skip →
        </div>;
    }

    # Step 1 content
    let step1Content = None;
    if currentStep == 1 {
        step1Content = <div style={{ "height":"60vh" }}>
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
                onMouseEnter={lambda e: any -> None { setResumeHover(True); }}
                onMouseLeave={lambda e: any -> None { setResumeHover(False); }}
                onDragOver={handleDragOver}
                onDragLeave={handleDragLeave}
                onDrop={handleDrop}
                style={uploadBoxStyle}
            >
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
                    <CloudUpload style={{ "fontSize":"0.75rem", "color":"#6e11b0" }} />
                </div>

                <p style={{
                    "color":"grey",
                    "marginBlock":"0px",
                    "marginBlock":"20px",
                    "fontSize":".9em"
                }}>
                    Supported formats: PDF, DOC, DOCX (Max 5MB)
                </p>

                <input
                    type="file"
                    accept=".pdf,.doc,.docx"
                    onChange={handleFileSelect}
                    style={{ "display": "none" }}
                    id="resumeInput"
                />

                <label
                    for="resumeInput"
                    style={uploadLabelStyle}
                    onMouseEnter={lambda e: any -> None { e.currentTarget.style.filter = "brightness(0.95)"; }}
                    onMouseLeave={lambda e: any -> None { e.currentTarget.style.filter = "brightness(1)"; }}
                >
                    Upload from Computer
                </label>

                {uploadedFileDisplay}

            </div>
        </div>;
    }

   # Step 2 content
    let step2Content = None;
    if currentStep == 2 {
    if step2Loading {
        step2Content = step2LoadingView;
    } else {
        step2Content = <div style={{
            "height":"65vh",
            "overflowY":"auto",
            "paddingRight":"10px"
        }}>

            # Skills
            <div style={{ "marginBottom":"25px" }}>
                <h2 style={{ "color":"white", "marginBottom":"8px" }}>Skills</h2>

                <div style={{
                    "display":"flex",
                    "flexDirection":"row",
                    "alignItems":"center",
                    "gap":"10px",
                    "marginBottom":"12px"
                }}>
                    <input
                        type="text"
                        value={newSkill}
                        onChange={lambda e: any -> None { setNewSkill(e.target.value); }}
                        onKeyDown={lambda e: any -> None { if e.key == "Enter" { addSkill(); } }}
                        placeholder="Python, Project Management, etc."
                        style={{
                            "width":"260px",
                            "backgroundColor":"#0e0e0e",
                            "border":"1px solid #262626",
                            "color":"white",
                            "padding":"10px",
                            "borderRadius":"10px",
                            "fontSize":"0.9rem",
                            "transition":"all 0.25s ease",
                            "boxShadow":"0 0 0 0 rgba(0,0,0,0)"
                        }}
                        onFocus={lambda e: any -> None {
                            e.target.style.border = "1px solid #7f2ae6";
                            e.target.style.boxShadow = "0 0 6px #7f2ae6";
                        }}
                        onBlur={lambda e: any -> None {
                            e.target.style.border = "1px solid #262626";
                            e.target.style.boxShadow = "none";
                        }}
                    />

                    <button
                        onClick={lambda e: any -> None { addSkill(); }}
                        style={{
                            "padding":"10px 16px",
                            "backgroundColor":"#7f2ae6",
                            "color":"white",
                            "border":"none",
                            "borderRadius":"10px",
                            "cursor":"pointer",
                            "fontWeight":"600",
                            "transition":"all 0.25s ease"
                        }}
                        onMouseEnter={lambda e: any -> None {
                            e.target.style.backgroundColor = "#9a48ff";
                        }}
                        onMouseLeave={lambda e: any -> None {
                            e.target.style.backgroundColor = "#7f2ae6";
                        }}
                    >
                        Add
                    </button>
                </div>

                {skills.length == 0 and <p style={{ "color":"grey" }}>No skills added</p>}
                {skills.length > 0 and <div style={{
                    "display":"flex",
                    "flexWrap":"wrap",
                    "gap":"8px"
                }}>
                    {skills.map(lambda s: any, idx: any -> any {
                        return <div key={idx} style={{
                            "display":"flex",
                            "alignItems":"center",
                            "gap":"6px",
                            "padding":"4px 10px",
                            "backgroundColor":"#0d0d0d",
                            "borderRadius":"9999px",
                            "fontSize":"0.85rem",
                            "color":"white"
                        }}>
                            <span>{s.name}</span>
                            <span
                                style={{
                                    "color":"#dc2626",
                                    "cursor":"pointer",
                                    "fontWeight":"700"
                                }}
                                onClick={lambda e: any -> None { removeSkill(s.name); }}
                            >
                                ×
                            </span>
                        </div>;
                    })}
                </div>}
            </div>

            # Interests
            <div style={{ "marginBottom":"25px" }}>
                <h2 style={{ "color":"white", "marginBottom":"8px" }}>Interests</h2>

                <div style={{
                    "display":"flex",
                    "flexDirection":"row",
                    "alignItems":"center",
                    "gap":"10px",
                    "marginBottom":"12px"
                }}>
                    <input
                        type="text"
                        value={newInterest}
                        onChange={lambda e: any -> None { setNewInterest(e.target.value); }}
                        onKeyDown={lambda e: any -> None { if e.key == "Enter" { addInterest(); } }}
                        placeholder="Add new interest"
                        style={{
                            "width":"260px",
                            "backgroundColor":"#0e0e0e",
                            "border":"1px solid #262626",
                            "color":"white",
                            "padding":"10px",
                            "borderRadius":"10px",
                            "fontSize":"0.9rem",
                            "transition":"all 0.25s ease"
                        }}
                        onFocus={lambda e: any -> None {
                            e.target.style.border = "1px solid #7f2ae6";
                            e.target.style.boxShadow = "0 0 6px #7f2ae6";
                        }}
                        onBlur={lambda e: any -> None {
                            e.target.style.border = "1px solid #262626";
                            e.target.style.boxShadow = "none";
                        }}
                    />

                    <button
                        onClick={lambda e: any -> None { addInterest(); }}
                        style={{
                            "padding":"10px 16px",
                            "backgroundColor":"#7f2ae6",
                            "color":"white",
                            "border":"none",
                            "borderRadius":"10px",
                            "cursor":"pointer",
                            "fontWeight":"600",
                            "transition":"all 0.25s ease"
                        }}
                        onMouseEnter={lambda e: any -> None {
                            e.target.style.backgroundColor = "#9a48ff";
                        }}
                        onMouseLeave={lambda e: any -> None {
                            e.target.style.backgroundColor = "#7f2ae6";
                        }}
                    >
                        Add
                    </button>
                </div>

                {interests.length == 0 and <p style={{ "color":"grey" }}>No interests added</p>}
                {interests.length > 0 and <div style={{
                    "display":"flex",
                    "flexWrap":"wrap",
                    "gap":"8px"
                }}>
                    {interests.map(lambda i: any, idx: any -> any {
                        return <div key={idx} style={{
                            "display":"flex",
                            "alignItems":"center",
                            "gap":"6px",
                            "padding":"4px 10px",
                            "backgroundColor":"#0d0d0d",
                            "borderRadius":"9999px",
                            "fontSize":"0.85rem",
                            "color":"white"
                        }}>
                            <span>{i.name}</span>
                            <span
                                style={{
                                    "color":"#dc2626",
                                    "cursor":"pointer",
                                    "fontWeight":"700"
                                }}
                                onClick={lambda e: any -> None { removeInterest(i.name); }}
                            >
                                ×
                            </span>
                        </div>;
                    })}
                </div>}
            </div>

            # Certifications
            <div>
                <h2 style={{ "color":"white", "marginBottom":"8px" }}>Certifications</h2>

                <div style={{
                    "display":"flex",
                    "flexDirection":"row",
                    "alignItems":"center",
                    "gap":"10px",
                    "marginBottom":"12px"
                }}>
                    <input
                        type="text"
                        value={newCert}
                        onChange={lambda e: any -> None { setNewCert(e.target.value); }}
                        onKeyDown={lambda e: any -> None { if e.key == "Enter" { addCert(); } }}
                        placeholder="Add certification"
                        style={{
                            "width":"260px",
                            "backgroundColor":"#0e0e0e",
                            "border":"1px solid #262626",
                            "color":"white",
                            "padding":"10px",
                            "borderRadius":"10px",
                            "fontSize":"0.9rem",
                            "transition":"all 0.25s ease"
                        }}
                        onFocus={lambda e: any -> None {
                            e.target.style.border = "1px solid #7f2ae6";
                            e.target.style.boxShadow = "0 0 6px #7f2ae6";
                        }}
                        onBlur={lambda e: any -> None {
                            e.target.style.border = "1px solid #262626";
                            e.target.style.boxShadow = "none";
                        }}
                    />

                    <button
                        onClick={lambda e: any -> None { addCert(); }}
                        style={{
                            "padding":"10px 16px",
                            "backgroundColor":"#7f2ae6",
                            "color":"white",
                            "border":"none",
                            "borderRadius":"10px",
                            "cursor":"pointer",
                            "fontWeight":"600",
                            "transition":"all 0.25s ease"
                        }}
                        onMouseEnter={lambda e: any -> None {
                            e.target.style.backgroundColor = "#9a48ff";
                        }}
                        onMouseLeave={lambda e: any -> None {
                            e.target.style.backgroundColor = "#7f2ae6";
                        }}
                    >
                        Add
                    </button>
                </div>

                {certs.length == 0 and <p style={{ "color":"grey" }}>No certifications added</p>}
                {certs.length > 0 and <div style={{
                    "display":"flex",
                    "flexWrap":"wrap",
                    "gap":"8px"
                }}>
                    {certs.map(lambda c: any, idx: any -> any {
                        return <div key={idx} style={{
                            "display":"flex",
                            "alignItems":"center",
                            "gap":"6px",
                            "padding":"4px 10px",
                            "backgroundColor":"#0d0d0d",
                            "borderRadius":"9999px",
                            "fontSize":"0.85rem",
                            "color":"white"
                        }}>
                            <span>{c.title}</span>
                            <span
                                style={{
                                    "color":"#dc2626",
                                    "cursor":"pointer",
                                    "fontWeight":"700"
                                }}
                                onClick={lambda e: any -> None { removeCert(c.title); }}
                            >
                                ×
                            </span>
                        </div>;
                    })}
                </div>}
            </div>

        </div>;
    }
    }

    # ---------------- Step 3: Suggested Roles ----------------
    let step3Content = None;
    if currentStep == 3 {

        let totalRoles = suggestedRoles.length;
        let currentRole = None;
        if totalRoles > 0 {
            currentRole = suggestedRoles[currentRoleIndex];
        }

        let canGoLeft = currentRoleIndex > 0;
        let canGoRight = currentRoleIndex < totalRoles - 1;

        let arrowActiveColor = "#b37aff";
        let arrowInactiveColor = "#2a2a2a";

        let leftArrowColor = arrowInactiveColor;
        let rightArrowColor = arrowInactiveColor;

        let leftArrowCursor = "default";
        let rightArrowCursor = "default";

        if canGoLeft {
            leftArrowColor = arrowActiveColor;
            leftArrowCursor = "pointer";
        }

        if canGoRight {
            rightArrowColor = arrowActiveColor;
            rightArrowCursor = "pointer";
        }

        step3Content = <div style={{
            "height":"65vh",
            "padding":"5px",
            "position":"relative",
            "display":"flex",
            "flexDirection":"column"
        }}>

            <h2 style={{
                "color":"white",
                "marginBottom":"10px",
                "fontSize":"1.3rem",
                "fontWeight":"600"
            }}>
                Your AI-Suggested Career Roles
            </h2>

            <p style={{
                "color":"grey",
                "marginTop":"0px",
                "marginBottom":"25px",
                "fontSize":"0.9rem"
            }}>
                Slide through the suggested roles and select the one that fits you best.
            </p>

            {(totalRoles == 0) and
                <p style={{ "color":"grey" }}>No suggestions found</p>
            }

            {(totalRoles > 0) and

                <div style={{
                    "display":"flex",
                    "alignItems":"center",
                    "justifyContent":"center",
                    "position":"relative",
                    "height":"100%"
                }}>

                    <div
                        onClick={lambda e: any -> None {
                            root.selectedRole = currentRole.title;
                        }}
                        style={{
                            "width":"85%",
                            "backgroundColor":"#0e0e0e",
                            "border":"1px solid #262626",
                            "padding":"22px",
                            "borderRadius":"12px",
                            "cursor":"pointer",
                            "transition":"all 0.25s ease",
                            "display":"flex",
                            "flexDirection":"column",
                            "gap":"10px",
                            "boxShadow":"0 0 6px rgba(0,0,0,0.4)",
                            "position":"relative"
                        }}
                    >

                        <div
                            onClick={lambda e: any -> None {
                                e.stopPropagation();
                                if canGoLeft {
                                    setCurrentRoleIndex(currentRoleIndex - 1);
                                }
                            }}
                            style={{
                                "position":"absolute",
                                "left":"0px",  # moved inside from -12px
                                "top":"50%",
                                "transform":"translateY(-50%)",
                                "fontFamily":"Inter, sans-serif",
                                "color": leftArrowColor,
                                "cursor": leftArrowCursor,
                                "fontSize":"1.8rem",
                                "padding":"8px",
                                "borderRadius":"50%",
                                "transition":"all 0.25s ease",
                                "userSelect":"none"
                            }}
                        >
                            {"‹"}
                        </div>


                        <h3 style={{
                            "color":"white",
                            "margin":"0px",
                            "fontSize":"1.1rem",
                            "fontWeight":"600"
                        }}>
                            {currentRole.title}
                        </h3>

                        <p style={{
                            "color":"grey",
                            "fontSize":"0.88rem",
                            "lineHeight":"1.35",
                            "margin":"0px"
                        }}>
                            {currentRole.description}
                        </p>

                        <div style={{
                            "marginTop":"auto",
                            "color":"#7f2ae6",
                            "fontWeight":"600",
                            "fontSize":"0.85rem"
                        }}>
                            Select →
                        </div>

                        <div
                            onClick={lambda e: any -> None {
                                e.stopPropagation();
                                if canGoRight {
                                    setCurrentRoleIndex(currentRoleIndex + 1);
                                }
                            }}
                            style={{
                                "position":"absolute",
                                "right":"0px",  # moved inside from -12px
                                "top":"50%",
                                "transform":"translateY(-50%)",
                                "fontFamily":"Inter, sans-serif",
                                "color": rightArrowColor,
                                "cursor": rightArrowCursor,
                                "fontSize":"1.8rem",
                                "padding":"8px",
                                "borderRadius":"50%",
                                "transition":"all 0.25s ease",
                                "userSelect":"none"
                            }}
                        >
                            {"›"}
                        </div>


                    </div>

                </div>
            }

        </div>;
    }



    let step4Content = None;
    if currentStep == 4 {
        step4Content = <div style={{ "height":"60vh" }}>hello</div>;
    }

    # Navigation controls computed
    let backNav = None;
    if currentStep > 1 {
        backNav = <div
            onClick={lambda e: any -> None { setCurrentStep(currentStep - 1); }}
            style={{
                "display":"flex",
                "flexDirection":"row",
                "alignItems":"center",
                "cursor":"pointer"
            }}
        >
            <ChevronLeft/>
            Back
        </div>;
    }

    # Next button 
    let nextBtn = <button
        type="button"
        onClick={lambda e: any -> None {
            if currentStep == 1 {
                handleStep1Next();
            } elif currentStep == 2 {
                saveStep2();
            } elif currentStep < 4 {
                setCurrentStep(currentStep + 1);
            }
        }}
        onMouseEnter={lambda e: any -> None { setNavBtnHover(True); }}
        onMouseLeave={lambda e: any -> None { setNavBtnHover(False); }}
        style={nextBtnBaseStyle}
        disabled={currentStep == 1 and (not canProceed or isLoading)}
    >
        {nextBtnContent}
    </button>;

    # Loading view for Step 2
    let step2LoadingView = <div style={{
        "color":"white",
        "fontSize":"1rem",
        "marginTop":"20px"
    }}>Loading your profile...</div>;

    let alertBox = None;
    if alertVisible {
        alertBox = <div style={{
            "position": "absolute",
            "top": "20px",
            "right": "20px",
            "padding": "12px 20px",
            "backgroundColor": "#dc2626",
            "color": "white",
            "borderRadius": "6px",
            "fontWeight": "600",
            "boxShadow": "0 0 15px rgba(0,0,0,0.4)",
            "transition": "0.3s ease"
        }}>
            {alertMessage}
        </div>;
    }

    return <div style={wrapperStyle}>

        {alertBox}

        <div style={{
            "width": "100%",
            "height": "100%",
            "display": "flex",
            "justifyContent": "center",
            "alignItems": "center"
        }}>
            <div style={leftPanelInnerStyle}>
                {stepsList}
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
            <div style={rightInnerStyle}>
                <div style={{ "color":"grey", "textTransform":"uppercase" }}>Step {currentStep} of 4</div>

                <div style={{
                    "width":"80%",
                    "height":"11px",
                    "borderRadius":"20px",
                    "backgroundColor": "#0b0b0b",
                    "overflow":"hidden",
                    "marginBlock":"20px"
                }}>
                    <div style={{
                        "height":"100%",
                        "width": progress,
                        "backgroundColor": "#6e11b0",
                        "transition": "0.3s ease",
                        "borderRadius":"20px"
                    }}></div>
                </div>

                {step1Content}
                {step2Content}
                {step3Content}
                {step4Content}

                <div style={{
                    "display":"flex",
                    "flexDirection":"row",
                    "gap":"25px",
                    "alignItems":"center",
                    "marginTop":"20px"
                }}>
                    {backNav}
                    {nextBtn}
                    {manualSkipDisplay}
                </div>
            </div>
        </div>

    </div>;
}



def Dashboard() -> any {
        let [sidebarOpen, setSidebarOpen] = useState(false);
        let [profileOpen, setProfileOpen] = useState(false);
        let [activeLink, setActiveLink] = useState("dashboard"); 
        let [selectedSkills, setSelectedSkills] = useState([]);
        let [selectedRoles, setSelectedRoles] = useState([]);
        
        let [notifications, setNotifications] = useState([
            {id: 1, type: "message", title: "New message from Jane", description: "Hey, just wanted to follow up on our meeting yesterday.", time: "2 hours ago", read: false},
            {id: 2, type: "event", title: "Upcoming event", description: "Team meeting scheduled for Friday at 2pm.", time: "1 day ago", read: false},
            {id: 3, type: "success", title: "Task completed", description:'You completed the "Update website content" task.', time: "3 days ago", read: true},
            {id: 4, type: "warning", title: "Account suspended", description: "Your account has been suspended due to a billing issue.", time: "1 week ago", read: true}
        ]);
        
        let unreadCount = notifications.filter(lambda n:any -> bool { return n.read == false; }).length;

        let baseLinkClasses = "flex items-center gap-3 px-4 py-3 rounded-lg transition-all cursor-pointer ";
        let dashboardClasses = "bg-primary text-white" if activeLink == "dashboard" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let notificationsClasses = "bg-primary text-white" if activeLink == "notifications" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let skillsClasses = "bg-primary text-white" if activeLink == "skills" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let rolesClasses = "bg-primary text-white" if activeLink == "roles" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let roadmapClasses = "bg-primary text-white" if activeLink == "roadmap" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let quizzesClasses = "bg-primary text-white" if activeLink == "quizzes" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";

        let devSkills = ["JavaScript", "Python", "React", "Node.js", "TypeScript", "HTML & CSS", "Django", "Flutter", "Git & GitHub", "SQL & Databases", "REST APIs", "GraphQL", "Docker", "Agile & Scrum"];
        let devRoles = ["Frontend Developer", "Backend Developer", "Fullstack Developer", "Mobile Developer", "DevOps Engineer", "UI/UX Designer", "Data Scientist", "Machine Learning Engineer"];

        def DashSideBar() -> any {
            return <div className="hidden md:flex md:w-64 bg-[#0b0b0b] h-screen flex-col border-r border-gray-800 fixed left-0 top-0">
                <div className="p-6">
                    <div className="text-xl font-semibold text-white">Arise</div>
                </div>

                <nav className="flex-1 p-4 overflow-y-auto">
                    <div className="mb-6">
                        <div className="text-gray-500 text-xs uppercase font-semibold my-2 px-4 mb-4">Main</div>
                        <ul className="list-none p-0 m-0 ml-[8px]">
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("dashboard"); }}
                                    className={baseLinkClasses + dashboardClasses}>
                                    <span>Dashboard</span>
                                </div>
                            </li>
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("notifications"); }}
                                    className={baseLinkClasses + notificationsClasses}>
                                    <span className="flex items-center justify-between w-full">
                                        <span>Notifications</span>
                                        {unreadCount > 0 && (
                                            <span className="ml-auto bg-primary text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center">
                                                {unreadCount}
                                            </span>
                                        )}
                                    </span>
                                </div>
                            </li>
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("skills"); }}
                                    className={baseLinkClasses + skillsClasses}>
                                    <span>Skills</span>
                                </div>
                            </li>
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("roles"); }}
                                    className={baseLinkClasses + rolesClasses}>
                                    <span>Roles</span>
                                </div>
                            </li>
                        </ul>
                    </div>

                    <div>
                        <div className="text-gray-500 text-xs uppercase font-semibold m-y2 px-4 mb-4">Actions</div>
                        <ul className="list-none p-0 m-0 ml-[8px]">
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("roadmap"); }}
                                    className={baseLinkClasses + roadmapClasses}>
                                    <span>My Roadmap</span>
                                </div>
                            </li>
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("quizzes"); }}
                                    className={baseLinkClasses + quizzesClasses}>
                                    <span>Quizzes</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>

                <div className="p-4 ">
                    <div className="flex items-center gap-3 px-4 py-3 text-red-400">
                        <LogOut />
                        <div className="text-sm text-red-400 font-medium">Logout</div>
                    </div>
                </div>
            </div>;
        }

        def MobileDashSideBar() -> any {
            let baseClasses = "fixed top-0 left-0 bg-[#0b0b0b] h-screen w-[80%] max-w-[300px] transform transition-transform duration-300 ease-in-out z-[100000] flex flex-col border-r border-gray-800";
            let positionClass = "translate-x-0" if sidebarOpen else "-translate-x-full";

            return <div className={baseClasses + " " + positionClass}>
                <div className="p-6 border-b border-gray-800 flex items-center justify-between">
                    <div className="text-xl font-semibold text-white">Arise</div>
                    <button 
                        onClick={lambda e:any -> None { setSidebarOpen(false); }}
                        className="text-gray-400 hover:text-white transition-colors bg-transparent border-none cursor-pointer">
                        <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>

                <nav className="flex-1 p-4 overflow-y-auto">
                    <div className="mb-6">
                        <div className="text-gray-500 text-xs uppercase font-semibold mb-2 px-4">Main</div>
                        <ul className="list-none p-0 m-0  ml-[8px]">
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("dashboard"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + dashboardClasses}>
                                    <span>Dashboard</span>
                                </div>
                            </li>
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("notifications"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + notificationsClasses}>
                                    <span className="flex items-center justify-between w-full">
                                        <span>Notifications</span>
                                        {unreadCount > 0 && (
                                            <span className="ml-auto bg-primary text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center">
                                                {unreadCount}
                                            </span>
                                        )}
                                    </span>
                                </div>
                            </li>
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("skills"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + skillsClasses}>
                                    <span>Skills</span>
                                </div>
                            </li>
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("roles"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + rolesClasses}>
                                    <span>Roles</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div>
                        <div className="text-gray-500 text-xs uppercase font-semibold mb-2 px-4">Actions</div>
                        <ul className="list-none p-0 m-0  ml-[8px]">
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("roadmap"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + roadmapClasses}>
                                    <span>My Roadmap</span>
                                </div>
                            </li>
                            <li className="mb-[2px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("quizzes"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + quizzesClasses}>
                                    <span>Quizzes</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>

                <div className="p-4 border-t border-gray-800">
                    <div className="flex items-center gap-3 px-4 py-3">
                        <div className="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white font-semibold">
                            U
                        </div>
                        <div className="flex-1">
                            <div className="text-white text-sm font-medium">User Name</div>
                            <div className="text-gray-400 text-xs">user@email.com</div>
                        </div>
                    </div>
                </div>
            </div>;
        }

        def ProfilePanel() -> any {
            return <div className="hidden lg:block lg:w-80 bg-[#0b0b0b] h-screen border-l border-gray-800 p-6">
                
                <div className="flex flex-col items-center mb-6">
                    <div className="w-20 h-20 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-2xl mb-4">
                        U
                    </div>
                    <div className="text-white font-medium">User Name</div>
                    <div className="text-gray-400 text-sm">user@email.com</div>
                </div>
            </div>;
        }

        def MobileProfilePanel() -> any {
            let baseClasses = "fixed top-0 right-0 bg-[#0b0b0b] h-screen w-[80%] max-w-[300px] transform transition-transform duration-300 ease-in-out z-[100000] border-l border-gray-800 p-6 overflow-y-auto";
            let positionClass = "translate-x-0" if profileOpen else "translate-x-full";

            return <div className={baseClasses + " " + positionClass}>
                <div className="flex items-center justify-between mb-6">
                    <h3 className="text-white font-semibold text-lg">Profile</h3>
                    <button 
                        onClick={lambda e:any -> None { setProfileOpen(false); }}
                        className="text-gray-400 hover:text-white transition-colors bg-transparent border-none cursor-pointer">
                        <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>

                <div className="flex flex-col items-center mb-6">
                    <div className="w-20 h-20 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-2xl mb-4">
                        U
                    </div>
                    <div className="text-white font-medium">User Name</div>
                    <div className="text-gray-400 text-sm">user@email.com</div>
                </div>

            </div>;
        }

        def DashHeader() -> any {
            return <div className="lg:hidden fixed top-0 left-0 right-0 bg-[#0b0b0b] border-b border-gray-800 p-4 flex items-center justify-between z-[1000]">
                <button 
                    onClick={lambda e:any -> None { setSidebarOpen(true); }}
                    className="text-white bg-transparent border-none cursor-pointer">
                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
                    </svg>
                </button>
                <div className="text-xl font-semibold text-white">Arise</div>
                <button 
                    onClick={lambda e:any -> None { setProfileOpen(true); }}
                    className="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-sm border-none cursor-pointer">
                    U
                </button>
            </div>;
        }

        def SelectionManager(props:any) -> any {
            let [inputValue, setInputValue] = useState("");
            
            return <div>
                <div className="flex items-center justify-between mb-6">
                    <div></div>
                    <button 
                        onClick={props.onSave}
                        className="px-6 py-3 bg-primary text-white rounded-lg hover:bg-opacity-80 transition-all border-none cursor-pointer font-semibold">
                        Save Changes
                    </button>
                </div>

                <div className="rounded-lg">
                    <div className="mb-0 font-semibold text-white text-lg mb-2">{props.title}</div>
                    <p className="text-gray-400 text-sm mb-6">{props.description}</p>

                    <div className="relative mb-6">
                        <input 
                            type="text" 
                            placeholder={props.placeholder}
                            value={inputValue}
                            onChange={lambda e:any -> None { setInputValue(e.target.value); }}
                            onKeyDown={lambda e:any -> None {
                                if (e.key == "Enter" && inputValue.trim() != "") {
                                    let alreadySelected = props.selectedItems.includes(inputValue.trim());
                                    if (alreadySelected == false) {
                                        let newSelected = props.selectedItems.concat([inputValue.trim()]);
                                        props.setSelectedItems(newSelected);
                                    }
                                    setInputValue("");
                                }
                            }}
                            className="w-full md:w-[70%] px-4 py-3 pl-10 bg-[#0b0b0b] border border-gray-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-primary transition-colors"
                        />
                        <svg className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                    </div>

                    {props.selectedItems.length > 0 && (
                        <div className="mb-6">
                            <div className="text-gray-400 text-sm mb-2">{props.selectedLabel}</div>
                            <div className="flex flex-wrap gap-2">
                                {props.selectedItems.map(
                                    lambda item:any -> any {
                                        return <div 
                                            key={item}
                                            className="bg-primary text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer flex items-center gap-2 hover:bg-opacity-80 transition-all">
                                            {item}
                                            <svg 
                                                onClick={lambda e:any -> None {
                                                    props.setSelectedItems(props.selectedItems.filter(lambda i:any -> bool { return i != item; }));
                                                }}
                                                className="w-4 h-4 hover:scale-110 transition-transform" 
                                                fill="none" 
                                                stroke="currentColor" 
                                                viewBox="0 0 24 24">
                                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                                            </svg>
                                        </div>;
                                    }
                                )}
                            </div>
                        </div>
                    )}

                    <div className="w-full md:w-[80%]">
                        <div className="text-gray-400 text-sm mb-2">{props.availableLabel}</div>
                        <div className="flex flex-wrap gap-2 overflow-y-auto max-h-[40vh]">
                            {props.availableItems.map(
                                lambda item:any -> any { 
                                    let isSelected = props.selectedItems.includes(item);
                                    if (isSelected == false) {
                                        return <div 
                                            key={item}
                                            onClick={lambda e:any -> None {
                                                let newSelected = props.selectedItems.concat([item]);
                                                props.setSelectedItems(newSelected);
                                            }}
                                            className="border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-primary hover:bg-[#0b0b0b]">
                                            {item}
                                        </div>;
                                    }
                                    return null;
                                }
                            )}
                        </div>
                    </div>
                </div>
            </div>;
        }

        def DashContent() -> any {
            return <div className="flex-1 p-6 md:p-8">
                {activeLink == "dashboard" && (
                    <div>
                        <h1 className="text-2xl md:text-3xl font-bold text-white mb-6">Welcome Back!</h1>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div className="border border-gray-800 rounded-lg p-6">
                                <p>Redirect to Udemy?</p>
                            </div>
                            <div className=" border border-gray-800 rounded-lg p-6">
                            
                            </div>
            
                        </div>
                    </div>
                )}

                {activeLink == "notifications" && (
                    <div>
                        <div className="flex items-center justify-between mb-6">
                            <div>
                                <h1 className="text-2xl md:text-3xl font-bold text-white mb-2">Notifications</h1>
                                <p className="text-gray-400">You have {unreadCount} new notifications.</p>
                            </div>
                            {unreadCount > 0 && (
                                <button 
                                    onClick={lambda e:any -> None {
                                        let updatedNotifications = notifications.map(lambda n:any -> any {
                                            return {id: n.id, type: n.type, title: n.title, description: n.description, time: n.time, read: true};
                                        });
                                        setNotifications(updatedNotifications);
                                    }}
                                    className="px-6 py-3 bg-[#101010ff] text-white rounded-lg hover:bg-[#1a1a1a] transition-all border border-gray-700 cursor-pointer font-semibold">
                                    Mark all as read
                                </button>
                            )}
                        </div>

                        <div className="bg-[#101010ff] border border-gray-800 rounded-lg overflow-hidden">
                            {notifications.map(lambda notification:any -> any {
                                let iconBg = "bg-orange-500" if notification.type == "message" else (
                                    "bg-blue-500" if notification.type == "event" else (
                                        "bg-green-500" if notification.type == "success" else "bg-yellow-500"
                                    )
                                );
                                
                                let isUnread = notification.read == false;
                                let bgClass = "bg-[#0b0b0b]" if isUnread else "bg-transparent";
                                
                                return <div 
                                    key={notification.id}
                                    className={bgClass + " border-b border-gray-800 last:border-b-0 p-6 hover:bg-[#0b0b0b] transition-all cursor-pointer"}
                                    onClick={lambda e:any -> None {
                                        if (isUnread) {
                                            let updatedNotifications = notifications.map(lambda n:any -> any {
                                                if (n.id == notification.id) {
                                                    return {id: n.id, type: n.type, title: n.title, description: n.description, time: n.time, read: true};
                                                }
                                                return n;
                                            });
                                            setNotifications(updatedNotifications);
                                        }
                                    }}>
                                    <div className="flex items-start gap-4">
                                        <div className={"w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0 " + iconBg}>
                                            {notification.type == "message" && (
                                                <svg className="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
                                                </svg>
                                            )}
                                            {notification.type == "event" && (
                                                <svg className="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                </svg>
                                            )}
                                            {notification.type == "success" && (
                                                <svg className="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                                                </svg>
                                            )}
                                            {notification.type == "warning" && (
                                                <svg className="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                                </svg>
                                            )}
                                        </div>
                                        
                                        <div className="flex-1 min-w-0">
                                            <div className="flex items-start justify-between gap-4 mb-1">
                                                <h3 className="text-white font-semibold flex items-center gap-2">
                                                    {notification.title}
                                                    {isUnread && (
                                                        <span className="w-2 h-2 bg-primary rounded-full"></span>
                                                    )}
                                                </h3>
                                                <span className="text-gray-400 text-sm flex-shrink-0">{notification.time}</span>
                                            </div>
                                            <p className="text-gray-400 text-sm">{notification.description}</p>
                                        </div>
                                    </div>
                                </div>;
                            })}
                        </div>
                    </div>
                )}

                {activeLink == "skills" && (
                    <SelectionManager 
                        title="Select Your Skills"
                        description="Choose or add your skills"
                        placeholder="Search or type a skill and press Enter"
                        selectedLabel="Selected Skills"
                        availableLabel="Available Skills"
                        availableItems={devSkills}
                        selectedItems={selectedSkills}
                        setSelectedItems={setSelectedSkills}
                        onSave={lambda -> None {}}
                    />
                )}

                {activeLink == "roles" && (
                    <SelectionManager 
                        title="Select Your Roles"
                        description="Choose or add your target roles"
                        placeholder="Search or type a role and press Enter"
                        selectedLabel="Selected Roles"
                        availableLabel="Available Roles"
                        availableItems={devRoles}
                        selectedItems={selectedRoles}
                        setSelectedItems={setSelectedRoles}
                        onSave={lambda -> None {}}
                    />
                )}

                {activeLink == "roadmap" && (
                    <div>
                        <h1 className="text-2xl md:text-3xl font-bold text-white mb-6">My Roadmap</h1>
                        <p className="text-gray-400">Your personalized learning path</p>
                    </div>
                )}

                {activeLink == "quizzes" && (
                    <div>
                        <h1 className="text-2xl md:text-3xl font-bold text-white mb-6">Quizzes</h1>
                        <p className="text-gray-400">Test your knowledge</p>
                    </div>
                )}
            </div>;
        }

        return <div className="min-h-screen bg-black">
            {sidebarOpen && (
                <div 
                    onClick={lambda e:any -> None { setSidebarOpen(false); }}
                    className="fixed inset-0 bg-black bg-opacity-50 z-[99999] lg:hidden"
                ></div>
            )}
            {profileOpen && (
                <div 
                    onClick={lambda e:any -> None { setProfileOpen(false); }}
                    className="fixed inset-0 bg-black bg-opacity-50 z-[99999] lg:hidden"
                ></div>
            )}

            <DashSideBar />
            <MobileDashSideBar />

            <div className="md:ml-64 lg:mr-80 min-h-screen">
                <DashHeader />
                <div className="pt-16 lg:pt-0">
                    <DashContent />
                </div>
            </div>

            <div className="hidden lg:block fixed top-0 right-0">
                <ProfilePanel />
            </div>
            <MobileProfilePanel />
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
