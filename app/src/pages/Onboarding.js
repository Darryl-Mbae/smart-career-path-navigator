import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { useState, useEffect } from "react";
import { Brain, CloudUpload, Goal, Route as Node, ChevronLeft } from "lucide-react";
import { useNavigate } from "@jac-client/utils";
function Onboarding() {
  let [currentStep, setCurrentStep] = useState(1);
  let [stepCompleted, setStepCompleted] = useState(0);
  let [navbtnHover, setNavBtnHover] = useState("");
  let [progress, setProgress] = useState(25);
  let [resumeHover, setResumeHover] = useState(false);
  let [selectedInterests, setSelectedInterests] = useState([]);
  let [selectedRoles, setSelectedRoles] = useState([]);
  let navigate = useNavigate();
  let devSkills = ["JavaScript", "Python", "React", "Node.js", "TypeScript", "HTML & CSS", "Django", "Flutter", "Git & GitHub", "SQL & Databases", "REST APIs", "GraphQL", "Docker", "Agile & Scrum"];
  let devRoles = ["Frontend Developer", "Backend Developer", "Fullstack Developer", "Mobile Developer", "DevOps Engineer", "UI/UX Designer", "Data Scientist", "Machine Learning Engineer"];
  useEffect(() => {
    let percent = currentStep / 4 * 100;
    setProgress(percent + "%");
  }, [currentStep]);
  let steps = [{id: 1, title: "Upload Your CV", description: "Let our AI analyze your experience and extract your current skills.", icon: __jacJsx(CloudUpload, {"style": {"fontSize": "0.75rem"}}, []), completed: false}, {id: 2, title: "Review & Update Skills", description: "Confirm AI-detected skills and add any we might have missed.", icon: __jacJsx(Brain, {"style": {"fontSize": "0.75rem"}}, []), completed: false}, {id: 3, title: "Set Career Goals", description: "Choose your target roles, industries, and career aspirations.", icon: __jacJsx(Goal, {"style": {"fontSize": "0.75rem"}}, []), completed: false}, {id: 4, title: "Get Your Roadmap", description: "Explore your personalized learning path and skill gap analysis.", icon: __jacJsx(Node, {"style": {"fontSize": "0.75rem"}}, []), completed: false}];
  function Step(props) {
    let circleBase = "w-[40px] aspect-square rounded-full flex items-center justify-center relative z-10 transition-all duration-200 text-white";
    let circleShadow = props.step.id === currentStep ? "shadow-[0_0_20px_rgba(110,17,176,0.5)]" : "";
    let circleBg = props.step.id <= currentStep ? "bg-purple-800" : "bg-black";
    let lineBase = "absolute left-1/2 top-full -translate-x-1 z-[-1] h-[calc(100%+65px)] w-[2px] transition-all duration-200";
    let lineColor = props.step.id < currentStep ? "border-l-2 border-dashed border-purple-800" : "border-l-2 border-dashed border-gray-400";
    let titleBase = "mb-0 font-semibold text-[1.15rem]";
    let titleColor = props.step.id <= currentStep ? "text-white" : "text-whitesmoke";
    return __jacJsx("div", {"className": "flex flex-row gap-9 items-center w-3/4 mx-auto mb-[45px]"}, [__jacJsx("div", {"className": circleBase + " " + circleShadow + " " + circleBg}, [__jacJsx("div", {"className": "flex items-center justify-center relative w-full h-full"}, [props.step.icon, props.step.id !== 4 && __jacJsx("div", {"className": lineBase + " " + lineColor}, [])])]), __jacJsx("div", {}, [__jacJsx("h1", {"className": titleBase + " " + titleColor}, [props.step.title]), __jacJsx("p", {"className": "text-gray-400 mt-2 mb-0"}, [props.step.description])])]);
  }
  function Skills(props) {
    let [inputValue, setInputValue] = useState("");
    return __jacJsx("div", {"className": "h-[60vh] w-full"}, [__jacJsx("div", {"className": "mb-0 font-semibold text-white text-[1.15rem]"}, ["Select Your Skills"]), __jacJsx("p", {"className": "text-gray-500 my-0 mt-[10px] mb-6"}, ["Choose or add your skills"]), __jacJsx("div", {"className": "relative mb-6"}, [__jacJsx("input", {"type": "text", "placeholder": "Search or type a skill and press Enter", "value": inputValue, "onChange": e => {
      setInputValue(e.target.value);
    }, "onKeyDown": e => {
      if (e.key === "Enter" && inputValue.trim() !== "") {
        let alreadySelected = props.selectedInterests.includes(inputValue.trim());
        if (alreadySelected === false) {
          let newSelected = props.selectedInterests.concat([inputValue.trim()]);
          props.setSelectedInterests(newSelected);
        }
        setInputValue("");
      }
    }, "className": "w-full px-4 py-3 pl-10 bg-[#101010ff] border border-gray-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-[#6e11b0] transition-colors"}, []), __jacJsx("svg", {"className": "absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"}, [])])]), props.selectedInterests.length > 0 && __jacJsx("div", {"className": "mb-6"}, [__jacJsx("div", {"className": "text-gray-400 text-sm mb-2"}, ["Selected Skills"]), __jacJsx("div", {"className": "flex flex-wrap gap-2"}, [props.selectedInterests.map(skill => {
      return __jacJsx("div", {"key": skill, "className": "bg-primary text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer flex items-center gap-2 hover:bg-opacity-80 transition-all"}, [skill, __jacJsx("svg", {"onClick": e => {
        props.setSelectedInterests(props.selectedInterests.filter(i => {
          return i !== skill;
        }));
      }, "className": "w-4 h-4 hover:scale-110 transition-transform", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M6 18L18 6M6 6l12 12"}, [])])]);
    })])]), __jacJsx("div", {}, [__jacJsx("div", {"className": "text-gray-400 text-sm mb-2"}, ["Available Skills"]), __jacJsx("div", {"className": "flex flex-wrap gap-2 overflow-y-auto  md:max-h-[25vh]"}, [props.interests.map(interest => {
      let isSelected = props.selectedInterests.includes(interest);
      if (isSelected === false) {
        return __jacJsx("div", {"key": interest, "onClick": e => {
          let newSelected = props.selectedInterests.concat([interest]);
          props.setSelectedInterests(newSelected);
        }, "className": "border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-[#6e11b0] hover:bg-[#0b0b0b]"}, [interest]);
      }
      return null;
    })])])]);
  }
  function Roles(props) {
    let [inputValue, setInputValue] = useState("");
    return __jacJsx("div", {"className": "h-[60vh] w-full"}, [__jacJsx("div", {"className": "mb-0 font-semibold text-white text-[1.15rem]"}, ["Select Your Roles"]), __jacJsx("p", {"className": "text-gray-500 my-0 mt-[10px] mb-6"}, ["Choose or add your roles"]), __jacJsx("div", {"className": "relative mb-6"}, [__jacJsx("input", {"type": "text", "placeholder": "Search or type a role and press Enter", "value": inputValue, "onChange": e => {
      setInputValue(e.target.value);
    }, "onKeyDown": e => {
      if (e.key === "Enter" && inputValue.trim() !== "") {
        let alreadySelected = props.selectedRoles.includes(inputValue.trim());
        if (alreadySelected === false) {
          let newSelected = props.selectedRoles.concat([inputValue.trim()]);
          props.setSelectedRoles(newSelected);
        }
        setInputValue("");
      }
    }, "className": "w-full px-4 py-3 pl-10 bg-[#101010ff] border border-gray-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-[#6e11b0] transition-colors"}, []), __jacJsx("svg", {"className": "absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"}, [])])]), props.selectedRoles.length > 0 && __jacJsx("div", {"className": "mb-6"}, [__jacJsx("div", {"className": "text-gray-400 text-sm mb-2"}, ["Selected Roles"]), __jacJsx("div", {"className": "flex flex-wrap gap-2"}, [props.selectedRoles.map(role => {
      return __jacJsx("div", {"key": role, "className": "bg-primary text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer flex items-center gap-2 hover:bg-opacity-80 transition-all"}, [role, __jacJsx("svg", {"onClick": e => {
        props.setSelectedRoles(props.selectedRoles.filter(i => {
          return i !== role;
        }));
      }, "className": "w-4 h-4 hover:scale-110 transition-transform", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M6 18L18 6M6 6l12 12"}, [])])]);
    })])]), __jacJsx("div", {}, [__jacJsx("div", {"className": "text-gray-400 text-sm mb-2"}, ["Available Roles"]), __jacJsx("div", {"className": "flex flex-wrap gap-2 overflow-y-auto  md:max-h-[25vh]"}, [props.roles.map(role => {
      let isSelected = props.selectedRoles.includes(role);
      if (isSelected === false) {
        return __jacJsx("div", {"key": role, "onClick": e => {
          let newSelected = props.selectedRoles.concat([role]);
          props.setSelectedRoles(newSelected);
        }, "className": "border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-[#6e11b0] hover:bg-[#0b0b0b]"}, [role]);
      }
      return null;
    })])])]);
  }
  return __jacJsx("div", {"className": "w-full bg-black h-screen grid grid-cols-[100%} md:grid-cols-[45%_55%] relative text-white"}, [__jacJsx("div", {"className": "hidden w-full h-full md:flex justify-center items-center"}, [__jacJsx("div", {"className": "m-auto bg-[#0b0b0b] w-[95%] h-[90%] z-[9999] rounded-[10px] flex flex-col justify-center items-center overflow-hidden"}, [steps.map(step => {
    return __jacJsx(Step, {"key": step.id, "step": step, "isActive": currentStep === step.id}, []);
  }), "   "])]), __jacJsx("div", {"className": "w-full h-[95%] my-auto flex justify-center items-center"}, [__jacJsx("div", {"className": "w-[90%] h-[90%] flex flex-col justify-center"}, [__jacJsx("div", {"className": "text-gray-500 uppercase"}, ["Step ", currentStep, " of 4"]), __jacJsx("div", {"className": "w-full md:w-[80%] h-[11px] rounded-[20px] bg-[#0b0b0b] overflow-hidden my-5"}, [__jacJsx("div", {"style": {"height": "100%", "width": progress, "backgroundColor": "#6e11b0", "transition": "0.3s ease", "borderRadius": "20px"}}, [])]), currentStep === 1 && __jacJsx("div", {"className": "h-[60vh]"}, [__jacJsx("div", {"className": "mb-0 font-semibold text-white text-[1.15rem]"}, ["Upload your CV"]), __jacJsx("p", {"className": "text-gray-500 my-0 mt-[10px]"}, ["Let us start by understanding your background"]), __jacJsx("div", {"className": "my-[30px] h-[40vh] w-full md:w-[80%] rounded-[15px] flex flex-col justify-center items-center border-2 border-dashed border-gray-500 bg-[#0b0b0b] md:bg-[#101010ff] hover:border-[#6e11b0] hover:bg-[#0b0b0b] transition-all duration-200"}, [__jacJsx("div", {"className": "w-[55px] aspect-square rounded-full bg-black flex items-center justify-center mb-[15px]"}, [__jacJsx(CloudUpload, {"className": "text-[0.75rem] text-[#6e11b0]"}, [])]), __jacJsx("p", {"className": "text-gray-500 my-0 my-5 text-[.9em]"}, ["Supported formats: PDF, DOC, DOCX (Max 5MB)"]), __jacJsx("div", {}, []), __jacJsx("div", {"className": "w-auto px-6 py-4 border-none rounded-lg bg-[#6e11b0] text-white font-semibold text-sm cursor-pointer transition-all duration-200 mt-[10px] shadow-[0_0_20px_rgba(110,17,176,0.2)]"}, ["Upload from Computer"])])]), currentStep === 2 && __jacJsx(Skills, {"interests": devSkills, "selectedInterests": selectedInterests, "setSelectedInterests": setSelectedInterests}, []), currentStep === 3 && __jacJsx(Roles, {"roles": devRoles, "selectedRoles": selectedRoles, "setSelectedRoles": setSelectedRoles}, []), currentStep === 4 && __jacJsx("div", {"className": "h-[60vh] flex flex-col justify-center items-center text-center"}, [__jacJsx("div", {"className": "mb-0 font-semibold text-white text-[2rem] mb-4"}, ["You're All Set! 🎉"]), __jacJsx("p", {"className": "text-gray-400 text-lg max-w-[500px] mb-8"}, ["Your personalized career roadmap is ready. We've analyzed your skills, mapped them to your target roles, and created a custom learning path just for you."]), __jacJsx("div", {"className": "flex flex-col gap-4 mb-8"}, [__jacJsx("div", {"className": "flex items-center gap-3 text-gray-300"}, [__jacJsx("div", {"className": "w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center"}, [__jacJsx("svg", {"className": "w-4 h-4 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M5 13l4 4L19 7"}, [])])]), __jacJsx("span", {}, ["Skills analyzed and mapped"])]), __jacJsx("div", {"className": "flex items-center gap-3 text-gray-300"}, [__jacJsx("div", {"className": "w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center"}, [__jacJsx("svg", {"className": "w-4 h-4 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M5 13l4 4L19 7"}, [])])]), __jacJsx("span", {}, ["Career goals identified"])]), __jacJsx("div", {"className": "flex items-center gap-3 text-gray-300"}, [__jacJsx("div", {"className": "w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center"}, [__jacJsx("svg", {"className": "w-4 h-4 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M5 13l4 4L19 7"}, [])])]), __jacJsx("span", {}, ["Personalized roadmap generated"])])]), __jacJsx("p", {"className": "text-gray-500 text-sm mt-6"}, ["Ready to start your career transformation?"])]), __jacJsx("div", {"className": "flex flex-row gap-[25px] items-center"}, [currentStep > 1 && __jacJsx("div", {"onClick": e => {
    setCurrentStep(currentStep - 1);
  }, "className": "flex flex-row items-center cursor-pointer"}, [" ", __jacJsx(ChevronLeft, {}, []), "Back"]), __jacJsx("button", {"type": "button", "onClick": e => {
    if (currentStep < 4) {
      setCurrentStep(currentStep + 1);
    } else {
      navigate("/dashboard");
    }
  }, "className": "w-[180px] bg-[#6e11b0] text-white border-none px-10 py-4 rounded-[5px] cursor-pointer text-base transition-transform duration-200 hover:translate-y-1"}, [currentStep === 4 ? "Get Started" : "Next"])])])])]);
}
export { Onboarding };
