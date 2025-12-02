cl import from react { useState,useEffect }
cl import from 'lucide-react' { Brain, CloudUpload, Goal, Route as Node, ChevronLeft }
cl {
    import from "@jac-client/utils" {
    useNavigate,
}
}
cl{    
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


        return<div className="w-full bg-black h-screen grid grid-cols-[100%} md:grid-cols-[45%_55%] relative text-white">
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
}