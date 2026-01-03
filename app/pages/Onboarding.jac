cl import from react { useState,useEffect }
cl import from 'lucide-react' { Brain, CloudUpload, Goal, Route as Node, ChevronLeft }
cl import from ..fileutils {fileToBase64}
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
        let [suggestedRoles, setSuggestedRoles] = useState([]);

        let [dragActive, setDragActive] = useState(false);
        let [fileName, setFileName] = useState("");
        let [file, setFile] = useState(null);
        let [error, setError] = useState("");
        let [canProceed, setCanProceed] = useState(false);

        let [isLoading, setIsLoading] = useState(false);

        

        let [showErrorPopup, setShowErrorPopup] = useState(False);
        let [errorMessage, setErrorMessage] = useState("");

        def showError(msg: str) -> None {
            setErrorMessage(msg);
            setShowErrorPopup(True);
        }

        useEffect(lambda -> None {
            if (showErrorPopup) {
                let timer = setTimeout(lambda -> None {
                    setShowErrorPopup(False);
                }, 3000);
                return lambda -> None { clearTimeout(timer); };
            }
        }, [showErrorPopup]);
        let navigate = useNavigate();
        let devSkills = ["JavaScript", "Python", "React", "Node.js", "TypeScript", "HTML & CSS", "Django", "Flutter", "Git & GitHub", "SQL & Databases", "REST APIs", "GraphQL", "Docker", "Agile & Scrum"];
        let devRoles = ["Frontend Developer", "Backend Developer", "Fullstack Developer", "Mobile Developer", "DevOps Engineer", "UI/UX Designer", "Data Scientist", "Machine Learning Engineer"];
        let loadingMessages = [
            "Analyzing your CV…",
            "Extracting skills and experience…",
            "Identifying career patterns…",
            "Mapping skills to target roles…",
            "Detecting skill gaps…",
            "This could take a few minutes…",
        ];
        let [loadingText, setLoadingText] = useState(loadingMessages[0] or "");
        let [messageIndex, setMessageIndex] = useState(0);
        let [typedText, setTypedText] = useState("");


        useEffect(lambda -> None {
        if (isLoading == false) {
            setMessageIndex(0);
            setLoadingText(loadingMessages[0]);
            return;
        }

        let interval = setInterval(lambda -> None {
            setMessageIndex(lambda prev:any -> any {
            let next = (prev + 1) % loadingMessages.length;
            setLoadingText(loadingMessages[next]);
            return next;
            });
        }, 1800);

        return lambda -> None { clearInterval(interval); };
        }, [isLoading]);

        useEffect(lambda -> None {
            if (isLoading == false) {
                setTypedText("");
                return;
            }

            if (not loadingText or loadingText.length == 0) {
                return;
            }

            setTypedText("");

            let i = 0;
            let current = loadingText;

            let typing = setInterval(lambda -> None {
                # Extra safety
                if (i >= current.length) {
                    clearInterval(typing);
                    return;
                }

                setTypedText(lambda prev:any -> any { return prev + current[i]; });
                i += 1;
            }, 40);

            return lambda -> None { clearInterval(typing); };
        }, [loadingText, isLoading]);

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
            if not canProceed  or not file {
                return;
            }

            try {
                root spawn create_resume_node();

                let base64Data = await fileToBase64(file);

                let result = await root spawn upload_resume(
                    file=base64Data,
                    name=file.name,
                    mime=file.type
                );

                if not result {
                    console.log("Failed");
                    return;
                }

                root spawn save_resume();
                root spawn update_resume_upload_status();

                let user_skills = await root spawn analyze_cv();

                if not user_skills or not user_skills.reports or user_skills.reports.length == 0 {
                    console.log("Failed");
                    return;
                }

                if user_skills.reports[0]["status"] != "Success" {
                    showError("Failed to process your CV. Please try again or use a different file.");                   
                    return;
                }

                # parse the analyzer output to prefill step2 states if present
                try {
                    let body = user_skills.reports[0]["body"] if "body" in user_skills.reports[0] else {};
                    let detected_skills = body["skills"] if "skills" in body else [];
                    let detected_interests = body["interests"] if "interests" in body else [];
                    let detected_certs = body["certifications"] if "certifications" in body else [];

                    setSelectedInterests(detected_skills);
                    # setCerts(detected_certs);
                    
                } except Exception as e {
                    console.log(e);
                }

                
                setCurrentStep(2);

            } except Exception as err {
                console.log(err);
                
            } finally {
                setIsLoading(False);
            }
        }

        async def handleStep2Next() -> None {
            try {
                let result = await root spawn update_user_profile(
                    updated_skills=selectedInterests,
                );

                if result {

                    let rolesReport = await root spawn generate_role_suggestions();
                    let latestReport = rolesReport.reports[rolesReport.reports.length - 1];

                    if latestReport.status == "Success" {
                        # Store the array of suggestions in state
                        setSuggestedRoles(latestReport.body);
                        setCurrentStep(3);

                    } else {
                        showError("Failed to generate role suggestions: " + (latestReport.message or "Unknown error"));
                    }

                } else {
                    showError("Failed to save profile. Please try again.");
                }

            } except Exception as err {
                showError("An unexpected error occurred: " + err);
            } finally {
                setIsLoading(False);
            }
        }

        # Function to handle step 3 role submission
        async def handleStep3Next() -> None {
            try {
                if (selectedRoles == None or selectedRoles.length == 0) {
                    showError("Please select at least one role to continue.");
                    return;
                }
                
                let finalRoles = [];
                for roleTitle in selectedRoles {
                    finalRoles = finalRoles.concat({
                        "title": roleTitle,
                        "description": ""
                    });
                }

                let allSuccessful = True;
                let roleIndex = 0;
                
                for currentRole in finalRoles {
                    roleIndex += 1;
                    console.log(f"Processing Role {roleIndex}/{finalRoles.length}:", currentRole);
                            
                    let result = await root spawn collect_role_requirements(
                        role_title=currentRole.title,
                    );
                    
                    if result.reports[0]["status"] == "Success" {
                        let requirements_gap = await root spawn find_skill_and_certification_gaps(
                            role_title=currentRole.title
                        );
                        let requirements_gap_status = requirements_gap.reports[requirements_gap.reports.length - 1]["status"];
                        
                        if requirements_gap_status == "Success" {
                            let learning_path = await root spawn recommend_learning_paths(
                                role_title=currentRole.title
                             );
                            
                            let lp_report = learning_path.reports[learning_path.reports.length - 1];
                            if lp_report["status"] == "Success" {
                                console.log(f"Learning Path for {currentRole.title} Success");
                            } else {
                                allSuccessful = False;
                                showError(f"Failed to generate roadmap for {currentRole.title}. Please try again.");
                                break;
                            }
                        } else {
                            allSuccessful = False;
                            showError(f"Failed to analyze skill gaps for {currentRole.title}.");
                            break;
                        }
                    } else {
                        allSuccessful = False;
                        showError(f"Failed to fetch requirements for {currentRole.title}.");
                        break;
                    }
                }
                
                if allSuccessful {
                    setCurrentStep(4);
                }
            } except Exception as err {
                console.log(err);
                showError("An unexpected error occurred. Please try again.");
            } finally {
                setIsLoading(False);
            }
        }



        # components
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
                            <div className="flex flex-wrap gap-2 max-h-[250px] overflow-y-auto scrollbar-thin scrollbar-thumb-gray-600 scrollbar-track-transparent hover:scrollbar-thumb-gray-500">
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

                # <div>
                #     <div className="text-gray-400 text-sm mb-2">Available Skills</div>
                #     <div className="flex flex-wrap gap-2 overflow-y-auto  md:max-h-[25vh]">
                #         {props.interests.map(
                #             lambda interest:any -> any { 
                #                 let isSelected = props.selectedInterests.includes(interest);
                #                 if (isSelected == false) {
                #                     return <div 
                #                         key={interest}
                #                         onClick={lambda e:any -> None {
                #                             let newSelected = props.selectedInterests.concat([interest]);
                #                             props.setSelectedInterests(newSelected);
                #                         }}
                #                         className="border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-[#6e11b0] hover:bg-[#0b0b0b]">
                #                         {interest}
                #                     </div>;
                #                 }
                #                 return null;
                #             }
                #         )}
                #     </div>
                # </div>
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

                    <div className="flex flex-wrap gap-2 overflow-y-auto md:max-h-[25vh]">
                        {props.suggestedRoles.map(
                            lambda role:any, index:any -> any {
                                let isSelected = props.selectedRoles.includes(role.title);

                                if (isSelected == false) {
                                    return <div
                                        key={index}
                                        onClick={lambda e:any -> None {
                                            let newSelected = props.selectedRoles.concat([role.title]);
                                            props.setSelectedRoles(newSelected);
                                        }}
                                        className="border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-[#6e11b0] hover:bg-[#0b0b0b]"
                                    >
                                        {role.title}
                                    </div>;
                                }

                                return null;
                            }
                        )}
                    </div>
                </div>

            </div>;
        }

        def ErrorPopup() -> any {
            if not showErrorPopup {
                return null;
            }
            return <div className="fixed top-10 left-1/2 transform -translate-x-1/2 bg-red-500 text-white px-6 py-4 rounded-lg shadow-xl z-[10000] flex items-center gap-3 animate-in fade-in slide-in-from-top-4 duration-300">
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span className="font-medium">{errorMessage}</span>
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

        return<div className="w-full bg-black h-screen grid grid-cols-[100%} md:grid-cols-[45%_55%] relative text-white">
            <ErrorPopup />
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
                            <div 
                                onDragOver={handleDragOver}
                                onDragLeave={handleDragLeave}
                                onDrop={handleDrop}
                                className="my-[30px] h-[40vh] w-full md:w-[80%] rounded-[15px] flex flex-col justify-center items-center border-2 border-dashed border-gray-500 bg-[#0b0b0b] md:bg-[#101010ff] hover:border-[#6e11b0] hover:bg-[#0b0b0b] transition-all duration-200">
                                <div className="w-[55px] aspect-square rounded-full bg-black flex items-center justify-center mb-[15px]">
                                    <CloudUpload className="text-[0.75rem] text-[#6e11b0]" />
                                </div>
                                <p className="text-gray-500 my-0 my-5 text-[.9em]">
                                    Supported formats: PDF, DOC, DOCX (Max 5MB)
                                </p>
                                <div></div>
                                <input
                                    type="file"
                                    accept=".pdf,.doc,.docx"
                                    onChange={handleFileSelect}
                                    className="hidden"
                                    id="resumeInput"
                                />
                                <label 
                                for="resumeInput"
                                className="w-auto px-6 py-4 border-none rounded-lg bg-[#6e11b0] text-white font-semibold text-sm cursor-pointer transition-all duration-200 mt-[10px] shadow-[0_0_20px_rgba(110,17,176,0.2)]">
                                    Upload from Computer
                                </label>
                                {fileName && <p className="mt-5 text-sm text-white font-medium">Uploaded: {fileName}</p>}
                            </div>
                        </div>
                    }

                    { currentStep == 2 && 
                        <Skills interests={devSkills} selectedInterests={selectedInterests} setSelectedInterests={setSelectedInterests}/>
                    }

                    { currentStep == 3 && 
                        <Roles suggestedRoles={suggestedRoles} selectedRoles={selectedRoles} setSelectedRoles={setSelectedRoles}/>
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
                            onClick={lambda e: any -> None {
                                if (currentStep < 4) {
                                    setIsLoading(True);
                                    
                                    if (currentStep == 1) {
                                        handleStep1Next();
                                    } elif (currentStep == 2) {
                                        handleStep2Next();
                                    } elif (currentStep == 3) {
                                        handleStep3Next();
                                    }
                                    
                                } else {
                                    navigate("/dashboard");
                                }
                            }}
                            disabled={isLoading}
                            className="w-[180px] bg-[#6e11b0] text-white border-none px-10 py-4 rounded-[5px] cursor-pointer text-base transition-transform duration-200 hover:translate-y-1 disabled:opacity-50 disabled:cursor-not-allowed"
                        >   
                            { LoadingDots() if isLoading else ( "Get Started" if currentStep == 4 else "Next")}
                        </button>

                        <p className="text-sm text-gray-400 animate-pulse transition-opacity duration-500">
                            {loadingText if isLoading and currentStep == 3 else "" }
                        </p> 


                    </div>
                </div>
            </div>
        </div>;
    }
}