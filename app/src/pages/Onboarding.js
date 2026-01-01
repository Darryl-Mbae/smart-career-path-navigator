import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { useState, useEffect } from "react";
import { Brain, CloudUpload, Goal, Route as Node, ChevronLeft } from "lucide-react";
import { fileToBase64 } from "../fileutils.js";
import { useNavigate } from "@jac-client/utils";
function Onboarding() {
  let [currentStep, setCurrentStep] = useState(1);
  let [stepCompleted, setStepCompleted] = useState(0);
  let [navbtnHover, setNavBtnHover] = useState("");
  let [progress, setProgress] = useState(25);
  let [resumeHover, setResumeHover] = useState(false);
  let [selectedInterests, setSelectedInterests] = useState([]);
  let [selectedRoles, setSelectedRoles] = useState([]);
  let [suggestedRoles, setSuggestedRoles] = useState([]);
  let [dragActive, setDragActive] = useState(false);
  let [fileName, setFileName] = useState("");
  let [file, setFile] = useState(null);
  let [error, setError] = useState("");
  let [canProceed, setCanProceed] = useState(false);
  let [isLoading, setIsLoading] = useState(false);
  let [showErrorPopup, setShowErrorPopup] = useState(false);
  let [errorMessage, setErrorMessage] = useState("");
  function showError(msg) {
    setErrorMessage(msg);
    setShowErrorPopup(true);
  }
  useEffect(() => {
    if (showErrorPopup) {
      let timer = setTimeout(() => {
        setShowErrorPopup(false);
      }, 3000);
      return () => {
        clearTimeout(timer);
      };
    }
  }, [showErrorPopup]);
  let navigate = useNavigate();
  let devSkills = ["JavaScript", "Python", "React", "Node.js", "TypeScript", "HTML & CSS", "Django", "Flutter", "Git & GitHub", "SQL & Databases", "REST APIs", "GraphQL", "Docker", "Agile & Scrum"];
  let devRoles = ["Frontend Developer", "Backend Developer", "Fullstack Developer", "Mobile Developer", "DevOps Engineer", "UI/UX Designer", "Data Scientist", "Machine Learning Engineer"];
  let loadingMessages = ["Analyzing your CV\u2026", "Extracting skills and experience\u2026", "Identifying career patterns\u2026", "Mapping skills to target roles\u2026", "Detecting skill gaps\u2026", "This could take a few minutes\u2026"];
  let [loadingText, setLoadingText] = useState(loadingMessages[0] || "");
  let [messageIndex, setMessageIndex] = useState(0);
  let [typedText, setTypedText] = useState("");
  useEffect(() => {
    if (isLoading === false) {
      setMessageIndex(0);
      setLoadingText(loadingMessages[0]);
      return;
    }
    let interval = setInterval(() => {
      setMessageIndex(prev => {
        let next = prev + 1 % loadingMessages.length;
        setLoadingText(loadingMessages[next]);
        return next;
      });
    }, 1800);
    return () => {
      clearInterval(interval);
    };
  }, [isLoading]);
  useEffect(() => {
    if (isLoading === false) {
      setTypedText("");
      return;
    }
    if (!loadingText || loadingText.length === 0) {
      return;
    }
    setTypedText("");
    let i = 0;
    let current = loadingText;
    let typing = setInterval(() => {
      if (i >= current.length) {
        clearInterval(typing);
        return;
      }
      setTypedText(prev => {
        return prev + current[i];
      });
      i += 1;
    }, 40);
    return () => {
      clearInterval(typing);
    };
  }, [loadingText, isLoading]);
  useEffect(() => {
    let percent = currentStep / 4 * 100;
    setProgress(percent + "%");
  }, [currentStep]);
  let steps = [{id: 1, title: "Upload Your CV", description: "Let our AI analyze your experience and extract your current skills.", icon: __jacJsx(CloudUpload, {"style": {"fontSize": "0.75rem"}}, []), completed: false}, {id: 2, title: "Review & Update Skills", description: "Confirm AI-detected skills and add any we might have missed.", icon: __jacJsx(Brain, {"style": {"fontSize": "0.75rem"}}, []), completed: false}, {id: 3, title: "Set Career Goals", description: "Choose your target roles, industries, and career aspirations.", icon: __jacJsx(Goal, {"style": {"fontSize": "0.75rem"}}, []), completed: false}, {id: 4, title: "Get Your Roadmap", description: "Explore your personalized learning path and skill gap analysis.", icon: __jacJsx(Node, {"style": {"fontSize": "0.75rem"}}, []), completed: false}];
  function handleFileSelect(e) {
    let pickedFile = e.target.files[0];
    if (pickedFile) {
      setFileName(pickedFile.name);
      setFile(pickedFile);
      setError("");
      setCanProceed(true);
    }
  }
  function handleDragOver(e) {
    e.preventDefault();
    setDragActive(true);
  }
  function handleDragLeave(e) {
    e.preventDefault();
    setDragActive(false);
  }
  function handleDrop(e) {
    e.preventDefault();
    setDragActive(false);
    if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
      let droppedFile = e.dataTransfer.files[0];
      setFileName(droppedFile.name);
      setFile(droppedFile);
      e.dataTransfer.clearData();
      setError("");
      setCanProceed(true);
    }
  }
  async function handleStep1Next() {
    if (!canProceed || !file) {
      return;
    }
    try {
      await __jacSpawn("create_resume_node", "", {});
      let base64Data = await fileToBase64(file);
      let result = await __jacSpawn("upload_resume", "", {"file": base64Data, "name": file.name, "mime": file.type});
      if (!result) {
        console.log("Failed");
        return;
      }
      await __jacSpawn("save_resume", "", {});
      await __jacSpawn("update_resume_upload_status", "", {});
      let user_skills = await __jacSpawn("analyze_cv", "", {});
      if (!user_skills || !user_skills.reports || user_skills.reports.length === 0) {
        console.log("Failed");
        return;
      }
      if (user_skills.reports[0]["status"] !== "Success") {
        showError("Failed to process your CV. Please try again or use a different file.");
        return;
      }
      try {
        let body = "body" in user_skills.reports[0] ? user_skills.reports[0]["body"] : {};
        let detected_skills = "skills" in body ? body["skills"] : [];
        let detected_interests = "interests" in body ? body["interests"] : [];
        let detected_certs = "certifications" in body ? body["certifications"] : [];
        setSelectedInterests(detected_skills);
      } catch (e) {
        console.log(e);
      }
      setCurrentStep(2);
    } catch (err) {
      console.log(err);
    } finally {
      setIsLoading(false);
    }
  }
  async function handleStep2Next() {
    try {
      let result = await __jacSpawn("update_user_profile", "", {"updated_skills": selectedInterests});
      if (result) {
        let rolesReport = await __jacSpawn("generate_role_suggestions", "", {});
        let latestReport = rolesReport.reports[rolesReport.reports.length - 1];
        if (latestReport.status === "Success") {
          setSuggestedRoles(latestReport.body);
          setCurrentStep(3);
        } else {
          showError("Failed to generate role suggestions: " + latestReport.message || "Unknown error");
        }
      } else {
        showError("Failed to save profile. Please try again.");
      }
    } catch (err) {
      showError("An unexpected error occurred: " + err);
    } finally {
      setIsLoading(false);
    }
  }
  async function handleStep3Next() {
    if (selectedRoles === null || selectedRoles.length === 0) {
      showError("Please select at least one role to continue.");
      setIsLoading(false);
      return;
    }
    let finalRoles = [];
    for (const roleTitle of selectedRoles) {
      finalRoles = finalRoles.concat({"title": roleTitle, "description": ""});
    }
    let allSuccessful = true;
    let roleIndex = 0;
    for (const currentRole of finalRoles) {
      roleIndex += 1;
      console.log(`Processing Role ${roleIndex}/${finalRoles.length}:`, currentRole);
      let result = await __jacSpawn("collect_role_requirements", "", {"role_title": currentRole.title});
      console.log("Role requirements collected:");
      console.log(result.reports[0]);
      if (result.reports[0]["status"] === "Success") {
        let requirements_gap = await __jacSpawn("find_skill_and_certification_gaps", "", {"role_title": currentRole.title});
        let requirements_gap_status = requirements_gap.reports[requirements_gap.reports.length - 1]["status"];
        if (requirements_gap_status === "Success") {
          console.log(`Skill Gaps for ${currentRole.title}: `);
          console.log(requirements_gap.reports[requirements_gap.reports.length - 4]);
          let learning_path = await __jacSpawn("recommend_learning_paths", "", {"role_title": currentRole.title});
          console.log(`Learning Path for ${currentRole.title}: `);
          console.log(learning_path.reports[learning_path.reports.length - 1]["body"]["learning_path"]);
        } else {
          allSuccessful = false;
          console.log(`Failed to find skill gaps for ${currentRole.title}`);
        }
      } else {
        allSuccessful = false;
        console.log(`Failed to collect requirements for ${currentRole.title}`);
        setIsLoading(false);
      }
    }
    if (allSuccessful) {
      setCurrentStep(4);
      setIsLoading(false);
    } else {
      console.log("Error");
      return;
      setIsLoading(false);
    }
  }
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
    }, "className": "w-full px-4 py-3 pl-10 bg-[#101010ff] border border-gray-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-[#6e11b0] transition-colors"}, []), __jacJsx("svg", {"className": "absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"}, [])])]), props.selectedInterests.length > 0 && __jacJsx("div", {"className": "mb-6"}, [__jacJsx("div", {"className": "text-gray-400 text-sm mb-2"}, ["Selected Skills"]), __jacJsx("div", {"className": "flex flex-wrap gap-2 max-h-[250px] overflow-y-auto scrollbar-thin scrollbar-thumb-gray-600 scrollbar-track-transparent hover:scrollbar-thumb-gray-500"}, [props.selectedInterests.map(skill => {
      return __jacJsx("div", {"key": skill, "className": "bg-primary text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer flex items-center gap-2 hover:bg-opacity-80 transition-all"}, [skill, __jacJsx("svg", {"onClick": e => {
        props.setSelectedInterests(props.selectedInterests.filter(i => {
          return i !== skill;
        }));
      }, "className": "w-4 h-4 hover:scale-110 transition-transform", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M6 18L18 6M6 6l12 12"}, [])])]);
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
    })])]), __jacJsx("div", {}, [__jacJsx("div", {"className": "text-gray-400 text-sm mb-2"}, ["Available Roles"]), __jacJsx("div", {"className": "flex flex-wrap gap-2 overflow-y-auto md:max-h-[25vh]"}, [props.suggestedRoles.map((role, index) => {
      let isSelected = props.selectedRoles.includes(role.title);
      if (isSelected === false) {
        return __jacJsx("div", {"key": index, "onClick": e => {
          let newSelected = props.selectedRoles.concat([role.title]);
          props.setSelectedRoles(newSelected);
        }, "className": "border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-[#6e11b0] hover:bg-[#0b0b0b]"}, [role.title]);
      }
      return null;
    })])])]);
  }
  function ErrorPopup() {
    if (!showErrorPopup) {
      return null;
    }
    return __jacJsx("div", {"className": "fixed top-10 left-1/2 transform -translate-x-1/2 bg-red-500 text-white px-6 py-4 rounded-lg shadow-xl z-[10000] flex items-center gap-3 animate-in fade-in slide-in-from-top-4 duration-300"}, [__jacJsx("svg", {"className": "w-6 h-6", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"}, [])]), __jacJsx("span", {"className": "font-medium"}, [errorMessage])]);
  }
  function LoadingDots() {
    return __jacJsx("div", {"style": {"display": "flex", "justifyContent": "center", "alignItems": "center", "gap": "6px", "height": "20px"}}, [__jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, [])]);
  }
  return __jacJsx("div", {"className": "w-full bg-black h-screen grid grid-cols-[100%} md:grid-cols-[45%_55%] relative text-white"}, [__jacJsx(ErrorPopup, {}, []), __jacJsx("div", {"className": "hidden w-full h-full md:flex justify-center items-center"}, [__jacJsx("div", {"className": "m-auto bg-[#0b0b0b] w-[95%] h-[90%] z-[9999] rounded-[10px] flex flex-col justify-center items-center overflow-hidden"}, [steps.map(step => {
    return __jacJsx(Step, {"key": step.id, "step": step, "isActive": currentStep === step.id}, []);
  }), "   "])]), __jacJsx("div", {"className": "w-full h-[95%] my-auto flex justify-center items-center"}, [__jacJsx("div", {"className": "w-[90%] h-[90%] flex flex-col justify-center"}, [__jacJsx("div", {"className": "text-gray-500 uppercase"}, ["Step ", currentStep, " of 4"]), __jacJsx("div", {"className": "w-full md:w-[80%] h-[11px] rounded-[20px] bg-[#0b0b0b] overflow-hidden my-5"}, [__jacJsx("div", {"style": {"height": "100%", "width": progress, "backgroundColor": "#6e11b0", "transition": "0.3s ease", "borderRadius": "20px"}}, [])]), currentStep === 1 && __jacJsx("div", {"className": "h-[60vh]"}, [__jacJsx("div", {"className": "mb-0 font-semibold text-white text-[1.15rem]"}, ["Upload your CV"]), __jacJsx("p", {"className": "text-gray-500 my-0 mt-[10px]"}, ["Let us start by understanding your background"]), __jacJsx("div", {"onDragOver": handleDragOver, "onDragLeave": handleDragLeave, "onDrop": handleDrop, "className": "my-[30px] h-[40vh] w-full md:w-[80%] rounded-[15px] flex flex-col justify-center items-center border-2 border-dashed border-gray-500 bg-[#0b0b0b] md:bg-[#101010ff] hover:border-[#6e11b0] hover:bg-[#0b0b0b] transition-all duration-200"}, [__jacJsx("div", {"className": "w-[55px] aspect-square rounded-full bg-black flex items-center justify-center mb-[15px]"}, [__jacJsx(CloudUpload, {"className": "text-[0.75rem] text-[#6e11b0]"}, [])]), __jacJsx("p", {"className": "text-gray-500 my-0 my-5 text-[.9em]"}, ["Supported formats: PDF, DOC, DOCX (Max 5MB)"]), __jacJsx("div", {}, []), __jacJsx("input", {"type": "file", "accept": ".pdf,.doc,.docx", "onChange": handleFileSelect, "className": "hidden", "id": "resumeInput"}, []), __jacJsx("label", {"for": "resumeInput", "className": "w-auto px-6 py-4 border-none rounded-lg bg-[#6e11b0] text-white font-semibold text-sm cursor-pointer transition-all duration-200 mt-[10px] shadow-[0_0_20px_rgba(110,17,176,0.2)]"}, ["Upload from Computer"]), fileName && __jacJsx("p", {"className": "mt-5 text-sm text-white font-medium"}, ["Uploaded: ", fileName])])]), currentStep === 2 && __jacJsx(Skills, {"interests": devSkills, "selectedInterests": selectedInterests, "setSelectedInterests": setSelectedInterests}, []), currentStep === 3 && __jacJsx(Roles, {"suggestedRoles": suggestedRoles, "selectedRoles": selectedRoles, "setSelectedRoles": setSelectedRoles}, []), currentStep === 4 && __jacJsx("div", {"className": "h-[60vh] flex flex-col justify-center items-center text-center"}, [__jacJsx("div", {"className": "mb-0 font-semibold text-white text-[2rem] mb-4"}, ["You're All Set! 🎉"]), __jacJsx("p", {"className": "text-gray-400 text-lg max-w-[500px] mb-8"}, ["Your personalized career roadmap is ready. We've analyzed your skills, mapped them to your target roles, and created a custom learning path just for you."]), __jacJsx("div", {"className": "flex flex-col gap-4 mb-8"}, [__jacJsx("div", {"className": "flex items-center gap-3 text-gray-300"}, [__jacJsx("div", {"className": "w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center"}, [__jacJsx("svg", {"className": "w-4 h-4 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M5 13l4 4L19 7"}, [])])]), __jacJsx("span", {}, ["Skills analyzed and mapped"])]), __jacJsx("div", {"className": "flex items-center gap-3 text-gray-300"}, [__jacJsx("div", {"className": "w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center"}, [__jacJsx("svg", {"className": "w-4 h-4 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M5 13l4 4L19 7"}, [])])]), __jacJsx("span", {}, ["Career goals identified"])]), __jacJsx("div", {"className": "flex items-center gap-3 text-gray-300"}, [__jacJsx("div", {"className": "w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center"}, [__jacJsx("svg", {"className": "w-4 h-4 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M5 13l4 4L19 7"}, [])])]), __jacJsx("span", {}, ["Personalized roadmap generated"])])]), __jacJsx("p", {"className": "text-gray-500 text-sm mt-6"}, ["Ready to start your career transformation?"])]), __jacJsx("div", {"className": "flex flex-row gap-[25px] items-center"}, [currentStep > 1 && __jacJsx("div", {"onClick": e => {
    setCurrentStep(currentStep - 1);
  }, "className": "flex flex-row items-center cursor-pointer"}, [" ", __jacJsx(ChevronLeft, {}, []), "Back"]), __jacJsx("button", {"type": "button", "onClick": e => {
    if (currentStep < 4) {
      setIsLoading(true);
      if (currentStep === 1) {
        handleStep1Next();
      } else if (currentStep === 2) {
        handleStep2Next();
      } else if (currentStep === 3) {
        handleStep3Next();
      }
    } else {
      navigate("/dashboard");
    }
  }, "disabled": isLoading, "className": "w-[180px] bg-[#6e11b0] text-white border-none px-10 py-4 rounded-[5px] cursor-pointer text-base transition-transform duration-200 hover:translate-y-1 disabled:opacity-50 disabled:cursor-not-allowed"}, ["   ", isLoading ? LoadingDots() : currentStep === 4 ? "Get Started" : "Next"]), __jacJsx("p", {"className": "text-sm text-gray-400 animate-pulse transition-opacity duration-500"}, [isLoading && currentStep === 3 ? loadingText : ""]), " "])])])]);
}
export { Onboarding };
