cl import from react { useState }
cl import from "@jac-client/utils" { useNavigate }
    
cl {
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
                        <h1 style={{
                            "fontFamily":'"Zalando Sans", sans-serif'
                        }} className="text-5xl md:text-6xl leading-none font-bold my-2">AI-Powered Career Mapping for the Modern Workforce </h1>
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
}