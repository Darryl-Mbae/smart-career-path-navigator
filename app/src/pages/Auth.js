import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { useState } from "react";
import { ChevronLeft } from "lucide-react";
import { useNavigate } from "@jac-client/utils";
function Auth() {
  let navigate = useNavigate();
  let [loginEmail, setLoginEmail] = useState("");
  let [loginPassword, setLoginPassword] = useState("");
  let [signupName, setSignupName] = useState("");
  let [signupEmail, setSignupEmail] = useState("");
  let [signupPassword, setSignupPassword] = useState("");
  let [isSignIn, setIsSignIn] = useState(true);
  let [error, setError] = useState("");
  let baseClasses = "hidden md:flex w-1/2 h-full absolute top-0 justify-center items-center pointer-events-none transition-all duration-300 ease-in";
  let positionClass = isSignIn ? "left-1/2" : "left-0";
  let signInClass = isSignIn ? "block md:flex" : "hidden md:flex";
  let signUpClass = isSignIn ? "hidden md:flex" : "block md:flex";
  async function handleLogin(e) {
    navigate("/dashboard");
  }
  async function handleSignup(e) {
    navigate("/onboarding");
  }
  function Header() {
    return __jacJsx("div", {"className": "w-[90%] md:w-[calc(70%+1.25rem)] text-left mb-4"}, [__jacJsx("div", {"onClick": e => {
      navigate("/");
    }, "className": "flex flex-row items-center text-gray-400 cursor-pointer mb-2"}, [__jacJsx("span", {}, [__jacJsx(ChevronLeft, {}, [])]), __jacJsx("span", {"className": "ml-1"}, ["Back"])])]);
  }
  return __jacJsx("div", {"className": "w-full h-screen bg-black grid overflow-hidden grid-cols-[100%] md:grid-cols-[50%_50%] relative text-white"}, [__jacJsx("div", {"className": signInClass + " w-full h-screen flex items-center justify-center"}, [__jacJsx("div", {"className": "w-full flex flex-col items-center p-6"}, [__jacJsx(Header, {}, []), __jacJsx("h2", {"className": "w-[90%] md:w-[calc(70%+1.25rem)] text-xl font-bold my-[20px] md:pl-[10px]"}, ["Create your account"]), __jacJsx("form", {"onSubmit": handleLogin, "className": "w-full flex flex-col items-center w-[90%] md:w-[70%]"}, [__jacJsx("input", {"type": "email", "placeholder": "Email", "value": loginEmail, "onChange": e => {
    setLoginEmail(e.target.value);
  }, "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"}, []), __jacJsx("input", {}, []), __jacJsx("input", {"type": "password", "placeholder": "Password", "value": loginPassword, "onChange": e => {
    setLoginPassword(e.target.value);
  }, "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"}, []), __jacJsx("input", {}, []), __jacJsx("button", {"type": "submit", "className": "w-full p-5 rounded-[8px] border-none bg-primary text-white font-semibold cursor-pointer"}, ["Sign In"])]), __jacJsx("p", {"className": "mt-[19px] text-[14px] text-[#bbbbbb] items-center"}, ["Don't have an account?", __jacJsx("span", {"onClick": e => {
    setIsSignIn(false);
  }, "className": "text-primary cursor-pointer ml-[5px] font-semibold"}, ["Sign Up"])])])]), __jacJsx("div", {"className": signUpClass + " w-full h-screen flex items-center justify-center"}, [__jacJsx("div", {"className": "w-full flex flex-col items-center p-6"}, [__jacJsx(Header, {}, []), __jacJsx("h2", {"className": "w-[90%] md:w-[calc(70%+1.25rem)] my-[20px] text-xl font-bold md:pl-[10px]"}, ["Create your account"]), __jacJsx("form", {"onSubmit": handleSignup, "className": "w-[90%] md:w-[70%] flex flex-col items-center"}, [__jacJsx("input", {"type": "text", "placeholder": "Full Name", "value": signupName, "onChange": e => {
    setSignupName(e.target.value);
  }, "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"}, []), __jacJsx("input", {"type": "email", "placeholder": "Email", "value": signupEmail, "onChange": e => {
    setSignupEmail(e.target.value);
  }, "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"}, []), __jacJsx("input", {"type": "password", "placeholder": "Password", "value": signupPassword, "onChange": e => {
    setSignupPassword(e.target.value);
  }, "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"}, []), __jacJsx("input", {}, []), __jacJsx("button", {"type": "submit", "className": "w-full p-5 rounded-[8px] border-none bg-primary text-white font-semibold cursor-pointer"}, ["Sign Up"])]), __jacJsx("p", {"className": "mt-[19px] text-[14px] text-[#bbbbbb] items-center"}, ["Already have an account?", __jacJsx("span", {"onClick": e => {
    setIsSignIn(true);
  }, "className": "text-primary cursor-pointer ml-[5px] font-semibold"}, ["Sign In"])])])]), __jacJsx("div", {"className": baseClasses + " " + positionClass}, [__jacJsx("div", {"className": "m-auto bg-primary w-[97%] h-[97%] z-[9999] rounded-[10px] flex justify-center items-center overflow-hidden"}, [])])]);
}
export { Auth };
