import from react { useState,useEffect }
import from 'lucide-react' { Mail, Brain, LogOut, CloudUpload, Check, Goal, Route as Node, ChevronUp, ChevronLeft }
import from "@jac-client/utils" {
    useNavigate,
    Router,
    Routes,
    Route,
}

import ".global.css";

    def Website() -> any {

        let [sideBarActive,setSideBarActivate] = useState(false);

        def NavBar(props:any) -> any {
            let links = ["CHANGELOG", "PRICING", "FAQs", "RESOURCES"];
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
                                <li key={link} className="relative text-[14px] cursor-pointer px-2 py-1 rounded-[4px]">{link}</li>;
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
                    <h1 className="font-display text-5xl md:text-6xl leading-none font-bold my-2">AI-Powered Career Mapping for the Modern Workforce </h1>
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
            return<div className="w-full h-[102vh] mt-1 rounded-[50px] bg-primary">
            </div>;
        }
        
        def Features() -> any {
            return<div>
            </div>;
        }

        def Pricing() -> any {
            return<div>
            </div>;
        }

        def NewsletterSubscribe() -> any {
            return<div>
            </div>;
        }

        def FAQs() -> any {
            return<div>
            </div>;
        }

        def Footer() -> any {
            return<div>
            </div>;
        }


         return <div className="w-full min-h-screen m-0 p-0 bg-black relative font-sans overflow-hidden">
            <NavBar sideBarActive={sideBarActive} setSideBarActivate={setSideBarActivate} />
            <Sidebar sideBarActive={sideBarActive} setSideBarActivate={setSideBarActivate} />   
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

        let baseClasses = "hidden md:flex w-1/2 h-full absolute top-0 justify-center items-center pointer-events-none transition-all duration-300 ease-in";
        let positionClass = "left-1/2" if isSignIn else "left-0";

        let signInClass = "block md:flex" if isSignIn else "hidden md:flex";
        let signUpClass = "hidden md:flex" if isSignIn else "block md:flex";

        async def handleLogin(e: any) -> None {
            navigate("/dashboard");
        }
        async def handleSignup(e: any) -> None {
            navigate("/onboarding");
        }

        def Header() -> any {
            return <div className="w-[90%] md:w-[calc(70%+1.25rem)] text-left mb-4">
                <div
                    onClick={lambda e: any -> None { navigate("/"); }}
                    className="flex flex-row items-center text-gray-400 cursor-pointer mb-2"
                >
                    <span><ChevronLeft /></span>
                    <span className="ml-1">Back</span>
                </div>
            </div>;
        }

        return <div className="w-full h-screen grid overflow-hidden grid-cols-[100%] md:grid-cols-[50%_50%] relative text-white">

            <div className={signInClass + " w-full h-screen flex items-center justify-center"}>
                <div className="w-full flex flex-col items-center p-6">
                    <Header/>
                    <h2 className="w-[90%] md:w-[calc(70%+1.25rem)] text-xl font-bold my-[20px] md:pl-[10px]">Create your account</h2>
                    <form onSubmit={handleLogin} className="w-full flex flex-col items-center w-[90%] md:w-[70%]">
                        <input
                            type="email"
                            placeholder="Email"
                            value={loginEmail}
                            onChange={lambda e: any -> None { setLoginEmail(e.target.value); }}
                            className="p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"
                        />
                        <input/>
                        <input
                            type="password"
                            placeholder="Password"
                            value={loginPassword}
                            onChange={lambda e: any -> None { setLoginPassword(e.target.value); }}
                            className="p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"
                        />
                        <input/>
                        <button
                            type="submit"
                            className="w-full p-5 rounded-[8px] border-none bg-primary text-white font-semibold cursor-pointer"
                        >Sign In</button>
                    </form>
                    <p className="mt-[19px] text-[14px] text-[#bbbbbb] items-center">
                        Don't have an account?
                        <span onClick={lambda e: any -> None { setIsSignIn(False); }} className="text-primary cursor-pointer ml-[5px] font-semibold">Sign Up</span>
                    </p>
                </div>
            </div>

            <div className={signUpClass + " w-full h-screen flex items-center justify-center"}>
                <div className="w-full flex flex-col items-center p-6">
                    <Header/>
                    <h2 className="w-[90%] md:w-[calc(70%+1.25rem)] my-[20px] text-xl font-bold md:pl-[10px]">Create your account</h2>
                    <form onSubmit={handleSignup} className="w-[90%] md:w-[70%] flex flex-col items-center">
                        <input
                            type="text"
                            placeholder="Full Name"
                            value={signupName}
                            onChange={lambda e: any -> None { setSignupName(e.target.value); }}
                            className="p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"
                        />
                        <input
                            type="email"
                            placeholder="Email"
                            value={signupEmail}
                            onChange={lambda e: any -> None { setSignupEmail(e.target.value); }}
                            className="p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"
                        />
                        <input
                            type="password"
                            placeholder="Password"
                            value={signupPassword}
                            onChange={lambda e: any -> None { setSignupPassword(e.target.value); }}
                            className="p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"
                        />
                        <input/>
                        <button
                            type="submit"
                            className="w-full p-5 rounded-[8px] border-none bg-primary text-white font-semibold cursor-pointer"
                        >Sign Up</button>
                    </form>
                    <p className="mt-[19px] text-[14px] text-[#bbbbbb] items-center">
                        Already have an account?
                        <span onClick={lambda e: any -> None { setIsSignIn(True); }} className="text-primary cursor-pointer ml-[5px] font-semibold">Sign In</span>
                    </p>
                </div>
            </div>

            <div className={baseClasses + " " + positionClass}>
                <div className="m-auto bg-primary w-[97%] h-[97%] z-[9999] rounded-[10px] flex justify-center items-center overflow-hidden"></div>
            </div>

        </div>;
    }

    def Onboarding() -> any {
        let [currentStep, setCurrentStep] = useState(1);
        let [stepCompleted,setStepCompleted] = useState(0);
        let [navbtnHover, setNavBtnHover] = useState("");
        let [progress,setProgress] = useState(25);
        let [resumeHover,setResumeHover] = useState(false);

        let [selectedInterests, setSelectedInterests] = useState([]);
        let [selectedRoles, setSelectedRoles] = useState([]);

        let navigate = useNavigate();

        let devSkills = ["JavaScript", "Python", "React", "Node.js", "TypeScript", "HTML & CSS", "Django", "Flutter", "Git & GitHub", "SQL & Databases", "REST APIs", "GraphQL", "Docker", "Agile & Scrum"];
        let devRoles = ["Frontend Developer", "Backend Developer", "Fullstack Developer", "Mobile Developer", "DevOps Engineer", "UI/UX Designer", "Data Scientist", "Machine Learning Engineer"];


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

            let circleBase = "w-[40px] aspect-square rounded-full flex items-center justify-center relative z-10 transition-all duration-200 text-white";
            let circleShadow = "shadow-[0_0_20px_rgba(110,17,176,0.5)]" if props.step.id == currentStep else "";
            let circleBg = "bg-purple-800" if props.step.id <= currentStep else "bg-black";

            let lineBase = "absolute left-1/2 top-full -translate-x-1 z-[-1] h-[calc(100%+65px)] w-[2px] transition-all duration-200";
            let lineColor = "border-l-2 border-dashed border-purple-800" if props.step.id < currentStep else "border-l-2 border-dashed border-gray-400";

            let titleBase = "mb-0 font-semibold text-[1.15rem]";
            let titleColor = "text-white" if props.step.id <= currentStep else "text-whitesmoke";

            return <div className="flex flex-row gap-9 items-center w-3/4 mx-auto mb-[45px]">
                <div className={circleBase + " " + circleShadow + " " + circleBg}>
                    <div className="flex items-center justify-center relative w-full h-full">
                        {props.step.icon}

                        {props.step.id != 4 and <div className={lineBase + " " + lineColor}></div>}
                    </div>
                </div>

                <div>
                    <h1 className={titleBase + " " + titleColor}>{props.step.title}</h1>
                    <p className="text-gray-400 mt-2 mb-0">{props.step.description}</p>
                </div>
            </div>;
        }

        def Skills(props:any) -> any {
            let [inputValue, setInputValue] = useState("");
            
            return <div className="h-[60vh] w-full">
                <div className="mb-0 font-semibold text-white text-[1.15rem]">Select Your Skills</div>
                <p className="text-gray-500 my-0 mt-[10px] mb-6">Choose or add your skills</p>
                
                <div className="relative mb-6">
                    <input 
                        type="text" 
                        placeholder="Search or type a skill and press Enter"
                        value={inputValue}
                        onChange={lambda e:any -> None { setInputValue(e.target.value); }}
                        onKeyDown={lambda e:any -> None {
                            if (e.key == "Enter" && inputValue.trim() != "") {
                                let alreadySelected = props.selectedInterests.includes(inputValue.trim());
                                if (alreadySelected == false) {
                                    let newSelected = props.selectedInterests.concat([inputValue.trim()]);
                                    props.setSelectedInterests(newSelected);
                                }
                                setInputValue("");
                            }
                        }}
                        className="w-full px-4 py-3 pl-10 bg-[#101010ff] border border-gray-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-[#6e11b0] transition-colors"
                    />
                    <svg className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                    </svg>
                </div>

                {props.selectedInterests.length > 0 && (
                    <div className="mb-6">
                        <div className="text-gray-400 text-sm mb-2">Selected Skills</div>
                        <div className="flex flex-wrap gap-2">
                            {props.selectedInterests.map(
                                lambda skill:any -> any {
                                    return <div 
                                        key={skill}
                                        className="bg-primary text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer flex items-center gap-2 hover:bg-opacity-80 transition-all">
                                        {skill}
                                        <svg 
                                            onClick={lambda e:any -> None {
                                                props.setSelectedInterests(props.selectedInterests.filter(lambda i:any -> bool { return i != skill; }));
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

                <div>
                    <div className="text-gray-400 text-sm mb-2">Available Skills</div>
                    <div className="flex flex-wrap gap-2 overflow-y-auto  md:max-h-[25vh]">
                        {props.interests.map(
                            lambda interest:any -> any { 
                                let isSelected = props.selectedInterests.includes(interest);
                                if (isSelected == false) {
                                    return <div 
                                        key={interest}
                                        onClick={lambda e:any -> None {
                                            let newSelected = props.selectedInterests.concat([interest]);
                                            props.setSelectedInterests(newSelected);
                                        }}
                                        className="border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-[#6e11b0] hover:bg-[#0b0b0b]">
                                        {interest}
                                    </div>;
                                }
                                return null;
                            }
                        )}
                    </div>
                </div>
            </div>;
        }

        def Roles(props:any) -> any {
            let [inputValue, setInputValue] = useState("");

            return <div className="h-[60vh] w-full">
                <div className="mb-0 font-semibold text-white text-[1.15rem]">Select Your Roles</div>
                <p className="text-gray-500 my-0 mt-[10px] mb-6">Choose or add your roles</p>

                <div className="relative mb-6">
                    <input 
                        type="text" 
                        placeholder="Search or type a role and press Enter"
                        value={inputValue}
                        onChange={lambda e:any -> None { setInputValue(e.target.value); }}
                        onKeyDown={lambda e:any -> None {
                            if (e.key == "Enter" && inputValue.trim() != "") {
                                let alreadySelected = props.selectedRoles.includes(inputValue.trim());
                                if (alreadySelected == false) {
                                    let newSelected = props.selectedRoles.concat([inputValue.trim()]);
                                    props.setSelectedRoles(newSelected);
                                }
                                setInputValue("");
                            }
                        }}
                        className="w-full px-4 py-3 pl-10 bg-[#101010ff] border border-gray-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-[#6e11b0] transition-colors"
                    />
                    <svg className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                    </svg>
                </div>

                {props.selectedRoles.length > 0 && (
                    <div className="mb-6">
                        <div className="text-gray-400 text-sm mb-2">Selected Roles</div>
                        <div className="flex flex-wrap gap-2">
                            {props.selectedRoles.map(
                                lambda role:any -> any {
                                    return <div 
                                        key={role}
                                        className="bg-primary text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer flex items-center gap-2 hover:bg-opacity-80 transition-all">
                                        {role}
                                        <svg 
                                            onClick={lambda e:any -> None {
                                                props.setSelectedRoles(props.selectedRoles.filter(lambda i:any -> bool { return i != role; }));
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

                <div>
                    <div className="text-gray-400 text-sm mb-2">Available Roles</div>
                    <div className="flex flex-wrap gap-2 overflow-y-auto  md:max-h-[25vh]">
                        {props.roles.map(
                            lambda role:any -> any { 
                                let isSelected = props.selectedRoles.includes(role);
                                if (isSelected == false) {
                                    return <div 
                                        key={role}
                                        onClick={lambda e:any -> None {
                                            let newSelected = props.selectedRoles.concat([role]);
                                            props.setSelectedRoles(newSelected);
                                        }}
                                        className="border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-[#6e11b0] hover:bg-[#0b0b0b]">
                                        {role}
                                    </div>;
                                }
                                return null;
                            }
                        )}
                    </div>
                </div>
            </div>;
        }


        return<div className="w-full h-screen grid grid-cols-[100%} md:grid-cols-[45%_55%] relative text-white">
            <div className="hidden w-full h-full md:flex justify-center items-center">
                <div className="m-auto bg-[#0b0b0b] w-[95%] h-[90%] z-[9999] rounded-[10px] flex flex-col justify-center items-center overflow-hidden">
                    {steps.map(
                        lambda step:any -> any { return 
                        <Step
                            key={step.id}
                            step={step}
                            isActive={currentStep == step.id}
                        />;
                        }
                    )}   
                </div>
            </div>
            <div className="w-full h-[95%] my-auto flex justify-center items-center">
                <div className="w-[90%] h-[90%] flex flex-col justify-center">
                    <div className="text-gray-500 uppercase">Step {currentStep} of 4</div>
                          
                    <div className="w-full md:w-[80%] h-[11px] rounded-[20px] bg-[#0b0b0b] overflow-hidden my-5">
                        <div
                            style={{
                                "height": "100%",
                                "width": progress,     
                                "backgroundColor": "#6e11b0",
                                "transition": "0.3s ease",
                                "borderRadius": "20px"
                            }}
                        ></div>
                    </div>

                    { currentStep == 1 &&
                        <div className="h-[60vh]">
                            <div className="mb-0 font-semibold text-white text-[1.15rem]">Upload your CV</div>
                            <p className="text-gray-500 my-0 mt-[10px]">Let us start by understanding your background</p>
                            <div className="my-[30px] h-[40vh] w-full md:w-[80%] rounded-[15px] flex flex-col justify-center items-center border-2 border-dashed border-gray-500 bg-[#0b0b0b] md:bg-[#101010ff] hover:border-[#6e11b0] hover:bg-[#0b0b0b] transition-all duration-200">
                                <div className="w-[55px] aspect-square rounded-full bg-black flex items-center justify-center mb-[15px]">
                                    <CloudUpload className="text-[0.75rem] text-[#6e11b0]" />
                                </div>
                                <p className="text-gray-500 my-0 my-5 text-[.9em]">
                                    Supported formats: PDF, DOC, DOCX (Max 5MB)
                                </p>
                                <div></div>
                                <div className="w-auto px-6 py-4 border-none rounded-lg bg-[#6e11b0] text-white font-semibold text-sm cursor-pointer transition-all duration-200 mt-[10px] shadow-[0_0_20px_rgba(110,17,176,0.2)]">
                                    Upload from Computer
                                </div>
                            </div>
                        </div>
                    }

                    { currentStep == 2 && 
                        <Skills interests={devSkills} selectedInterests={selectedInterests} setSelectedInterests={setSelectedInterests}/>
                    }

                    { currentStep == 3 && 
                        <Roles roles={devRoles} selectedRoles={selectedRoles} setSelectedRoles={setSelectedRoles}/>
                    }

                    { currentStep == 4 && 
                        <div className="h-[60vh] flex flex-col justify-center items-center text-center">
                            
                            <div className="mb-0 font-semibold text-white text-[2rem] mb-4">
                                You're All Set! 🎉
                            </div>
                            
                            <p className="text-gray-400 text-lg max-w-[500px] mb-8">
                                Your personalized career roadmap is ready. We've analyzed your skills, mapped them to your target roles, and created a custom learning path just for you.
                            </p>
                            
                            <div className="flex flex-col gap-4 mb-8">
                                <div className="flex items-center gap-3 text-gray-300">
                                    <div className="w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center">
                                        <svg className="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                                        </svg>
                                    </div>
                                    <span>Skills analyzed and mapped</span>
                                </div>
                                <div className="flex items-center gap-3 text-gray-300">
                                    <div className="w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center">
                                        <svg className="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                                        </svg>
                                    </div>
                                    <span>Career goals identified</span>
                                </div>
                                <div className="flex items-center gap-3 text-gray-300">
                                    <div className="w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center">
                                        <svg className="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                                        </svg>
                                    </div>
                                    <span>Personalized roadmap generated</span>
                                </div>
                            </div>
                            
                            <p className="text-gray-500 text-sm mt-6">
                                Ready to start your career transformation?
                            </p>
                        </div>
                    }

                    <div className="flex flex-row gap-[25px] items-center">
                        { currentStep > 1 &&
                            <div 
                                onClick={lambda e: any -> None{setCurrentStep(currentStep - 1);}}
                                className="flex flex-row items-center cursor-pointer"> 
                                <ChevronLeft/>
                                Back
                            </div>
                        }

                        <button
                            type="button"
                            onClick={lambda e: any -> None{
                                if(currentStep < 4){
                                setCurrentStep(currentStep + 1);
                                }else{
                                    navigate("/dashboard");
                                }

                                }}
                            className="w-[180px] bg-[#6e11b0] text-white border-none px-10 py-4 rounded-[5px] cursor-pointer text-base transition-transform duration-200 hover:translate-y-1"
                        >
                            { "Get Started" if currentStep == 4 else "Next" }
                        </button>
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
