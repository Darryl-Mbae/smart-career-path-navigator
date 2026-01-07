cl import from react { useState ,useEffect, useRef}
cl import from 'docx-preview' { renderAsync }
cl import from 'react-markdown' { default as ReactMarkdown }
cl import from 'lucide-react' { Mail,Bubbles, LogOut,  Puzzle, Briefcase, Map, Send, Loader2 }
cl import from "@jac-client/assets/images/jaseci.webp" { default as jaseciImg }
cl import from '@jac-client/utils' {
    useNavigate,
    jacIsLoggedIn,
    jacLogout
}

cl import from ..fileutils { base64ToFileBytes }

cl {
    def Dashboard() -> any { 
        let [sidebarOpen, setSidebarOpen] = useState(false);
        let [profileOpen, setProfileOpen] = useState(false);
        let [activeLink, setActiveLink] = useState("dashboard"); 
        let [selectedSkills, setSelectedSkills] = useState([]);
        let [selectedRoles, setSelectedRoles] = useState([]);
        let [userDetails, setUserDetails] = useState([]);
        let [skills,setSkills] = useState([]);
        let [userRoles,setUserRoles] = useState([]);
        let [isLoading, setIsLoading] = useState(false);
        let [userSkillgap, setUserSkillGap] = useState([]);
        let [roadmapData, setRoadmapData] = useState([]);
        let [roadmapMarkdown, setRoadmapMarkdown] = useState("");
        let [selectedCertifications, setSelectedCertifications] = useState([]);
        let [cvPreviewOpen, setCvPreviewOpen] = useState(false);
        let [cvFileBase64, setCvFileBase64] = useState("");
        let [cvFileName, setCvFileName] = useState("");
        let [cvMimeType, setCvMimeType] = useState("");
        let [cvPreviewUrl, setCvPreviewUrl] = useState("");


        let [notifications, setNotifications] = useState([]);
        let [selectedNotification, setSelectedNotification] = useState(None);
        let [notifError, setNotifError] = useState("");
        let [isLoadingNotifications, setIsLoadingNotifications] = useState(True);

        let notifPollRef = useRef(None);
        let fetchingRef = useRef(false);
        let docxContainerRef = useRef(None);

        let pollSeconds = 120;  

        def safeStr(x:any) -> any {
            if x == None { return ""; }
            return "" + x;
        }

        def safeArr(x:any) -> any {
            if x == None { return []; }
            return x;
        }

        def safeTypeFromBackend(t:any) -> any {
            let tt = safeStr(t).toLowerCase();
            if tt == "message" { return "message"; }
            if tt == "event" { return "event"; }
            if tt == "warning" { return "warning"; }
            return "success";
        }

        def pickReport(data:any) -> any {
            if data == None { return None; }
            if ("reports" in data) == false { return None; }

            let reps = data["reports"];
            if reps == None or reps.length == 0 { return None; }

            let i = 0;
            while i < reps.length {
                let r = reps[i];
                if r != None and ("status" in r) and safeStr(r["status"]).toLowerCase() == "success" {
                    return r;
                }
                i = i + 1;
            }

            return reps[0];
        }

        async def safeParseJSON(res:any) -> any {
            try {
                return await res.json();
            } except Exception as e {
                try {
                    let t = await res.text();
                    return JSON.parse(t);
                } except Exception as e2 {
                    return None;
                }
            }
        }

        def mergeReadFlags(prev:any, incoming:any) -> any {
            let out = [];
            let i = 0;

            while i < incoming.length {
                let n = incoming[i];
                if n == None { i = i + 1; continue; }

                let nid = safeStr(n.id);
                let wasRead = false;

                let j = 0;
                while j < prev.length {
                    let p = prev[j];
                    if p != None and safeStr(p.id) == nid {
                        wasRead = (p.read == True);
                        break;
                    }
                    j = j + 1;
                }

                if wasRead == True { n.read = True; }
                out.push(n);
                i = i + 1;
            }

            return out;
        }

        async def fetchLiveNotifications(showSpinner:any=false) -> None {
            if fetchingRef.current == True { return; }
            fetchingRef.current = True;

            if showSpinner == True {
                setIsLoadingNotifications(True);
            }

            setNotifError("");

            try {
                let result = await root spawn live_job_market_trends_notifications(
                    location="worldwide",
                    focus="all",
                    max_jobs_per_source=25,
                    max_notifications=5
                );

                if result == None or result.reports == None or result.reports.length == 0 {
                    setNotifError("No report returned from server.");
                    setIsLoadingNotifications(false);
                    fetchingRef.current = false;
                    return;
                }

                let rep = result.reports[0]; 
                
                # Check for other successful reports if the first one isn't the one we want (similar to pickReport logic)
                # But typically spawn returns the reports for that walker. 
                # Re-implementing a simple check:
                let i = 0;
                while i < result.reports.length {
                   if result.reports[i].status == "Success" {
                       rep = result.reports[i];
                       break;
                   }
                   i = i + 1;
                }

                if rep.status != "Success" {
                    let msg = safeStr(rep.message);
                    if msg == "" { msg = "Server returned Fail."; }
                    setNotifError(msg);
                }

                let body = rep.body if ("body" in rep) else rep;
                let nots = body.notifications if ("notifications" in body) else [];
                nots = safeArr(nots);

                let mapped = nots.map(
                    lambda n:any -> any {
                        let nid = safeStr(n.id);
                        let t = safeTypeFromBackend(n.type);

                        let title = safeStr(n.title);
                        let desc = safeStr(n.description);

                        let timeText =
                            safeStr(n.local_time)
                            if ("local_time" in n) and safeStr(n.local_time) != ""
                            else safeStr(n.time);

                        let urlVal = safeStr(n.url);

                        return {
                            id: nid,
                            type: t,
                            title: title,
                            description: desc,
                            time: timeText,
                            url: urlVal,
                            read: false
                        };
                    }
                );

                setNotifications(lambda prev:any -> any {
                    return mergeReadFlags(prev, mapped);
                });

            } except Exception as err {
                console.log(err);
                setNotifError("Live notification error.");
            }

            setIsLoadingNotifications(false);
            fetchingRef.current = false;
        }

        let unreadCount = notifications.filter(lambda n:any -> bool { return n.read == false; }).length;


        let unreadCount = notifications.filter(lambda n:any -> bool { return n.read == false; }).length;
        let navigate = useNavigate();

        let baseLinkClasses = "flex items-center gap-3 px-4 py-3 rounded-lg transition-all cursor-pointer ";
        let dashboardClasses = "bg-primary text-white" if activeLink == "dashboard" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let notificationsClasses = "bg-primary text-white" if activeLink == "notifications" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let skillsClasses = "bg-primary text-white" if activeLink == "skills" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let rolesClasses = "bg-primary text-white" if activeLink == "roles" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let roadmapClasses = "bg-primary text-white" if activeLink == "roadmap" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let ariseaiClasses = "bg-primary text-white" if activeLink == "ariseai" else "text-gray-300 hover:bg-[#101010ff] hover:text-white";
        let certificationsClasses = "bg-primary text-white"
        if activeLink == "certifications"
        else "text-gray-300 hover:bg-[#101010ff] hover:text-white";

        let devRoles = ["Frontend Developer", "Backend Developer", "Fullstack Developer", "Mobile Developer", "DevOps Engineer", "UI/UX Designer", "Data Scientist", "Machine Learning Engineer"];


        async def getUserDetails() -> None {
            try {
                let result = await root spawn get_user_details();
                let profile = await root spawn get_user_profile();

                let data = profile.reports[0].body.skills;
                let certData = profile.reports[0].body.certifications;

                let certObjects = certData.map(
                    lambda cert:any -> any {
                        let certName = "";

                        if cert.name {
                            certName = cert.name;
                        } else {
                            certName = cert.title;
                        }

                        return {
                            name: certName,
                            url: cert.url
                        };
                    }
                );

                setSelectedCertifications(certObjects);

                let skillObjects = data.map(
                    lambda skill:any -> any {
                        return {
                            name: skill.name,
                            description: skill.description
                        };
                    }
                );

                setSelectedSkills(skillObjects);
                setUserDetails(result.reports[0].body);

            } except Exception as err {
                console.log(err);
                # navigate("/onboarding");
            }
        }

        async def getSkillGap() -> None {
            try {
                let data = await root spawn get_user_target_roles();
                let roles = data.reports[0].body.roles;

                setUserRoles(roles);

                let roleObjects = roles.map(
                    lambda role:any -> any {
                        let roleName = "";

                        if role.title {
                            roleName = role.title;
                        } else {
                            roleName = role.name;
                        }

                        return {
                            name: roleName
                        };
                    }
                );

                setSelectedRoles(roleObjects);

                
                let allRoadmaps = [];
                for role in roles {
                    let roleTitle = "";

                    if role.title {
                        roleTitle = role.title;
                    } else {
                        roleTitle = role.name;
                    }

                    let result = await root spawn retrieve_skill_gaps(
                        role_title=roleTitle
                    );

                    setUserSkillGap(userSkillgap.concat(result.result.gaps));

                    let roadmap = await root spawn get_road_map(
                        role_title = roleTitle
                    );

                    if roadmap.reports.length > 0 {
                        let rep = roadmap.reports[0];
                        if rep.status == "Success" {
                             allRoadmaps.push(rep);
                        } else {
                            # Fallback if roadmap not found
                            allRoadmaps.push({
                                "id": "temp_" + roleTitle,
                                "body": {
                                    "role_title": roleTitle,
                                    "learning_path": "GENERATING_ROADMAP" 
                                }
                            });
                            # Trigger background generation
                            generateRoadmap(roleTitle);
                        }
                    }
                   
                }
                setRoadmapData(allRoadmaps);

            } except Exception as err {
                console.log(err);
            }
        }

        async def generateRoadmap(roleTitle: str) -> None {
            try {
               await root spawn recommend_learning_paths(
                   role_title=roleTitle
               );
               # Refresh data after generation
               getSkillGap();
            } except Exception as err {
                console.log(err);
            }
        }

        useEffect(lambda -> any {
                getUserDetails();
                getSkillGap();
                fetchResume(false); 
        },[]);

        useEffect(lambda -> any {
               
                # def ProtectedPage() -> any {
                            #     if not jacIsLoggedIn() {
                            #         navigate("/auth");
                                    
                            #     }
                            # }
                setTimeout(lambda -> None {
                    fetchLiveNotifications(True);
                }, 2000);

                notifPollRef.current = setInterval(lambda -> None {
                    fetchLiveNotifications(false);
                }, 1200000);

                return lambda -> None {
                    if notifPollRef.current != None {
                        clearInterval(notifPollRef.current);
                        notifPollRef.current = None;
                    }
                };
        }, []);

        

        def handleLogout() -> None {
            jacLogout();
            navigate("/");
        }

        def normalizeNotif(raw:any) -> any {
            let n_id = raw.id if raw and raw.id else ("n_" + ("" + window.performance.now()));
            let n_type = raw.type if raw and raw.type else "event";
            let n_title = raw.title if raw and raw.title else "Notification";
            let n_desc = raw.description if raw and raw.description else "";
            let n_time = raw.local_time if raw and raw.local_time else (raw.time if raw and raw.time else "");
            let n_url = raw.url if raw and raw.url else "";

            let n_read = false;
            if raw and raw.read == True {
                n_read = True;
            }

            return {
                id: n_id,
                type: n_type,
                title: n_title,
                description: n_desc,
                time: n_time,
                url: n_url,
                read: n_read
            };
        }

        def mergeNotifs(prev:any, incoming:any) -> any {
            let merged = prev;

            for inc in incoming {
                let idx = merged.findIndex(lambda p:any -> bool { return p.id == inc.id; });

                if idx == -1 {
                    merged = [inc].concat(merged);
                } else {
                    let old = merged[idx];
                    merged[idx] = {
                        id: inc.id,
                        type: inc.type,
                        title: inc.title,
                        description: inc.description,
                        time: inc.time,
                        url: inc.url,
                        read: old.read
                    };
                }
            }
            return merged.slice(0, 80);
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

        def handleSaveSkills() -> None {
            saveSkills();
        }

        async def saveSkills() -> None {
            setIsLoading(True);
            try{
                let result = await root spawn update_user_profile(
                    updated_skills=selectedSkills,
                    updated_certifications=selectedCertifications

                );

                if result {
                    setIsLoading(false);
                }
            }
            except Exception as err {
                console.log(err);
            }
        }

        async def saveCertifications() -> None {
            setIsLoading(True);
            try {
                let result = await root spawn update_user_profile(
                    updated_certifications=selectedCertifications,
                    updated_skills=selectedSkills
                );

                if result {
                    setIsLoading(false);
                }
            }
            except Exception as err {
                console.log(err);
            }
        }

        def handleSaveCertifications() -> None {
            saveCertifications();
        }

        async def openResumePreview() -> None {
            await fetchResume(True);
        }

        async def fetchResume(openPreview: bool = false) -> None {
            try {
                let resume = await root spawn retrieve_resume();

                if resume.reports.length > 0 {
                    let reported = resume.reports[0];

                    if reported.status == "Success" {
                        let body = reported.body;

                        setCvFileBase64(body.file_base64);
                        setCvFileName(body.name);
                        setCvMimeType(body.mime);

                        if openPreview {
                            setCvPreviewOpen(True);
                        }
                    }
                }
            } except Exception as err {
                console.log(err);
            }
        }

        useEffect(
            lambda -> None {
                if cvFileBase64 != "" {
                    let dataUrl = "data:" + cvMimeType + ";base64," + cvFileBase64;

                    fetch(dataUrl).then(
                        lambda response:any -> any {
                            return response.blob();
                        }
                    ).then(
                        lambda blob:any -> None {
                            let url = URL.createObjectURL(blob);
                            setCvPreviewUrl(url);
                        }
                    );
                }
            },
            [cvFileBase64]
        );

        useEffect(
            lambda -> None {
                if cvPreviewOpen and cvPreviewUrl != "" and cvMimeType.includes("wordprocessingml") {
                    fetch(cvPreviewUrl).then(
                        lambda response:any -> any { return response.blob(); }
                    ).then(
                        lambda blob:any -> None {
                            if docxContainerRef.current {
                                renderAsync(blob, docxContainerRef.current, None, {
                                    "inWrapper": false, 
                                    "ignoreWidth": false, 
                                    "ignoreHeight": false 
                                });
                            }
                        }
                    );
                }
            },
            [cvPreviewOpen, cvPreviewUrl, cvMimeType]
        );

        def CvPreviewModal() -> any {
            if cvPreviewOpen == false {
                return "";
            }

            return (
                <div className="fixed inset-0 bg-black/70 flex items-center justify-center z-50">
                    <div className="bg-[#0b0b0b] w-[80%] h-[80%] rounded-xl shadow-lg flex flex-col">
                        
                        <div className="flex items-center justify-between p-4 border-b border-gray-800">
                            <div className="text-white font-medium">
                                {cvFileName}
                            </div>

                            <button
                                onClick={lambda -> None {
                                    setCvPreviewOpen(false);
                                }}
                                className="text-gray-400 hover:text-white cursor-pointer"
                            >
                                ✕
                            </button>
                        </div>

                        <div className="flex-1 overflow-auto bg-white p-4" style={{"display": "flex", "flexDirection": "column"}}>
                         {   
                                <div ref={docxContainerRef} style={{"width": "100%", "minHeight": "500px"}}></div>
                                if (cvMimeType.includes("wordprocessingml"))
                                else
                                <iframe
                                    src={cvPreviewUrl}
                                    className="w-full h-full border-none"
                                ></iframe>
                         }
                        </div>
                    </div>
                </div>
            );
        }

        def DashSideBar() -> any {
            return <div className="hidden md:flex md:w-64 bg-[#0b0b0b] h-screen flex-col border-r border-gray-800 fixed left-0 top-0">
                <div className="p-6">
                    <div className="text-xl font-semibold text-white">Arise</div>
                </div>

                <nav className="flex-1 p-4 overflow-y-auto">
                    <div className="mb-6">
                        <div className="text-gray-500 text-xs uppercase font-semibold my-2 px-4 mb-4">Main</div>
                        <ul className="list-none p-0 m-0 ml-[8px]">
                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("dashboard"); }}
                                    className={baseLinkClasses + dashboardClasses}>
                                    <span>Dashboard</span>
                                </div>
                            </li>
                             
                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("roadmap"); }}
                                    className={baseLinkClasses + roadmapClasses}>
                                    <span>My Roadmap</span>
                                </div>
                            </li>
                            
                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("ariseai"); }}
                                    className={baseLinkClasses + ariseaiClasses}>
                                    <span>Arise AI</span>
                                </div>
                            </li> 
                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("notifications"); }}
                                    className={baseLinkClasses + notificationsClasses}>
                                    <span className="flex items-center justify-between w-full">
                                        <span>Notifications</span>
                                        {
                                            <span className="ml-auto">
                                                <Loader2 className="w-4 h-4 animate-spin text-gray-500" />
                                            </span>
                                            if isLoadingNotifications
                                            else
                                            (
                                                <span className="ml-auto bg-primary text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center">
                                                    {unreadCount}
                                                </span>
                                                if unreadCount > 0
                                                else
                                                ""
                                            )
                                        }
                                    </span>
                                </div>
                            </li>

                        </ul>
                    </div>

                    <div>
                        <div className="text-gray-500 text-xs uppercase font-semibold m-y2 px-4 mb-4">Actions</div>
                        <ul className="list-none p-0 m-0 ml-[8px]">
             
                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("skills"); }}
                                    className={baseLinkClasses + skillsClasses}>
                                    <span>Skills</span>
                                </div>
                            </li>
                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("roles"); }}
                                    className={baseLinkClasses + rolesClasses}>
                                    <span>Roles</span>
                                </div>
                            </li>
                                <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("certifications"); }}
                                    className={baseLinkClasses + certificationsClasses}>
                                    <span>Certifications</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>

                <div className="p-4 ">
                    <div className="flex items-center gap-3 px-4 py-3 text-red-400" onClick={handleLogout}>
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
                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("dashboard"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + dashboardClasses}>
                                    <span>Dashboard</span>
                                </div>
                            </li>

                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("roadmap"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + roadmapClasses}>
                                    <span>My Roadmap</span>
                                </div>
                            </li>
                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("ariseai"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + ariseaiClasses}>
                                    <span>Arise AI</span>
                                </div>
                            </li>
                            <li className="mb-[6px]">
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
                            
                        </ul>
                    </div>
                    <div>
                        <div className="text-gray-500 text-xs uppercase font-semibold mb-2 px-4">Actions</div>
                        <ul className="list-none p-0 m-0  ml-[8px]">
                            
                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("skills"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + skillsClasses}>
                                    <span>Skills</span>
                                </div>
                            </li>
                            <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("roles"); setSidebarOpen(false); }}
                                    className={baseLinkClasses + rolesClasses}>
                                    <span>Roles</span>
                                </div>
                            </li>
                             <li className="mb-[6px]">
                                <div 
                                    onClick={lambda e:any -> None { setActiveLink("certifications"); }}
                                    className={baseLinkClasses + certificationsClasses}>
                                    <span>Certifications</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>

                <div className="p-4 ">
                    <div className="flex items-center gap-3 px-4 py-3 text-red-400" onClick={handleLogout}>
                        <LogOut />
                        <div className="text-sm text-red-400 font-medium">Logout</div>
                    </div>
                </div>
            </div>;
        }

        def ProfilePanel() -> any {
            return (
                <div className="hidden lg:flex lg:flex-col lg:w-72 bg-[#0b0b0b] h-screen border-l border-gray-800">
            
                    <div className="p-6">
                        <div className="flex flex-col items-center mb-6">
                            <div className="w-20 h-20 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-2xl mb-4">
                                { userDetails.full_name[0] if userDetails.full_name else "U" }
                            </div>
                            <div className="text-white font-medium">
                                { userDetails.full_name if userDetails.full_name else "Guest" }
                            </div>
                            <div className="text-gray-400 text-sm">
                                { userDetails.email if userDetails.email else "" }
                            </div>
                        </div>
                    </div>

                    <div className="flex-1 overflow-y-auto px-6 pb-6 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">                        {
                            <div>
                                {
                                    <>
                                        <h3 className="mt-4 text-base font-normal text-gray-300 mb-6">
                                            Skills Gap Analysis
                                        </h3>

                                        {userSkillgap[0].skills.slice(0, 3).map(
                                            lambda skillgap:any -> any {
                                                return (
                                                    <InsightContent
                                                        key={skillgap.id}
                                                        skill={skillgap.name}
                                                    />
                                                );
                                            }
                                        )}
                                    </>
                                    if userSkillgap[0].skills else ""
                                }

                                {
                                    <>
                                        <h3 className="mt-6 text-base font-normal text-gray-300 mb-6">
                                            Certification recommendations
                                        </h3>

                                        {userSkillgap[0].certifications.slice(0, 2).map(
                                            lambda cert:any -> any {
                                                return (
                                                    <a
                                                        key={cert._jac_id}
                                                        href={cert.url}
                                                        target="_blank"
                                                        rel="noopener noreferrer"
                                                        className="block"
                                                    >
                                                        <InsightContent skill={cert.title} />
                                                    </a>
                                                );
                                            }
                                        )}
                                    </>
                                    if userSkillgap[0].certifications else ""
                                }
                            </div>
                            if userSkillgap.length > 0 else ""
                        }

                        <div className="mt-6">
                            <h3 className="text-base font-normal text-gray-300 mb-4">
                                My CV
                            </h3>

                            <div className="w-full flex flex-col gap-4">
                                <div
                                    onClick={lambda -> None {
                                        openResumePreview();
                                    }}
                                    className="flex items-start gap-3 p-3 bg-[black] rounded-lg hover:bg-[#1a1a1a] transition-colors cursor-pointer"
                                >
                                    <div className="w-12 h-12 bg-red-500/10 rounded-lg flex items-center justify-center flex-shrink-0">
                                        <svg
                                            className="w-6 h-6 text-red-500"
                                            fill="none"
                                            stroke="currentColor"
                                            viewBox="0 0 24 24"
                                        >
                                            <path
                                                strokeLinecap="round"
                                                strokeLinejoin="round"
                                                strokeWidth={2}
                                                d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"
                                            />
                                        </svg>
                                    </div>

                                    <div className="flex-1 min-w-0">
                                        <div className="text-white font-medium text-sm mb-1 truncate">
                                            {cvFileName if cvFileName else "No CV uploaded"}
                                        </div>

                                        <div className="text-gray-500 text-xs">
                                            Last updated: Dec 10, 2025
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            );
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

                <div className="p-6">
                        <div className="flex flex-col items-center mb-6">
                            <div className="w-20 h-20 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-2xl mb-4">
                                { userDetails.full_name[0] if userDetails.full_name else "U" }
                            </div>
                            <div className="text-white font-medium">
                                { userDetails.full_name if userDetails.full_name else "Guest" }
                            </div>
                            <div className="text-gray-400 text-sm">
                                { userDetails.email if userDetails.email else "" }
                            </div>
                        </div>
                </div>

                    <div className="flex-1 overflow-y-auto px-2 pb-6 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">                        {
                            <div>
                                {
                                    <>
                                        <h3 className="mt-4 text-base font-normal text-gray-300 mb-6">
                                            Skills Gap Analysis
                                        </h3>

                                        {userSkillgap[0].skills.slice(0, 3).map(
                                            lambda skillgap:any -> any {
                                                return (
                                                    <InsightContent
                                                        key={skillgap.id}
                                                        skill={skillgap.name}
                                                    />
                                                );
                                            }
                                        )}
                                    </>
                                    if userSkillgap[0].skills else ""
                                }

                                {
                                    <>
                                        <h3 className="mt-6 text-base font-normal text-gray-300 mb-6">
                                            Certification recommendations
                                        </h3>

                                        {userSkillgap[0].certifications.slice(0, 2).map(
                                            lambda cert:any -> any {
                                                return (
                                                    <a
                                                        key={cert._jac_id}
                                                        href={cert.url}
                                                        target="_blank"
                                                        rel="noopener noreferrer"
                                                        className="block"
                                                    >
                                                        <InsightContent skill={cert.title} />
                                                    </a>
                                                );
                                            }
                                        )}
                                    </>
                                    if userSkillgap[0].certifications else ""
                                }
                            </div>
                            if userSkillgap.length > 0 else ""
                        }

                        <div className="mt-6">
                            <h3 className="text-base font-normal text-gray-300 mb-4">
                                My CV
                            </h3>

                            <div className="w-full flex flex-col gap-4">
                                <div
                                    onClick={lambda -> None {
                                        openResumePreview();
                                    }}
                                    className="flex items-start gap-3 p-3 bg-[black] rounded-lg hover:bg-[#1a1a1a] transition-colors cursor-pointer"
                                >
                                    <div className="w-12 h-12 bg-red-500/10 rounded-lg flex items-center justify-center flex-shrink-0">
                                        <svg
                                            className="w-6 h-6 text-red-500"
                                            fill="none"
                                            stroke="currentColor"
                                            viewBox="0 0 24 24"
                                        >
                                            <path
                                                strokeLinecap="round"
                                                strokeLinejoin="round"
                                                strokeWidth={2}
                                                d="M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"
                                            />
                                        </svg>
                                    </div>

                                    <div className="flex-1 min-w-0">
                                        <div className="text-white font-medium text-sm mb-1 truncate">
                                            {cvFileName if cvFileName else "No CV uploaded"}
                                        </div>

                                        <div className="text-gray-500 text-xs">
                                            Last updated: Dec 10, 2025
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



            </div>;
        }

        def DashHeader() -> any {
            return <div className="lg:hidden fixed top-0 left-0 right-0 bg-[#0b0b0b] border-b border-gray-800 p-4 flex items-center justify-between z-[1000]">
                <button 
                    onClick={lambda e:any -> None { setSidebarOpen(True); }}
                    className="text-white bg-transparent border-none cursor-pointer">
                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
                    </svg>
                </button>
                <div className="text-xl font-semibold text-white">Arise</div>
                <button 
                    onClick={lambda e:any -> None { setProfileOpen(True); }}
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
                            { LoadingDots() if isLoading else "Save Changes"}
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
                                    let alreadySelected = props.selectedItems.some(
                                        lambda s:any -> bool { return s.name == inputValue.trim(); }
                                    );

                                    if (alreadySelected == false) {
                                        let newSelected = props.selectedItems.concat([
                                            {
                                                name: inputValue.trim(),
                                                description: ""
                                            }
                                        ]);
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
                                            {item.name}
                                            <svg 
                                                onClick={lambda e:any -> None {
                                                    props.setSelectedItems(
                                                        props.selectedItems.filter(
                                                            lambda i:any -> bool { return i.name != item.name; }
                                                        )
                                                    );

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
                    {
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
                                    return None;
                                }
                            )}
                        </div>
                    </div>

                    if  not props.availableItems == "none" else ""}
                </div>
            </div>;
        }

        def QuickActionCard(props:any) -> any {
            let iconBg = 
            "bg-blue-900/15" if props.color == "blue" else (
                "bg-purple-900/15" if props.color == "purple" else (
                    "bg-green-900/15" if props.color == "green" else "bg-gray-900"
                )
            );
            
            let iconColor = "text-blue-400" if props.color == "blue" else (
                "text-purple-400" if props.color == "purple" else (
                    "text-green-400" if props.color == "green" else "text-gray-400"
                )
            );
            
            return <div 
                onClick={props.onClick}
                className="border border-gray-300/20 rounded-md p-4 hover:border-primary transition-all cursor-pointer group">
                <div className="flex items-start gap-4">
                    <div className={iconBg + " w-12 h-12 rounded-lg flex items-center justify-center flex-shrink-0  transition-transform"}>
                        <div className={iconColor}>
                            {props.icon}
                        </div>
                    </div>
                    <div className="flex-1">
                        <h3 className="text-white font-semibold text-base mb-1">{props.title}</h3>
                        <p className="text-gray-400 text-sm">{props.description}</p>
                    </div>
                </div>
            </div>;
        }

        def DashContent() -> any {
            
            return <div className="flex-1 p-6 md:p-8">
                {activeLink == "dashboard" && (
                    <div className="[&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">
                        <h1 className="text-2xl md:text-3xl font-bold text-white mb-6">Welcome Back!</h1>
                        <div className="grid grid-cols-1 md:grid-cols-[72%_28%] gap-4 md:gap-1 ">
                           <div className="w-[98%] h-[35vh] bg-gradient-to-br from-purple-600 to-blue-500 rounded-2xl p-8 flex flex-col justify-between relative overflow-hidden">
                                <div className="absolute top-0 right-0 w-64 h-64 bg-white opacity-5 rounded-full blur-3xl"></div>
                                <div className="absolute bottom-0 right-20 w-40 h-40 bg-white opacity-5 rounded-full blur-2xl"></div>
                                
                                <div className="relative z-10">
                                    <div className="text-white text-xs uppercase tracking-wider font-semibold mb-3 opacity-90">Online Course</div>
                                    <h2 className="text-white text-2xl md:text-3xl font-bold leading-tight mb-6">
                                        Sharpen Your Skills with<br/>Professional Online Courses
                                    </h2>
                                </div>
                                
                                <div className="relative z-10">
                                    <button 
                                    onClick={lambda -> None {
                                            let query = userRoles[0].title if userRoles.length > 0 else "";
                                            let url = f"https://www.udemy.com/courses/search/?src=ukw&q={query}";
                                            window.open(url, '_blank');
                                        }}
                                        className="bg-black text-white pl-8 pr-3 py-3 rounded-full font-semibold flex items-center gap-3 hover:bg-gray-900 transition-all hover:translate-x-1 shadow-lg">
                                        <span>Join Now</span>
                                        <div className="w-6 h-6 bg-white rounded-full flex items-center justify-center">
                                            <svg className="w-3 h-3 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M9 5l7 7-7 7" />
                                            </svg>
                                        </div>
                                    </button>
                                </div>
                            </div>
                           <div className="relative h-[35vh] border border-gray-300/30 rounded-lg overflow-hidden">
                                <img 
                                    src={jaseciImg} 
                                    alt="jaseci" 
                                    className="absolute inset-0 w-full h-full object-cover z-0"
                                />
                                <div className="relative z-10 flex h-full w-full">
                                    <div className="absolute text-xs top-[10px] right-[10px] rounded-md bg-orange-500 text-white px-3 py-2">
                                        Trending
                                    </div>
                                    <button 
                                        onClick={lambda -> None { window.open('https://docs.jaseci.org/learn/tour/', '_blank'); }}
                                        className="cursor-pointer absolute bottom-[15px] left-1/2 -translate-x-1/2 bg-orange-500 text-white rounded-md px-6 py-2 hover:bg-orange-600 transition-colors font-medium w-[90%]"
                                    >
                                        Learn Jaseci
                                    </button>                               
                                </div>
                            </div>

                        </div>
                        <div>
                            <h3 className="mt-4 text-base font-normal text-gray-300 mb-6">Quick Actions</h3>
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <QuickActionCard 
                                    color="blue"
                                    title="Skills"
                                    description="View your current skillset"
                                    icon={<Puzzle className="w-6 h-6" />}
                                    onClick={lambda e:any -> None { setActiveLink("skills"); }}
                                />
                                <QuickActionCard 
                                    color="purple"
                                    title="Roles"
                                    description="Targeted career roles"
                                    icon={<Briefcase className="w-6 h-6" />}
                                    onClick={lambda e:any -> None { setActiveLink("roles"); }}
                                />
                                <QuickActionCard 
                                    color="green"
                                    title="Arise AI"
                                    description="Learn with AI"
                                    icon={<Bubbles className="w-6 h-6" />}
                                    onClick={lambda e:any -> None { setActiveLink("ariseai"); }}
                                />
                            </div>
                        </div>
    
                        <div>
                            <h3 className="mt-4 text-base font-normal text-gray-300 mb-6">My Roadmaps</h3>
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                            {roadmapData.map(
                                lambda roadmap:any -> any {
                                    return <RoadmapContent 
                                        key={roadmap.id}
                                        roadmap={roadmap.body.role_title}
                                        markdown={roadmap.body.learning_path}
                                    />;
                                }
                            )}
                            </div>
                        </div>
                    </div>
                )}

                {activeLink == "notifications" && (
                    <div>
                        { 
                            (<div>
                                <button 
                                    onClick={lambda e:any -> None { setSelectedNotification(None); }}
                                    className="flex items-center gap-2 text-gray-400 hover:text-white transition-colors mb-6 bg-transparent border-none cursor-pointer">
                                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                                    </svg>
                                    <span>Back to notifications</span>
                                </button>

                                <div className="rounded-lg p-8">
                                    <div className="flex items-start gap-4 mb-6 pb-6 border-b border-gray-800">
                                        <div className={"w-16 h-16 rounded-full flex items-center justify-center flex-shrink-0 " + (
                                            "bg-orange-500" if selectedNotification.type == "message" else (
                                                "bg-blue-500" if selectedNotification.type == "event" else (
                                                    "bg-green-500" if selectedNotification.type == "success" else "bg-yellow-500"
                                                )
                                            )
                                        )}>
                                            {selectedNotification.type == "message" && (
                                                <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
                                                </svg>
                                            )}
                                            {selectedNotification.type == "event" && (
                                                <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                </svg>
                                            )}
                                            {selectedNotification.type == "success" && (
                                                <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                                                </svg>
                                            )}
                                            {selectedNotification.type == "warning" && (
                                                <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                                </svg>
                                            )}
                                        </div>
                                        
                                        <div className="flex-1">
                                            <h2 className="text-white text-2xl font-bold mb-2">{selectedNotification.title}</h2>
                                            <div className="flex items-center gap-4 text-sm text-gray-400">
                                                <span>{selectedNotification.time}</span>
                                                <span className="w-1 h-1 bg-gray-600 rounded-full"></span>
                                                <span className="capitalize">{selectedNotification.type}</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div className="text-gray-300 leading-relaxed">
                                        <p>{selectedNotification.description}</p>
                                    </div>

                                    <div className="mt-8 flex gap-3">
                                        <button 
                                            onClick={lambda e:any -> None {
                                                let updatedNotifications = notifications.filter(lambda n:any -> bool { return n.id != selectedNotification.id; });
                                                setNotifications(updatedNotifications);
                                                setSelectedNotification(None);
                                            }}
                                            className="px-6 py-3 bg-transparent text-red-400 border border-red-400 rounded-lg hover:bg-red-400 hover:text-white transition-all cursor-pointer font-semibold">
                                            Delete
                                        </button>
                                        {selectedNotification.url and safeStr(selectedNotification.url) != "" and (
                                            <button
                                                onClick={lambda e:any -> None { window.open(selectedNotification.url, "_blank"); }}
                                                className="px-6 py-3 bg-[#101010ff] text-white rounded-lg hover:bg-[#1a1a1a] transition-all border border-gray-700 cursor-pointer font-semibold"
                                            >
                                                Open Link
                                            </button>
                                        )}
                                    </div>
                                </div>
                            </div>)
                        if selectedNotification else 
                            (<div>
                                <div className="flex items-center justify-between mb-6">
                                    <div>
                                        <h1 className="text-2xl md:text-3xl font-bold text-white mb-2">Notifications</h1>
                                        <p className="text-gray-400">You have {unreadCount} new notifications.</p>
                                    </div>
                                    {unreadCount > 0 && (
                                        <button 
                                            onClick={lambda e:any -> None {
                                                let updatedNotifications = notifications.map(lambda n:any -> any {
                                                    return {id: n.id, type: n.type, title: n.title, description: n.description, time: n.time, read: True};
                                                });
                                                setNotifications(updatedNotifications);
                                            }}
                                            className="px-6 py-3 bg-[#101010ff] text-white rounded-lg hover:bg-[#1a1a1a] transition-all border border-gray-700 cursor-pointer font-semibold">
                                            Mark all as read
                                        </button>
                                    )}
                                </div>

                                <div className="rounded-lg">
                                    {notifications.map(lambda notification:any -> any {
                                        let iconBg = "bg-none";
                                        
                                        let isUnread = notification.read == false;
                                        
                                        return <div 
                                            key={notification.id}
                                            className="border-b border-gray-800 last:border-b-0 p-6 hover:bg-[#0b0b0b] transition-all cursor-pointer"
                                            onClick={lambda e:any -> None {
                                                setSelectedNotification(notification);
                                                if (isUnread) {
                                                    let updatedNotifications = notifications.map(lambda n:any -> any {
                                                        if (n.id == notification.id) {
                                                            return {id: n.id, type: n.type, title: n.title, description: n.description, time: n.time, read: True};
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
                                                    <p className="text-gray-400 text-sm line-clamp-2">{notification.description}</p>
                                                </div>
                                            </div>
                                        </div>;
                                    })}
                                </div>
                            </div>)
                         }
                    </div>
                )}

                {activeLink == "skills" && (
                    <SelectionManager 
                        title="Select Your Skills"
                        description="Choose or add your skills"
                        placeholder="Search or type a skill and press Enter"
                        selectedLabel="Selected Skills"
                        availableLabel="Available Skills"
                        availableItems="none"
                        selectedItems={selectedSkills}
                        setSelectedItems={setSelectedSkills}
                        onSave={handleSaveSkills}
                    />
                )}

                {activeLink == "roles" && (
                    <SelectionManager 
                        title="Select Your Roles"
                        description="Choose or add your target roles"
                        placeholder="Search or type a role and press Enter"
                        selectedLabel="Selected Roles"
                        availableLabel="Available Roles"
                        availableItems={"none"}
                        selectedItems={selectedRoles}
                        setSelectedItems={setSelectedRoles}
                        onSave={lambda -> None {}}
                    />
                )}

                {activeLink == "certifications" && (
                    <SelectionManager 
                        title="Select Your Certifications"
                        description="Choose or add your certifications"
                        placeholder="Search or type a certification and press Enter"
                        selectedLabel="Selected Certifications"
                        availableLabel="Available Certifications"
                        availableItems="none"
                        selectedItems={selectedCertifications}
                        setSelectedItems={setSelectedCertifications}
                        onSave={handleSaveCertifications}
                    />
                )}


                {activeLink == "roadmap" && (
                    <div>
                        <h1 className="text-2xl md:text-3xl font-bold text-white mb-6">My Roadmap</h1>
                        <p className="text-gray-400">Your personalized learning path</p>

                         <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                            {roadmapData.map(
                                lambda roadmap:any -> any {
                                    return <RoadmapContent 
                                        key={roadmap.id}
                                        roadmap={roadmap.body.role_title}
                                        markdown={roadmap.body.learning_path}

                                    />;
                                }
                            )}
                            </div>
                    </div>
                )}

                {activeLink == "roadmap-inside" && (
                        <div>
                            <button 
                                onClick={lambda e:any -> None { setActiveLink("roadmap"); }}
                                className="flex items-center gap-2 text-gray-400 hover:text-white transition-colors mb-6 bg-transparent border-none cursor-pointer">
                                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                                </svg>
                                <span>Back to Roadmaps</span>
                            </button>

                            <div className="rounded-lg p-8">
                               {
                                   <div className="flex flex-col items-center justify-center p-20 min-h-[400px]">
                                        <div className="bg-blue-600/20 backdrop-blur-sm border border-blue-500/30 p-8 rounded-2xl flex flex-col items-center gap-4 shadow-xl shadow-blue-900/10">
                                            <div style={{
                                                "display": "flex",
                                                "justifyContent": "center",
                                                "alignItems": "center",
                                                "gap": "8px",
                                                "height": "40px"
                                            }}>
                                                <span className="loading-dot w-3 h-3 bg-blue-400"></span>
                                                <span className="loading-dot w-3 h-3 bg-blue-400" style={{"animationDelay": "0.2s"}}></span>
                                                <span className="loading-dot w-3 h-3 bg-blue-400" style={{"animationDelay": "0.4s"}}></span>
                                            </div>
                                            <div className="text-blue-300 font-medium tracking-wide animate-pulse">Generating your personalized roadmap...</div>
                                        </div>
                                   </div>
                                   if roadmapMarkdown == "GENERATING_ROADMAP"
                                   else 
                                   <div className="max-w-4xl mx-auto px-2 lg:px-6 py-8 text-white">
                                    <ReactMarkdown
                                        components={{
                                        h1: lambda props:any -> any { return <h1 className="text-4xl font-bold mb-6 pb-2 border-b border-gray-700">{props.children}</h1>; },
                                        h2: lambda props:any -> any { return <h2 className="text-3xl font-semibold mt-8 mb-4 pb-2 border-b border-gray-700">{props.children}</h2>; },
                                        h3: lambda props:any -> any { return <h3 className="text-2xl font-semibold mt-6 mb-3">{props.children}</h3>; },
                                        h4: lambda props:any -> any { return <h4 className="text-xl font-semibold mt-4 mb-2">{props.children}</h4>; },
                                        p: lambda props:any -> any { return <p className="mb-4 leading-7 text-gray-200">{props.children}</p>; },
                                        ul: lambda props:any -> any { return <ul className="list-disc ml-6 mb-4 space-y-2">{props.children}</ul>; },
                                        ol: lambda props:any -> any { return <ol className="list-decimal ml-6 mb-4 space-y-2">{props.children}</ol>; },
                                        li: lambda props:any -> any { return <li className="leading-7 text-gray-200">{props.children}</li>; },
                                        strong: lambda props:any -> any { return <strong className="font-semibold text-white">{props.children}</strong>; },
                                        em: lambda props:any -> any { return <em className="italic text-gray-300">{props.children}</em>; },
                                        code: lambda props:any -> any { return <code className="bg-gray-800 text-pink-400 px-1.5 py-0.5 rounded text-sm font-mono">{props.children}</code>; },
                                        pre: lambda props:any -> any { return <pre className="bg-gray-900 p-4 rounded-lg overflow-x-auto mb-4 border border-gray-700">{props.children}</pre>; },
                                        blockquote: lambda props:any -> any { return <blockquote className="border-l-4 border-gray-600 pl-4 italic text-gray-400 my-4">{props.children}</blockquote>; },
                                        a: lambda props:any -> any { return <a className="text-blue-400 hover:text-blue-300 underline" href={props.href}>{props.children}</a>; }
                                        }}
                                    >
                                        {roadmapMarkdown}
                                    </ReactMarkdown>
                                    </div>
                               }
                            </div>
                        </div>
                    )
                }

                {activeLink == "ariseai" && (
                   <ChatBot/>
                )}
            </div>;
        }
        
        def ChatBot() -> any {

            def safeStr(x:any) -> str {
                if x == None { return ""; }
                return ("" + x);
            }

            def trimStr(x:any) -> str {
                let s = safeStr(x);
                return s.trim();
            }

            def getUserName() -> str {
                let nm = "";
                try {
                    if userDetails != None and ("full_name" in userDetails) and userDetails["full_name"] != None {
                        nm = trimStr(userDetails["full_name"]);
                    }
                } except Exception as e { }
                if nm == "" { nm = "You"; }
                return nm;
            }

            def getUserInitial() -> str {
                let nm = getUserName();
                if nm == "" { return "U"; }
                return ("" + nm[0]).toUpperCase();
            }

            def getTimeNowLabel() -> str {
                return "Now";
            }

            let [messages, setMessages] = useState([
                {
                    "id": "greet",
                    "type": "bot",
                    "content": "Hello! I'm Arise AI. How can I help you with your learning journey today?",
                    "timestamp": "12:00"
                }
            ]);

            let [inputValue, setInputValue] = useState("");
            let [isTyping, setIsTyping] = useState(false);
            let messagesEndRef = useRef(None);

            def scrollToBottom() -> None {
                try {
                    if messagesEndRef.current != None {
                        messagesEndRef.current.scrollIntoView({ "behavior": "smooth" });
                    }
                } except Exception as e { }
            }

            useEffect(lambda -> None { scrollToBottom(); }, [messages, isTyping]);

            def extractReply(result:any) -> str {
                if result != None and ("reply" in result) and result["reply"] != None {
                    return safeStr(result["reply"]);
                }

                if result != None and ("reports" in result) and result["reports"] != None and result["reports"].length > 0 {
                    for r in result["reports"] {
                        if r != None and ("reply" in r) and r["reply"] != None {
                            return safeStr(r["reply"]);
                        }

                        if r != None and ("body" in r) and r["body"] != None and ("reply" in r["body"]) and r["body"]["reply"] != None {
                            return safeStr(r["body"]["reply"]);
                        }
                    }
                }

                return "Sorry — I couldn’t generate a reply right now. Please try again.";
            }

            async def handleSendMessage() -> None {
                if inputValue.trim() == "" or isTyping == True { return; }

                let trimmed = inputValue.trim();
                let userMessage = {
                    "id": "u_" + ("" + window.performance.now()),
                    "type": "user",
                    "content": trimmed,
                    "timestamp": getTimeNowLabel()
                };

                setMessages(lambda prev:any -> any { return prev.concat([userMessage]); });
                setInputValue("");
                setIsTyping(True);

                let replyText = "Sorry — I couldn’t generate a reply right now. Please try again.";

                try {
                    let uid = "local-user";

                    try {
                        if userDetails != None {
                            if ("email" in userDetails) and userDetails["email"] != None and trimStr(userDetails["email"]) != "" {
                                uid = safeStr(userDetails["email"]);
                            } else {
                                uid = getUserName();
                            }
                        } else {
                            uid = getUserName();
                        }
                    } except Exception as e_uid { }

                    let result = await root spawn career_chat(
                        user_id=uid,
                        message=trimmed,
                        focus_area="General guidance"
                    );

                    replyText = extractReply(result);

                } except Exception as e {
                    console.log(e);
                    replyText = "Sorry — I had trouble reaching Arise AI backend. Please try again.";
                }

                let botMessage = {
                    "id": "b_" + ("" + window.performance.now()),
                    "type": "bot",
                    "content": replyText,
                    "timestamp": getTimeNowLabel()
                };

                setMessages(lambda prev:any -> any { return prev.concat([botMessage]); });
                setIsTyping(false);
            }

            def TypingIndicator() -> any {
                return (
                    <div className="flex justify-start mb-10 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">
                        <div className="flex items-end gap-4">
                            <div className="w-10 h-10 rounded-full bg-purple-600 flex items-center justify-center flex-shrink-0">
                                <span className="text-white text-sm font-semibold">AI</span>
                            </div>

                            <div className="flex flex-col items-start">
                                <div className="text-white font-bold text-sm mb-2">Arise AI</div>

                                <div className="bg-[#1a1a1a] text-white rounded-2xl px-5 py-3 max-w-[560px]">
                                    <div style={{
                                        "display": "flex",
                                        "justifyContent": "center",
                                        "alignItems": "center",
                                        "gap": "6px",
                                        "height": "20px"
                                    }}>
                                        <span className="loading-dot"></span>
                                        <span className="loading-dot"></span>
                                        <span className="loading-dot"></span>
                                    </div>
                                </div>

                                <div className="text-xs text-gray-500 mt-2">...</div>
                            </div>
                        </div>
                    </div>
                );
            }

            return (
                <div className="flex flex-col h-[calc(100vh-3rem)]">
                    <div className="mb-8"></div>

                    <div className="flex-1 overflow-y-auto pr-2">

                        {messages.map(lambda m:any -> any {

                            let t = "bot";
                            try {
                                if m != None and ("type" in m) and m["type"] != None {
                                    t = ("" + m["type"]).toLowerCase();
                                }
                            } except Exception as e { t = "bot"; }

                            let isUser = (t == "user");

                            let mid = "m_" + ("" + window.performance.now());
                            try { if m != None and ("id" in m) and m["id"] != None { mid = safeStr(m["id"]); } } except Exception as e2 { }

                            let content = "";
                            try { if m != None and ("content" in m) and m["content"] != None { content = safeStr(m["content"]); } } except Exception as e3 { }

                            let ts = "Now";
                            try { if m != None and ("timestamp" in m) and m["timestamp"] != None { ts = safeStr(m["timestamp"]); } } except Exception as e4 { }

                            if isUser {
                                return (
                                    <div key={mid} className="flex justify-end mb-10">
                                        <div className="flex items-end gap-4">

                                            <div className="flex flex-col items-end">
                                                <div className="text-white font-bold text-sm mb-2">{getUserName()}</div>

                                                <div className="bg-purple-600 text-white rounded-2xl px-5 py-3 text-sm leading-relaxed max-w-[560px]">
                                                    {content}
                                                </div>

                                                <div className="text-xs text-gray-500 mt-2 text-right">
                                                    {ts}
                                                </div>
                                            </div>

                                            <div className="w-10 h-10 rounded-full bg-purple-600 flex items-center justify-center flex-shrink-0">
                                                <span className="text-white text-sm font-semibold">{getUserInitial()}</span>
                                            </div>
                                        </div>
                                    </div>
                                );
                            }

                            return (
                                <div key={mid} className="flex justify-start mb-10">
                                    <div className="flex items-end gap-4">
                                        <div className="w-10 h-10 rounded-full bg-purple-600 flex items-center justify-center flex-shrink-0">
                                            <span className="text-white text-sm font-semibold">AI</span>
                                        </div>

                                        <div className="flex flex-col items-start">
                                            <div className="text-white font-bold text-sm mb-2">Arise AI</div>

                                            <div className="bg-[#1a1a1a] text-white rounded-2xl px-5 py-3 text-sm leading-relaxed max-w-[560px]">
                                                <ReactMarkdown
                                                    components={{
                                                        p: lambda props:any -> any { return <p className="mb-2 last:mb-0">{props.children}</p>; },
                                                        ul: lambda props:any -> any { return <ul className="list-disc ml-4 mb-2">{props.children}</ul>; },
                                                        ol: lambda props:any -> any { return <ol className="list-decimal ml-4 mb-2">{props.children}</ol>; },
                                                        li: lambda props:any -> any { return <li className="mb-1">{props.children}</li>; },
                                                        strong: lambda props:any -> any { return <strong className="font-bold text-white">{props.children}</strong>; },
                                                        h1: lambda props:any -> any { return <h1 className="text-lg font-bold mb-2">{props.children}</h1>; },
                                                        h2: lambda props:any -> any { return <h2 className="text-md font-bold mb-2">{props.children}</h2>; },
                                                        h3: lambda props:any -> any { return <h3 className="text-sm font-bold mb-1">{props.children}</h3>; }
                                                    }}
                                                >
                                                    {content}
                                                </ReactMarkdown>
                                            </div>

                                            <div className="text-xs text-gray-500 mt-2 text-left">
                                                {ts}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            );
                        })}

                        {TypingIndicator() if isTyping else ""}

                        <div ref={messagesEndRef} />
                    </div>

                    <div className="border-t border-gray-800 pt-4">
                        <div className="relative flex items-center gap-2">
                            <input
                                type="text"
                                value={inputValue}
                                onChange={lambda e:any -> None { setInputValue(e.target.value); }}
                                onKeyPress={lambda e:any -> None {
                                    if e.key == "Enter" and not e.shiftKey {
                                        e.preventDefault();
                                        handleSendMessage();
                                    }
                                }}
                                placeholder="Type your message..."
                                className="flex-1 border border-gray-700 rounded-lg px-4 py-3 text-white placeholder-gray-500 focus:outline-none focus:border-purple-600 transition-colors bg-transparent"
                            />

                            <button
                                onClick={lambda e:any -> None { handleSendMessage(); }}
                                disabled={inputValue.trim() == "" or isTyping == True}
                                className="bg-purple-600 text-white p-3 rounded-lg hover:bg-purple-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center"
                            >
                                <Send className="w-5 h-5" />
                            </button>
                        </div>
                    </div>
                </div>
            );
        }

        def RoadmapContent(props:any) -> any {
            return <div onClick={lambda e:any -> None { 
                setActiveLink("roadmap-inside");
                setRoadmapMarkdown(props.markdown);

            }} className="bg-gradient-to-br from-purple-600 to-blue-500 w-full h-[170px] rounded-[30px] p-[5px] mt-4">
            <div className="bg-black h-[88%] rounded-[30px] p-5">
                <Map className="w-6 h-6 text-[#6e11b0]" />
                <div className="text-white mt-3 capitalize">{props.roadmap}</div>
                <div className="text-gray-400 text-sm mt-1 cursor-pointer flex flex-row items-center">View More</div>
            </div>
            </div>;
        }

        def InsightContent(props:any) -> any {
            return <div >
            <p className="group font-regular text-[12px] relative block overflow-hidden rounded-lg border border-black bg-black p-2.5 text-neutral-400 no-underline mb-2 hover:border-black hover:text-neutral-100 sm:p-3.5">
            {props.skill}
            </p>
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

            <div className="md:ml-64 lg:mr-72 min-h-screen">
                <DashHeader />
                <div className="pt-16 lg:pt-0">
                    <DashContent />
                </div>
            </div>

            <div className="hidden lg:block fixed top-0 right-0">
                <ProfilePanel />
            </div>
            <MobileProfilePanel />
            <CvPreviewModal />
        </div>;
    }
}