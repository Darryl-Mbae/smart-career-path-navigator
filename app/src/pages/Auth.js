import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { useState } from "react";
import { ChevronLeft, Eye, EyeClosed } from "lucide-react";
import roles from "@jac-client/assets/images/mac-roles.png";
import { useNavigate, jacSignup, jacLogin } from "@jac-client/utils";
function Auth() {
  let navigate = useNavigate();
  let [isLoading, setIsLoading] = useState(false);
  let [loginEmail, setLoginEmail] = useState("");
  let [loginPassword, setLoginPassword] = useState("");
  let [signupName, setSignupName] = useState("");
  let [signupEmail, setSignupEmail] = useState("");
  let [signupPassword, setSignupPassword] = useState("");
  let [isSignIn, setIsSignIn] = useState(false);
  let [error, setError] = useState("");
  let [showPassword, setShowPassword] = useState(false);
  let baseClasses = "hidden md:flex w-1/2 h-full absolute top-0 justify-center items-center pointer-events-none transition-all duration-300 ease-in";
  let positionClass = isSignIn ? "left-1/2" : "left-0";
  let signInClass = isSignIn ? "block md:flex" : "hidden md:flex";
  let signUpClass = isSignIn ? "hidden md:flex" : "block md:flex";
  async function handleLogin(e) {
    e.preventDefault();
    setIsLoading(true);
    setError("");
    if (!loginEmail || !loginPassword) {
      setError("Please fill all fields");
      setIsLoading(false);
      return;
    }
    let success = await jacLogin(loginEmail, loginPassword);
    if (success) {
      setIsLoading(false);
      let resume_status = await __jacSpawn("check_resume_upload_status", "", {});
      if (resume_status.reports[0]["body"] === true) {
        navigate("/dashboard");
      } else {
        navigate("/onboarding");
      }
    } else {
      setError("Wrong email or password");
      setIsLoading(false);
    }
  }
  async function handleSignup(e) {
    e.preventDefault();
    setIsLoading(true);
    setError("");
    if (!signupName || !signupEmail || !signupPassword) {
      setError("Please fill in all fields");
      setIsLoading(false);
      return;
    }
    let result = await jacSignup(signupEmail, signupPassword);
    if (result["success"]) {
      setIsLoading(false);
      let new_memory = await __jacSpawn("initialize_memory", "", {"full_name": signupName, "email": signupEmail});
      console.log("New Memory initialized:");
      console.log(new_memory);
      navigate("/onboarding");
    } else {
      setError(result["error"] ? result["error"] : "Signup failed");
      setIsLoading(false);
    }
  }
  function Header() {
    return __jacJsx("div", {"className": "w-[90%] md:w-[calc(70%+1.25rem)] text-left mb-4"}, [__jacJsx("div", {"onClick": e => {
      navigate("/");
    }, "className": "flex flex-row items-center text-gray-400 cursor-pointer mb-2"}, [__jacJsx("span", {}, [__jacJsx(ChevronLeft, {}, [])]), __jacJsx("span", {"className": "ml-1"}, ["Back"])])]);
  }
  function LoadingDots() {
    return __jacJsx("div", {"style": {"display": "flex", "justifyContent": "center", "alignItems": "center", "gap": "6px", "height": "20px"}}, [__jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, [])]);
  }
  function PasswordToggleIcon(props) {
    if (props.showPassword) {
      return __jacJsx(EyeClosed, {"onClick": () => {
        props.setShowPassword(false);
      }, "className": "absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 cursor-pointer hover:text-white transition-colors", "size": 20}, []);
    } else {
      return __jacJsx(Eye, {"onClick": () => {
        props.setShowPassword(true);
      }, "className": "absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 cursor-pointer hover:text-white transition-colors", "size": 20}, []);
    }
  }
  return __jacJsx("div", {"className": "w-full h-screen bg-black grid overflow-hidden grid-cols-[100%] md:grid-cols-[50%_50%] relative text-white"}, [__jacJsx("div", {"className": signInClass + " w-full h-screen flex items-center justify-center"}, [__jacJsx("div", {"className": "w-full flex flex-col items-center p-6"}, [__jacJsx(Header, {}, []), __jacJsx("h2", {"className": "w-[90%] md:w-[calc(70%+1.25rem)] text-xl font-bold my-[20px] md:pl-[10px]"}, ["Log In"]), __jacJsx("form", {"onSubmit": handleLogin, "className": "w-full flex flex-col items-center w-[90%] md:w-[70%]"}, [__jacJsx("input", {"type": "email", "placeholder": "Email", "value": loginEmail, "onChange": e => {
    setLoginEmail(e.target.value);
  }, "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px] focus:border-primary focus:ring-1 focus:ring-primary", "autoComplete": "new-email"}, []), __jacJsx("div", {"className": "w-full relative mb-[16px]"}, [__jacJsx("input", {"type": showPassword ? "text" : "password", "placeholder": "Password", "value": loginPassword, "onChange": e => {
    setLoginPassword(e.target.value);
  }, "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary", "autoComplete": "new-password"}, []), PasswordToggleIcon({showPassword: showPassword, setShowPassword: setShowPassword})]), error && __jacJsx("p", {"className": "text-[#dc2626] mb-4 text-sm"}, [error]), __jacJsx("button", {"type": "submit", "className": "w-full p-5 rounded-[8px] border-none bg-primary text-white font-semibold cursor-pointer"}, [isLoading ? LoadingDots() : "Sign In"])]), __jacJsx("p", {"className": "mt-[19px] text-[14px] text-[#bbbbbb] items-center"}, ["Don't have an account?", __jacJsx("span", {"onClick": e => {
    setIsSignIn(false);
    setError("");
  }, "className": "text-primary cursor-pointer ml-[5px] font-semibold"}, ["Sign Up"])])])]), __jacJsx("div", {"className": signUpClass + " w-full h-screen flex items-center justify-center"}, [__jacJsx("div", {"className": "w-full flex flex-col items-center p-6"}, [__jacJsx(Header, {}, []), __jacJsx("h2", {"className": "w-[90%] md:w-[calc(70%+1.25rem)] my-[20px] text-xl font-bold md:pl-[10px]"}, ["Create your account"]), __jacJsx("form", {"onSubmit": handleSignup, "className": "w-[90%] md:w-[70%] flex flex-col items-center"}, [__jacJsx("input", {"type": "text", "placeholder": "Full Name", "value": signupName, "onChange": e => {
    setSignupName(e.target.value);
  }, "className": "focus:outline-none p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"}, []), __jacJsx("input", {"type": "email", "placeholder": "Email", "value": signupEmail, "onChange": e => {
    setSignupEmail(e.target.value);
  }, "className": "focus:outline-none p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]", "autoComplete": "new-email"}, []), __jacJsx("div", {"className": "w-full relative mb-[16px]"}, [__jacJsx("input", {"type": showPassword ? "text" : "password", "placeholder": "Password", "value": signupPassword, "onChange": e => {
    setSignupPassword(e.target.value);
  }, "className": "focus:outline-none p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full ", "autoComplete": "new-password"}, []), PasswordToggleIcon({showPassword: showPassword, setShowPassword: setShowPassword})]), error && __jacJsx("p", {"className": "text-[#dc2626] mb-4 text-sm"}, [error]), __jacJsx("button", {"type": "submit", "className": "w-full p-5 rounded-[8px] border-none bg-primary text-white font-semibold cursor-pointer"}, [isLoading ? LoadingDots() : "Sign Up"])]), __jacJsx("p", {"className": "mt-[19px] text-[14px] text-[#bbbbbb] items-center"}, ["Already have an account?", __jacJsx("span", {"onClick": e => {
    setIsSignIn(true);
    setError();
  }, "className": "text-primary cursor-pointer ml-[5px] font-semibold"}, ["Sign In"])])])]), __jacJsx("div", {"className": baseClasses + " " + positionClass}, [__jacJsx("div", {"className": "relative m-auto bg-primary w-[97%] h-[97%] z-[9999] rounded-[10px] overflow-hidden"}, [__jacJsx("img", {"src": roles, "alt": "skills illustration", "className": "absolute top-10 -left-50 lg:top-20 lg:-left-80 h-[72%] w-auto max-w-none"}, [])])])]);
}
export { Auth };
