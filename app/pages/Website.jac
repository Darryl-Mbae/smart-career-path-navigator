cl import from react { useState,useRef,useEffect }
cl import from "@jac-client/utils" { useNavigate }
cl import from 'lucide-react' { Mail,User, ChevronUp, Video, ChevronRight,Send, ChevronLeft, Github, Linkedin, AudioLines }
cl import from 'radix-ui' { Accordion }
cl import from '@radix-ui/react-icons' { ChevronDownIcon }

cl import from "@jac-client/assets/team/Darryl.png" { default as Darryl}
cl import from "@jac-client/assets/team/Dennis.png" { default as Dennis}
cl import from "@jac-client/assets/team/Moha.png" { default as Moha}
cl import from "@jac-client/assets/images/mac-skills.png" { default as skills}
cl import from "@jac-client/assets/images/mobile-dash.png" { default as phone }
cl import from "@jac-client/assets/images/laptop-dash.png" { default as desktop }



cl import from "swiper/react" {
    Swiper,
    SwiperSlide
}

cl import from "swiper/modules" {
    Navigation,
    Pagination
}

cl {
        def Website() -> any {

            useEffect(lambda -> None {
                let cssLink = document.createElement("link");
                cssLink.rel = "stylesheet";
                cssLink.href = "https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css";
                document.head.appendChild(cssLink);
            }, []);


            let [sideBarActive,setSideBarActivate] = useState(false);

            def NavBar(props:any) -> any {
                let links = ["GITHUB", "FEATURES", "FAQs", "TEAM"];
                let navigate = useNavigate();
                
                def MobileNav() -> any {
                
                    
                    return <div className="flex md:hidden items-center justify-between text-white">
                        <a href="/app" className="text-[1.125rem] font-semibold cursor-pointer text-white no-underline">Arise</a>
                        <button 
                            onClick={lambda e:any -> None {props.setSideBarActivate(false if props.sideBarActive else true);}} 
                            type="button">
                            
                        </button>
                    </div>;
                }
                
                def DesktopNav() -> any {

                return <div className="hidden md:flex  items-center justify-between text-white ">
                        <a href="/app" className="text-[1.125rem] font-semibold cursor-pointer text-white no-underline">Arise</a>
                        <div className="flex items-center gap-[2rem]">
                            <ul className="relative z-10 flex items-center gap-[10px] list-none">
                                {links.map(
                                    lambda link:any -> any{ return 
                                    <li key={link} className="relative text-[14px] cursor-pointer px-2 py-1 rounded-[4px]"
                                     onClick={lambda e:any -> None{
                                        if (link == "GITHUB") {
                                            window.open(
                                                "https://github.com/Darryl-Mbae/smart-career-path-navigator",
                                                "_blank"
                                            );
                                        } else {
                                            let section = document.getElementById(link);
                                            section?.scrollIntoView({ behavior: "smooth" });
                                        }
                                    }}
                                    >{link}</li>;
                                    }
                                )}
                            </ul>
                            <button 
                            onClick={lambda e:any -> None{navigate("/auth");}}
                            className="w-auto bg-primary text-white border-none cursor-pointer text-[16px] px-10 py-4 rounded-[5px] transition-transform duration-200 ease-in-out hover:translate-y-1">Get Started</button>
                        </div>
                    </div>;
                }

                return<div className="sticky top-4 z-[99999] w-[calc(92%-6px)] mx-auto py-4 px-6 rounded-md transition-all duration-200 bg-[rgba(0,0,0,.5)] backdrop-blur-[12px] border border-transparent">
                    <MobileNav/>
                    <DesktopNav/>
                </div>;
            }

            def Sidebar(props:any) -> any {
                return <div>
                </div>;
            }


            def Homepage() -> any {
                let [btn1Hover, setBtn1Hover] = useState(false);
                let [btn2Hover, setBtn2Hover] = useState(false);

                
                return<div className="h-[75vh] w-[80%] mx-auto flex flex-col text-white mt-[5vh] grid grid-cols-[100%] md:grid-cols-[60%_40%]">
                    <div className="flex flex-col">
                        <div className="px-5 py-2 rounded-2xl bg-primary w-max mb-2 ">Find Your Future</div>
                        <h1 className="font-zalando text-5xl md:text-6xl leading-none font-bold my-2">AI-Powered Career Mapping for the Modern Workforce </h1>
                        <p className="w-[95%]">Your skills tell a story. We analyze them, match them to emerging roles, and create a personalized growth roadmap — turning uncertainty into clarity and ambition into direction.</p>
                        <div className="w-[90%] mt-[2rem] flex flex-col md:flex-row gap-3 md:items-center">
                            <button type="button" className="w-auto bg-primary text-white border-none cursor-pointer text-base px-10 py-4 rounded-md transition-transform duration-200 ease-in-out hover:translate-y-1">
                                Get Started
                            </button>
                            <button
                                type="button"
                                onClick={lambda e: any -> None{ let section = document.getElementById("demo");section?.scrollIntoView({behavior: "smooth"});} }
                                class="w-auto border border-white bg-transparent text-white cursor-pointer text-base px-10 py-4 rounded-md transition-transform duration-200 ease-in-out hover:translate-y-1"
                            >
                                View Demo
                            </button>
                        </div>
                    </div>
                </div>;
            }

            def Demo() -> any {

                let [isPlaying, setIsPlaying] = useState(false);
                let videoRef = useRef(null);

                def handlePlayPause() -> any {
                    if (videoRef.current){
                        if (isPlaying){
                            videoRef.current.pause();
                        }
                        else{
                            videoRef.current.play();
                        }
                        setIsPlaying(not isPlaying);
                    }
                };

                return<div className="w-full h-[102vh] mt-1 rounded-[50px] bg-primary flex">
                    <div className="w-[80%] mx-auto grid grid-cols-1 lg:grid-cols-[45%_55%]">
                        <div className="flex flex-col justify-center w-[90%]">
                            <Video  className="w-10 h-10 mb-4 text-white" />
                            <h2 className="text-4xl md:text-5xl font-bold mb-4 text-white">
                                See the Platform in Action
                            </h2>   
                                <p className="text-lg mb-6 text-gray-100">
                                    Watch how your skills are analyzed, matched to in-demand careers,
                                    and transformed into a clear, personalized growth roadmap.
                                </p>
                            <button
                                type="button"
                                onClick={handlePlayPause}
                                className="w-fit bg-black text-white border-none cursor-pointer text-base px-10 py-4 rounded-md transition-transform duration-200 ease-in-out hover:translate-y-1"
                             >
                                { "Pause Video" if isPlaying else "Play Video" }
                            </button>
                        </div>

                        <div className="w-full rounded-[10px] overflow-hidden my-auto">
                            <video
                                ref={videoRef}
                                className="w-full h-auto object-cover"
                                src="/static/assets/draft-6.webm"
                                controls={False}
                                draggable={True}
                                />
                        </div>
                    </div>
                </div>;
            }
            
            def Features() -> any {
                return 
                    <div id="FEATURES" className='pt-20 w-[90%] my-[15vh] mx-auto grid grid-cols-1 lg:grid-cols-[50%_50%] mb-[10vh] lg:mb-[20vh]'>
                        <div className='w-full overflow-hidden relative mb-4 lg:mb-0 lg:w-[90%] bg-primary rounded-4xl aspect-square'>
                            <img
                                src={skills}
                                alt="skills illustration"
                                className='absolute top-10 -right-50 lg:top-20 lg:-right-80 h-[80%] w-auto max-w-none'
                            />
                        </div>
                        <div className='w-full lg:w-[90%] ml-[5%] flex flex-col justify-center'>
                            <AudioLines className="w-10 h-10 mb-4 text-purple-300" />
                            <h2 className="font-bold text-4xl text-white mb-7 w-full font-sans">
                                AI-Powered Career Mapping,<br /> Made for Learners
                            </h2>
                            <p className="text-base text-gray-100 mb-8 w-[95%]">
                                Arise is an intelligent career platform that analyzes your skills, identifies career opportunities, 
                                and creates personalized learning roadmaps to help you reach your professional goals.
                            </p>

                            <div className='w-[90%] bg-[#0b0b0b] text-white placeholder-gray-400 lg:w-[85%] flex items-center gap-3 py-4 px-4 mt-6 rounded-lg'>
                                <div className='w-1.5 h-1.5 rounded-full bg-primary'></div>
                                <div className=''>Analyzing your CV and skill profile</div>
                            </div>

                            <div className='w-[90%] bg-[#0b0b0b] text-white placeholder-gray-400 lg:w-[85%] flex items-center gap-3 py-4 px-4 mt-2 rounded-lg'>
                                <div className='w-1.5 h-1.5 rounded-full bg-primary'></div>
                                <div className=''>Identifying career opportunities that fit you</div>
                            </div>

                            <div className='w-[90%] bg-[#0b0b0b] text-white placeholder-gray-400 lg:w-[85%] flex items-center gap-3  py-4 px-4 mt-2 rounded-lg'>
                                <div className='w-1.5 h-1.5 rounded-full bg-primary'></div>
                                <div className=''>Highlighting skill gaps and growth areas</div>
                            </div>

                            <div className='w-[90%] bg-[#0b0b0b] text-white placeholder-gray-400 lg:w-[85%] flex items-center gap-3  py-4 px-4 mt-2 rounded-lg'>
                                <div className='w-1.5 h-1.5 rounded-full bg-primary'></div>
                                <div className=''>Building personalized learning roadmaps</div>
                            </div>

                        </div>
                    </div>;
                
            }

            def Team() -> any {

                let swiperRef = useRef(null);
                let [activeSlide, setActiveIndex] = useState(0);
                let paragraph = "Arise is led by passionate students with diverse experiences. Our team brings together different perspectives to create an AI-powered career mapping platform that empowers learners to achieve their professional goals.";
                let startIndex = Math.floor(Math.random() * 3);


                let teamMembers = [
                    { id: 1, name: "Darryl Mbae",image: Darryl },
                    { id: 2, name: "Denis Kiptui",image: Dennis },
                    { id: 3, name: "Mohamed Ibrahim",image: Moha},
                    { id: 4, name: "Darryl Mbae", image: Darryl},
                    { id: 5, name: "Denis Kiptui", image: Dennis },
                    { id: 6, name: "Mohammed Ibrahim",image: Moha }
                ];

                return<div id="TEAM" className="w-[80%] mx-auto py-20 grid grid-cols-1 lg:grid-cols-[40%_60%] gap-10 items-center">
                    <div>
                        <User className="w-10 h-10 mb-4 text-purple-300"/>
                        <h2 className="font-bold text-4xl text-white mb-7 w-full font-sans">
                            Built by Students,<br/> For Students
                        </h2>
                        <p className="text-base text-gray-100  mb-8 w-[95%]">
                            {paragraph}
                        </p>
                    </div>
                    <div className="relative">
                        <div className="absolute left-0 bottom-0 w-full lg:w-[calc(33.333%-20px)] z-20 pointer-events-none">
                           <div className="w-full bg-primary backdrop-blur-sm rounded-xl px-5 py-3 border border-gray-700/50 shadow-xl">
                            <h3 className="text-white font-bold text-lg mb-3">
                                {teamMembers[activeSlide].name}
                            </h3>

                            <div className="flex gap-2">
                                <button className="w-8 h-8 rounded-full border border-white cursor-pointer flex items-center justify-center transition-colors pointer-events-auto">
                                    <span className="text-white text-xs flex items-center justify-center"><Linkedin className="h-3 w-3 m-auto"/></span>
                                </button>

                                <button className="w-8 h-8 rounded-full border border-white cursor-pointer flex items-center justify-center transition-colors pointer-events-auto">
                                    <span className="text-white text-xs flex items-center justify-center"><Github className="h-3 w-3 m-auto"/></span>
                                </button>

                                 <button className="w-8 h-8 rounded-full border border-white cursor-pointer flex items-center justify-center transition-colors pointer-events-auto">
                                    <span className="text-white text-xs flex items-center justify-center"><Mail className="h-3 w-3 m-auto"/></span>
                                </button>
                            </div>
                        </div>
                        </div>
                        <Swiper
                            initialSlide={startIndex}
                            onSwiper={lambda swiper:any -> None {
                                swiperRef.current = swiper;
                            }}
                            onSlideChange={lambda swiper:any -> None {
                                setActiveIndex(swiper.realIndex);
                            }}
                            slidesPerView={3}
                            modules={[Navigation, Pagination]}
                            spaceBetween={20}
                            loop={True}
                            breakpoints={{
                                0: {          
                                    slidesPerView: 1,
                                    spaceBetween: 15
                                },
                                640: {        
                                    slidesPerView: 1,
                                    spaceBetween: 20
                                },
                                768: {        
                                    slidesPerView: 2,
                                    spaceBetween: 20
                                },
                                1024: {        
                                    slidesPerView: 3,
                                    spaceBetween: 30
                                },
                                1280: {        
                                    slidesPerView: 3,
                                    spaceBetween: 30
                                }
                            }}
                            pagination={{ clickable: true }}
                            className="pb-12"
                         >
                            {teamMembers.map(lambda member:any -> any {
                                return <SwiperSlide key={member.id}>
                                    <div className="h-64 rounded-2xl overflow-hidden transition-all duration-500 grayscale hover:grayscale-0 swiper-slide-active:grayscale-0">
                                        <img
                                            src={member.image}
                                            className="w-full h-full object-cover"
                                        />
                                    </div>
                                </SwiperSlide>;
                            })}
                        </Swiper>


                    </div>
                </div>;

            }


            def NewsletterSubscribe() -> any {
                let [email, setEmail] = useState("");
                let [isSubmitting, setIsSubmitting] = useState(false);
                let [btnHover, setBtnHover] = useState(false);

                return <div id="CONTACT" className="w-11/12 mx-auto rounded-3xl text-white py-16 flex flex-col items-center justify-center shadow-[0_25px_50px_-12px_rgba(0,0,0,0.25)] my-16">
                    <Mail className="w-10 h-10 mb-4 text-purple-300"/>
                    <h2 className="font-bold text-4xl text-center mb-7 w-3/5 font-sans">
                        Stay Ahead of the Curve
                    </h2>
                    <p className="text-base text-gray-100 text-center mb-8 max-w-3xl">
                        Get exclusive insights, product updates, and early access delivered straight to your inbox.
                    </p>
                    <form className="w-[90%] lg:w-1/2 flex flex-row gap-4 mx-auto">
                        <input
                            type="email"
                            placeholder="Enter your email"
                            value={email}
                            disabled={isSubmitting}
                            required
                            onChange={lambda e: any -> None { setEmail(e.target.value); }}
                            className="grow py-4 px-5 rounded-lg border- border-purple-600 bg-[#0b0b0b] text-white placeholder-gray-400 focus:outline-none focus:border-purple-400 transition duration-200"
                        />
                        <button
                            type="submit"
                            disabled={isSubmitting}
                            onMouseEnter={lambda e: any -> None { setBtnHover(true); }}
                            onMouseLeave={lambda e: any -> None { setBtnHover(false); }}
                            className={f"hidden md:flex px-6 py-4 rounded-md bg-purple-800 text-white font-semibold uppercase text-sm cursor-pointer transition-transform duration-200 ease-in-out transform {'translate-y-1' if btnHover else 'translate-y-0'} {'opacity-50' if isSubmitting else 'opacity-100'}"}
                        >
                            {"Subscribing..." if isSubmitting else "Subscribe"}
                        </button>
                        <button
                            type="submit"
                            disabled={isSubmitting}
                            onMouseEnter={lambda e: any -> None { setBtnHover(true); }}
                            onMouseLeave={lambda e: any -> None { setBtnHover(false); }}
                            className={f"flex md:hidden px-6 py-4 rounded-md bg-purple-800 text-white font-semibold uppercase text-sm cursor-pointer transition-transform duration-200 ease-in-out transform {'translate-y-1' if btnHover else 'translate-y-0'} {'opacity-50' if isSubmitting else 'opacity-100'}"}
                        >
                            <Send />
                        </button>
                    </form>
                </div>;
            }


            def FAQs() -> any {

                let faqData = [
                    {
                        value: "arise",
                        question: "What is Arise and how does it work?",
                        answer: "Arise is an AI-powered career mapping platform that analyzes your CV, identifies career opportunities, and generates personalized learning roadmaps."
                    },
                    {
                        value: "formats",
                        question: "Which file formats are supported for CV upload?",
                        answer: "You can upload PDF, DOC, and DOCX files. Arise automatically extracts skills, experience, and certifications."
                    },
                    {
                        value: "roles",
                        question: "How does Arise recommend career roles?",
                        answer: "Arise uses AI and real-time job market data to match your skills with roles that align with your career goals."
                    },
                    {
                        value: "roadmap",
                        question: "Can I customize my learning roadmap?",
                        answer: "Yes. You can add or remove skills, update career goals, and Arise will regenerate your roadmap."
                    },
                    {
                        value: "security",
                        question: "Is my data safe on Arise?",
                        answer: "Absolutely. Your data is securely stored in Jaseci’s graph database and never shared without your consent."
                    },
                    {
                        value: "FEATURES",
                        question: "Do I need a subscription to use Arise?",
                        answer: "Arise offers both free and premium plans. Premium users access advanced skill gap analysis and learning paths."
                    },
                    {
                        value: "updates",
                        question: "How often are recommendations updated?",
                        answer: "Career suggestions and learning paths are updated in real time using live market data."
                    },
                    {
                        value: "tracking",
                        question: "Can I track my progress?",
                        answer: "Yes. Arise’s dashboard lets you track skills, certifications, and learning milestones."
                    }
                ];

                # single source of truth
                let [openItem, setOpenItem] = useState("");

                return <div id="FAQs" className="w-[88%] max-w-4xl mx-auto py-20">

                    <h2 className="text-4xl font-bold text-center mb-10 text-white">
                        Frequently Asked Questions
                    </h2>

                    <Accordion.Root
                        type="single"
                        collapsible
                        value={openItem}
                        onValueChange={lambda val:any -> None { setOpenItem(val); }}
                        className="flex flex-col gap-3"
                    >
                        {faqData.map(
                            lambda faq:any -> any {

                                let chevronBase = "transition-transform duration-300";
                                let chevronRotate = "rotate-180" if openItem == faq.value else "";

                                return <Accordion.Item
                                    key={faq.value}
                                    value={faq.value}
                                    className="bg-violet-800 rounded-lg border border-white/10 px-5 py-6"
                                >
                                    <Accordion.Trigger
                                        className="w-full flex items-center justify-between text-left text-white text-base cursor-pointer bg-transparent border-none outline-none"
                                    >
                                        {faq.question}

                                        <ChevronUp
                                            className={chevronBase + " " + chevronRotate}
                                        />
                                    </Accordion.Trigger>

                                    <Accordion.Content
                                        className="pt-3 text-gray-300 text-sm leading-relaxed"
                                    >
                                        {faq.answer}
                                    </Accordion.Content>
                                </Accordion.Item>;
                            }
                        )}
                    </Accordion.Root>
                </div>;
            }

            def Footer() -> any {
                let currentYear = "2025";

                let socialLinks = [
                    {name: "Twitter", href: "https://twitter.com/AriseAI", path: "M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"},
                    {name: "Instagram", href: "https://instagram.com/AriseAI", path: "M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"},
                    {name: "GitHub", href: "https://github.com/Darryl-Mbae/smart-career-path-navigator", path: "M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"},
                    {name: "LinkedIn", href: "https://linkedin.com/company/AriseAI", path: "M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"}
                ];

                let footerSections = [
                    {title: "Company", links: [
                        {label: "Demo", href: "DEMO"},
                        {label: "Features", href: "FEATURES"},
                        {label: "Team", href: "TEAM"}
                    ]},
                    {title: "Resources", links: [
                        {label: "Contact", href: "CONTACT"},
                        {label: "FAQs", href: "FAQs"},
                        {label: "Github", href: "https://github.com/Darryl-Mbae/smart-career-path-navigator", external:true},
                    ]},
                   {title: "Legal", links: [
                        { label: "Terms of Service", href:"/static/assets/TOS.pdf" , external: true },
                        { label: "Privacy Policy", href:"/static/assets/PrivacyPolicy.pdf" , external: true },
                    ]}


                ];

                return <footer className="py-12 w-full bg-black">
                    <div className="max-w-7xl mx-auto px-8">
                        <div className="bg-[#0b0b0b] rounded-3xl p-12 shadow-md">
                            <div className="grid grid-cols-1 lg:grid-cols-5 gap-8 border-b border-gray-800 pb-10">
                                <div className="col-span-2 flex flex-col gap-6">
                                    <div className="flex items-center gap-2">
                                        <span className="text-white font-bold text-xl">Arise</span>
                                    </div>
                                    <p className="text-gray-400 max-w-xs leading-relaxed">
                                        Arise is an AI-powered career mapping platform that analyzes your skills, identifies career opportunities, and creates personalized learning roadmaps to help you achieve your professional goals.
                                    </p>
                                    <div className="flex gap-4 pt-2">
                                        {socialLinks.map(lambda social: any -> any {
                                            return <a key={social.name} href={social.href} target="_blank" rel="noopener noreferrer" className="text-gray-400 hover:text-white transition-colors">
                                                <svg className="w-5 h-5 fill-current" viewBox="0 0 24 24">
                                                    <path d={social.path}/>
                                                </svg>
                                            </a>;
                                        })}
                                    </div>
                                </div>

                                <div className="hidden col-span-3 lg:grid grid-cols-4 gap-6">
                                    {footerSections.map(lambda section: any -> any {
                                        return <div key={section.title} className="flex flex-col gap-2">
                                            <h3 className="text-white font-semibold text-sm">{section.title}</h3>
                                           {section.links.map(lambda link:any -> any {
                                                return
                                                <a
                                                    key={link.label}
                                                    href={link.href}
                                                    className="text-gray-400 text-sm hover:text-white cursor-pointer"
                                                    onClick={lambda e:any -> None {
                                                        if (link.external == true ) {
                                                            e.preventDefault();
                                                            window.open(
                                                                link.href,
                                                                "_blank",
                                                                "noopener,noreferrer"
                                                            );
                                                            return;
                                                        }

                                                        e.preventDefault();
                                                        let sectionEl = document.getElementById(link.href);
                                                        sectionEl?.scrollIntoView({ behavior: "smooth" });
                                                    }}
                                                    >
                                                    {link.label}
                                                    </a>;

                                            })}

                                        </div>;
                                    })}
                                </div>
                            </div>

                            <div className="flex flex-wrap justify-between items-center pt-6 gap-4">
                                <p className="text-gray-500 text-sm">© {currentYear} Arise. All rights reserved.</p>
                                <div className="flex gap-6 text-sm">
                                    {footerSections[2].links.map(lambda link: any -> any {
                                        return <a key={link.href} href={link.href} target="_blank" rel="noopener noreferrer" className="text-gray-500 hover:text-white whitespace-nowrap">{link.label}</a>;
                                    })}
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>;
            }




            return <div className="w-full min-h-screen m-0 p-0 bg-black relative font-sans overflow-hidden">
                <NavBar sideBarActive={sideBarActive} setSideBarActivate={setSideBarActivate} />
                <Sidebar sideBarActive={sideBarActive} setSideBarActivate={setSideBarActivate} />   
                <Homepage />
                <Demo />
                <Features />
                <Team />
                <NewsletterSubscribe />
                <FAQs />
                <Footer />
                
            </div>;
        }
}