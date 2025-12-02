cl import from react { useState }
cl import from 'lucide-react' { ChevronLeft }
cl import from "@jac-client/utils" {
    useNavigate,
}  

cl{
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

        return <div className="w-full h-screen bg-black grid overflow-hidden grid-cols-[100%] md:grid-cols-[50%_50%] relative text-white">

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
}