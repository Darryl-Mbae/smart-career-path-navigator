import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { useState, useEffect, useRef } from "react";
import ReactMarkdown from "react-markdown";
import { Mail, Bubbles, LogOut, Puzzle, Briefcase, Map, Send } from "lucide-react";
import jaseciImg from "@jac-client/assets/images/jaseci.webp";
import { useNavigate, jacIsLoggedIn } from "@jac-client/utils";
import { base64ToFileBytes } from "../fileutils.js";
function Dashboard() {
  let [sidebarOpen, setSidebarOpen] = useState(false);
  let [profileOpen, setProfileOpen] = useState(false);
  let [activeLink, setActiveLink] = useState("dashboard");
  let [selectedSkills, setSelectedSkills] = useState([]);
  let [selectedRoles, setSelectedRoles] = useState([]);
  let [userDetails, setUserDetails] = useState([]);
  let [skills, setSkills] = useState([]);
  let [userRoles, setUserRoles] = useState([]);
  let [isLoading, setIsLoading] = useState(false);
  let [userSkillgap, setUserSkillGap] = useState([]);
  let [roadmapData, setRoadmapData] = useState([]);
  let [roadmapMarkdown, setRoadmapMarkdown] = useState("");
  let [notifications, setNotifications] = useState([{id: 1, "key": "message", titFle: "New message from Jane", description: "Hey, just wanted to follow up on our meeting yesterday.", time: "2 hours ago", read: false}, {id: 2, "key": "event", title: "Upcoming event", description: "Team meeting scheduled for Friday at 2pm.", time: "1 day ago", read: false}, {id: 3, "key": "success", title: "Task completed", description: "You completed the \"Update website content\" task.", time: "3 days ago", read: true}, {id: 4, "key": "warning", title: "Account suspended", description: "Your account has been suspended due to a billing issue.", time: "1 week ago", read: true}]);
  let [selectedNotification, setSelectedNotification] = useState(null);
  let unreadCount = notifications.filter(n => {
    return n.read === false;
  }).length;
  let navigate = useNavigate();
  let baseLinkClasses = "flex items-center gap-3 px-4 py-3 rounded-lg transition-all cursor-pointer ";
  let dashboardClasses = activeLink === "dashboard" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  let notificationsClasses = activeLink === "notifications" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  let skillsClasses = activeLink === "skills" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  let rolesClasses = activeLink === "roles" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  let roadmapClasses = activeLink === "roadmap" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  let ariseaiClasses = activeLink === "ariseai" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  let devRoles = ["Frontend Developer", "Backend Developer", "Fullstack Developer", "Mobile Developer", "DevOps Engineer", "UI/UX Designer", "Data Scientist", "Machine Learning Engineer"];
  async function getUserDetails() {
    try {
      let result = await __jacSpawn("get_user_details", "", {});
      let profile = await __jacSpawn("get_user_profile", "", {});
      let data = profile.reports[0].body.skills;
      let skillObjects = data.map(skill => {
        return {name: skill.name, description: skill.description};
      });
      setSelectedSkills(skillObjects);
      setUserDetails(result.reports[0].body);
    } catch (err) {
      console.log(err);
    }
  }
  async function getSkillGap() {
    try {
      let data = await __jacSpawn("get_user_target_roles", "", {});
      let roles = data.reports[0].body.roles;
      setUserRoles(roles);
      setSelectedRoles(roles.map(role => {
        return role.title;
      }));
      for (const role of roles) {
        let result = await __jacSpawn("retrieve_skill_gaps", "", {"role_title": role.title});
        setUserSkillGap(userSkillgap.concat(result.result.gaps));
        let roadmap = await __jacSpawn("get_road_map", "", {"role_title": role.title});
        setRoadmapData(roadmap.reports);
      }
    } catch (err) {
      console.log(err);
    }
  }
  useEffect(() => {
    getUserDetails();
    getSkillGap();
  }, []);
  function LoadingDots() {
    return __jacJsx("div", {"style": {"display": "flex", "justifyContent": "center", "alignItems": "center", "gap": "6px", "height": "20px"}}, [__jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, [])]);
  }
  function handleSaveSkills() {
    saveSkills();
  }
  async function saveSkills() {
    setIsLoading(true);
    try {
      let result = await __jacSpawn("update_user_profile", "", {"updated_skills": selectedSkills});
      if (result) {
        setIsLoading(false);
      }
    } catch (err) {
      console.log(err);
    }
  }
  function DashSideBar() {
    return __jacJsx("div", {"className": "hidden md:flex md:w-64 bg-[#0b0b0b] h-screen flex-col border-r border-gray-800 fixed left-0 top-0"}, [__jacJsx("div", {"className": "p-6"}, [__jacJsx("div", {"className": "text-xl font-semibold text-white"}, ["Arise"])]), __jacJsx("nav", {"className": "flex-1 p-4 overflow-y-auto"}, [__jacJsx("div", {"className": "mb-6"}, [__jacJsx("div", {"className": "text-gray-500 text-xs uppercase font-semibold my-2 px-4 mb-4"}, ["Main"]), __jacJsx("ul", {"className": "list-none p-0 m-0 ml-[8px]"}, [__jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("dashboard");
    }, "className": baseLinkClasses + dashboardClasses}, [__jacJsx("span", {}, ["Dashboard"])])]), __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("roadmap");
    }, "className": baseLinkClasses + roadmapClasses}, [__jacJsx("span", {}, ["My Roadmap"])])]), __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("ariseai");
    }, "className": baseLinkClasses + ariseaiClasses}, [__jacJsx("span", {}, ["Arise AI"])])]), " ", __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("notifications");
    }, "className": baseLinkClasses + notificationsClasses}, [__jacJsx("span", {"className": "flex items-center justify-between w-full"}, [__jacJsx("span", {}, ["Notifications"]), unreadCount > 0 && __jacJsx("span", {"className": "ml-auto bg-primary text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center"}, [unreadCount])])])])])]), __jacJsx("div", {}, [__jacJsx("div", {"className": "text-gray-500 text-xs uppercase font-semibold m-y2 px-4 mb-4"}, ["Actions"]), __jacJsx("ul", {"className": "list-none p-0 m-0 ml-[8px]"}, [__jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("skills");
    }, "className": baseLinkClasses + skillsClasses}, [__jacJsx("span", {}, ["Skills"])])]), __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("roles");
    }, "className": baseLinkClasses + rolesClasses}, [__jacJsx("span", {}, ["Roles"])])])])])]), __jacJsx("div", {"className": "p-4 "}, [__jacJsx("div", {"className": "flex items-center gap-3 px-4 py-3 text-red-400"}, [__jacJsx(LogOut, {}, []), __jacJsx("div", {"className": "text-sm text-red-400 font-medium"}, ["Logout"])])])]);
  }
  function MobileDashSideBar() {
    let baseClasses = "fixed top-0 left-0 bg-[#0b0b0b] h-screen w-[80%] max-w-[300px] transform transition-transform duration-300 ease-in-out z-[100000] flex flex-col border-r border-gray-800";
    let positionClass = sidebarOpen ? "translate-x-0" : "-translate-x-full";
    return __jacJsx("div", {"className": baseClasses + " " + positionClass}, [__jacJsx("div", {"className": "p-6 border-b border-gray-800 flex items-center justify-between"}, [__jacJsx("div", {"className": "text-xl font-semibold text-white"}, ["Arise"]), __jacJsx("button", {"onClick": e => {
      setSidebarOpen(false);
    }, "className": "text-gray-400 hover:text-white transition-colors bg-transparent border-none cursor-pointer"}, [__jacJsx("svg", {"className": "w-6 h-6", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M6 18L18 6M6 6l12 12"}, [])])])]), __jacJsx("nav", {"className": "flex-1 p-4 overflow-y-auto"}, [__jacJsx("div", {"className": "mb-6"}, [__jacJsx("div", {"className": "text-gray-500 text-xs uppercase font-semibold mb-2 px-4"}, ["Main"]), __jacJsx("ul", {"className": "list-none p-0 m-0  ml-[8px]"}, [__jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("dashboard");
      setSidebarOpen(false);
    }, "className": baseLinkClasses + dashboardClasses}, [__jacJsx("span", {}, ["Dashboard"])])]), __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("roadmap");
      setSidebarOpen(false);
    }, "className": baseLinkClasses + roadmapClasses}, [__jacJsx("span", {}, ["My Roadmap"])])]), __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("ariseai");
      setSidebarOpen(false);
    }, "className": baseLinkClasses + ariseaiClasses}, [__jacJsx("span", {}, ["Arise AI"])])]), __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("notifications");
      setSidebarOpen(false);
    }, "className": baseLinkClasses + notificationsClasses}, [__jacJsx("span", {"className": "flex items-center justify-between w-full"}, [__jacJsx("span", {}, ["Notifications"]), unreadCount > 0 && __jacJsx("span", {"className": "ml-auto bg-primary text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center"}, [unreadCount])])])])])]), __jacJsx("div", {}, [__jacJsx("div", {"className": "text-gray-500 text-xs uppercase font-semibold mb-2 px-4"}, ["Actions"]), __jacJsx("ul", {"className": "list-none p-0 m-0  ml-[8px]"}, [__jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("skills");
      setSidebarOpen(false);
    }, "className": baseLinkClasses + skillsClasses}, [__jacJsx("span", {}, ["Skills"])])]), __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("roles");
      setSidebarOpen(false);
    }, "className": baseLinkClasses + rolesClasses}, [__jacJsx("span", {}, ["Roles"])])])])])]), __jacJsx("div", {"className": "p-4 border-t border-gray-800"}, [__jacJsx("div", {"className": "flex items-center gap-3 px-4 py-3"}, [__jacJsx("div", {"className": "w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white font-semibold"}, [userDetails.full_name ? userDetails.full_name[0] : "U"]), __jacJsx("div", {"className": "flex-1"}, [__jacJsx("div", {"className": "text-white text-sm font-medium"}, [userDetails.full_name ? userDetails.full_name : "Guest"]), __jacJsx("div", {"className": "text-gray-400 text-xs"}, [userDetails.email ? userDetails.email : ""])])])])]);
  }
  console.log(userSkillgap[0]);
  function ProfilePanel() {
    return __jacJsx("div", {"className": "hidden lg:block lg:w-80 bg-[#0b0b0b] h-screen border-l border-gray-800 p-6"}, [__jacJsx("div", {"className": "flex flex-col items-center mb-6"}, [__jacJsx("div", {"className": "w-20 h-20 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-2xl mb-4"}, [userDetails.full_name ? userDetails.full_name[0] : "U"]), __jacJsx("div", {"className": "text-white font-medium"}, [userDetails.full_name ? userDetails.full_name : "Guest"]), __jacJsx("div", {"className": "text-gray-400 text-sm"}, [userDetails.email ? userDetails.email : ""])]), userSkillgap.length > 0 ? __jacJsx("div", {}, [userSkillgap[0].skills ? __jacJsx(null, {}, [__jacJsx("h3", {"className": "mt-4 text-base font-normal text-gray-300 mb-6"}, ["Skills Gap Analysis"]), userSkillgap[0].skills.slice(0, 3).map(skillgap => {
      return __jacJsx(InsightContent, {"key": skillgap.id, "skill": skillgap.name}, []);
    })]) : "", userSkillgap[0].certifications ? __jacJsx(null, {}, [__jacJsx("h3", {"className": "mt-4 text-base font-normal text-gray-300 mb-6"}, ["Certification recommendations"]), userSkillgap[0].certifications.slice(0, 2).map(cert => {
      return __jacJsx(InsightContent, {"key": cert._jac_id, "skill": cert.title}, []);
    })]) : ""]) : "", __jacJsx("div", {}, [__jacJsx("h3", {"className": "mt-4 text-base font-normal text-gray-300 mb-4"}, ["My CV"]), __jacJsx("div", {"className": "w-full flex flex-col gap-4"}, [__jacJsx("div", {"onClick": () => {
      console.log("Open CV clicked");
    }, "className": "flex items-start gap-3 p-3 bg-[black] rounded-lg hover:bg-[#1a1a1a] transition-colors cursor-pointer"}, [__jacJsx("div", {"className": "w-12 h-12 bg-red-500/10 rounded-lg flex items-center justify-center flex-shrink-0"}, [__jacJsx("svg", {"className": "w-6 h-6 text-red-500", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"}, [])])]), __jacJsx("div", {"className": "flex-1 min-w-0"}, [__jacJsx("div", {"className": "text-white font-medium text-sm mb-1 truncate"}, ["Ven_CV_25.pdf"]), __jacJsx("div", {"className": "text-gray-500 text-xs"}, ["Last updated: Dec 10, 2025"])])])])])]);
  }
  function MobileProfilePanel() {
    let baseClasses = "fixed top-0 right-0 bg-[#0b0b0b] h-screen w-[80%] max-w-[300px] transform transition-transform duration-300 ease-in-out z-[100000] border-l border-gray-800 p-6 overflow-y-auto";
    let positionClass = profileOpen ? "translate-x-0" : "translate-x-full";
    return __jacJsx("div", {"className": baseClasses + " " + positionClass}, [__jacJsx("div", {"className": "flex items-center justify-between mb-6"}, [__jacJsx("h3", {"className": "text-white font-semibold text-lg"}, ["Profile"]), __jacJsx("button", {"onClick": e => {
      setProfileOpen(false);
    }, "className": "text-gray-400 hover:text-white transition-colors bg-transparent border-none cursor-pointer"}, [__jacJsx("svg", {"className": "w-6 h-6", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M6 18L18 6M6 6l12 12"}, [])])])]), __jacJsx("div", {"className": "flex flex-col items-center mb-6"}, [__jacJsx("div", {"className": "w-20 h-20 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-2xl mb-4"}, ["U"]), __jacJsx("div", {"className": "text-white font-medium"}, ["User Name"]), __jacJsx("div", {"className": "text-gray-400 text-sm"}, ["user@email.com"])])]);
  }
  function DashHeader() {
    return __jacJsx("div", {"className": "lg:hidden fixed top-0 left-0 right-0 bg-[#0b0b0b] border-b border-gray-800 p-4 flex items-center justify-between z-[1000]"}, [__jacJsx("button", {"onClick": e => {
      setSidebarOpen(true);
    }, "className": "text-white bg-transparent border-none cursor-pointer"}, [__jacJsx("svg", {"className": "w-6 h-6", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M4 6h16M4 12h16M4 18h16"}, [])])]), __jacJsx("div", {"className": "text-xl font-semibold text-white"}, ["Arise"]), __jacJsx("button", {"onClick": e => {
      setProfileOpen(true);
    }, "className": "w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-sm border-none cursor-pointer"}, ["U"])]);
  }
  function SelectionManager(props) {
    let [inputValue, setInputValue] = useState("");
    return __jacJsx("div", {}, [__jacJsx("div", {"className": "flex items-center justify-between mb-6"}, [__jacJsx("div", {}, []), __jacJsx("button", {"onClick": props.onSave, "className": "px-6 py-3 bg-primary text-white rounded-lg hover:bg-opacity-80 transition-all border-none cursor-pointer font-semibold"}, [isLoading ? LoadingDots() : "Save Changes"])]), __jacJsx("div", {"className": "rounded-lg"}, [__jacJsx("div", {"className": "mb-0 font-semibold text-white text-lg mb-2"}, [props.title]), __jacJsx("p", {"className": "text-gray-400 text-sm mb-6"}, [props.description]), __jacJsx("div", {"className": "relative mb-6"}, [__jacJsx("input", {"type": "text", "placeholder": props.placeholder, "value": inputValue, "onChange": e => {
      setInputValue(e.target.value);
    }, "onKeyDown": e => {
      if (e.key === "Enter" && inputValue.trim() !== "") {
        let alreadySelected = props.selectedItems.some(s => {
          return s.name === inputValue.trim();
        });
        if (alreadySelected === false) {
          let newSelected = props.selectedItems.concat([{name: inputValue.trim(), description: ""}]);
          props.setSelectedItems(newSelected);
        }
        setInputValue("");
      }
    }, "className": "w-full md:w-[70%] px-4 py-3 pl-10 bg-[#0b0b0b] border border-gray-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-primary transition-colors"}, []), __jacJsx("svg", {"className": "absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"}, [])])]), props.selectedItems.length > 0 && __jacJsx("div", {"className": "mb-6"}, [__jacJsx("div", {"className": "text-gray-400 text-sm mb-2"}, [props.selectedLabel]), __jacJsx("div", {"className": "flex flex-wrap gap-2"}, [props.selectedItems.map(item => {
      return __jacJsx("div", {"key": item, "className": "bg-primary text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer flex items-center gap-2 hover:bg-opacity-80 transition-all"}, [item.name, __jacJsx("svg", {"onClick": e => {
        props.setSelectedItems(props.selectedItems.filter(i => {
          return i.name !== item.name;
        }));
      }, "className": "w-4 h-4 hover:scale-110 transition-transform", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M6 18L18 6M6 6l12 12"}, [])])]);
    })])]), !props.availableItems === "none" ? __jacJsx("div", {"className": "w-full md:w-[80%]"}, [__jacJsx("div", {"className": "text-gray-400 text-sm mb-2"}, [props.availableLabel]), __jacJsx("div", {"className": "flex flex-wrap gap-2 overflow-y-auto max-h-[40vh]"}, [props.availableItems.map(item => {
      let isSelected = props.selectedItems.includes(item);
      if (isSelected === false) {
        return __jacJsx("div", {"key": item, "onClick": e => {
          let newSelected = props.selectedItems.concat([item]);
          props.setSelectedItems(newSelected);
        }, "className": "border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-primary hover:bg-[#0b0b0b]"}, [item]);
      }
      return null;
    })])]) : ""])]);
  }
  function QuickActionCard(props) {
    let iconBg = props.color === "blue" ? "bg-blue-900/15" : props.color === "purple" ? "bg-purple-900/15" : props.color === "green" ? "bg-green-900/15" : "bg-gray-900";
    let iconColor = props.color === "blue" ? "text-blue-400" : props.color === "purple" ? "text-purple-400" : props.color === "green" ? "text-green-400" : "text-gray-400";
    return __jacJsx("div", {"onClick": props.onClick, "className": "border border-gray-300/20 rounded-md p-4 hover:border-primary transition-all cursor-pointer group"}, [__jacJsx("div", {"className": "flex items-start gap-4"}, [__jacJsx("div", {"className": iconBg + " w-12 h-12 rounded-lg flex items-center justify-center flex-shrink-0  transition-transform"}, [__jacJsx("div", {"className": iconColor}, [props.icon])]), __jacJsx("div", {"className": "flex-1"}, [__jacJsx("h3", {"className": "text-white font-semibold text-base mb-1"}, [props.title]), __jacJsx("p", {"className": "text-gray-400 text-sm"}, [props.description])])])]);
  }
  function DashContent() {
    return __jacJsx("div", {"className": "flex-1 p-6 md:p-8"}, [activeLink === "dashboard" && __jacJsx("div", {}, [__jacJsx("h1", {"className": "text-2xl md:text-3xl font-bold text-white mb-6"}, ["Welcome Back!"]), __jacJsx("div", {"className": "grid grid-cols-1 md:grid-cols-[72%_28%] gap-4 md:gap-1"}, [__jacJsx("div", {"className": "w-[98%] h-[35vh] bg-gradient-to-br from-purple-600 to-blue-500 rounded-2xl p-8 flex flex-col justify-between relative overflow-hidden"}, [__jacJsx("div", {"className": "absolute top-0 right-0 w-64 h-64 bg-white opacity-5 rounded-full blur-3xl"}, []), __jacJsx("div", {"className": "absolute bottom-0 right-20 w-40 h-40 bg-white opacity-5 rounded-full blur-2xl"}, []), __jacJsx("div", {"className": "relative z-10"}, [__jacJsx("div", {"className": "text-white text-xs uppercase tracking-wider font-semibold mb-3 opacity-90"}, ["Online Course"]), __jacJsx("h2", {"className": "text-white text-2xl md:text-3xl font-bold leading-tight mb-6"}, ["Sharpen Your Skills with", __jacJsx("br", {}, []), "Professional Online Courses"])]), __jacJsx("div", {"className": "relative z-10"}, [__jacJsx("button", {"onClick": () => {
      let query = userRoles.length > 0 ? userRoles[0].title : "";
      let url = `https://www.udemy.com/courses/search/?src=ukw&q=${query}`;
      window.open(url, "_blank");
    }, "className": "bg-black text-white pl-8 pr-3 py-3 rounded-full font-semibold flex items-center gap-3 hover:bg-gray-900 transition-all hover:translate-x-1 shadow-lg"}, [__jacJsx("span", {}, ["Join Now"]), __jacJsx("div", {"className": "w-6 h-6 bg-white rounded-full flex items-center justify-center"}, [__jacJsx("svg", {"className": "w-3 h-3 text-black", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 3, "d": "M9 5l7 7-7 7"}, [])])])])])]), __jacJsx("div", {"className": "relative h-[35vh] border border-gray-300/30 rounded-lg overflow-hidden"}, [__jacJsx("img", {"src": jaseciImg, "alt": "jaseci", "className": "absolute inset-0 w-full h-full object-cover z-0"}, []), __jacJsx("div", {"className": "relative z-10 flex h-full w-full"}, [__jacJsx("div", {"className": "absolute text-xs top-[10px] right-[10px] rounded-md bg-orange-500 text-white px-3 py-2"}, ["Trending"]), __jacJsx("button", {"onClick": () => {
      window.open("https://docs.jaseci.org/learn/tour/", "_blank");
    }, "className": "cursor-pointer absolute bottom-[15px] left-1/2 -translate-x-1/2 bg-orange-500 text-white rounded-md px-6 py-2 hover:bg-orange-600 transition-colors font-medium w-[90%]"}, ["Learn Jaseci"]), "                               "])])]), __jacJsx("div", {}, [__jacJsx("h3", {"className": "mt-4 text-base font-normal text-gray-300 mb-6"}, ["Quick Actions"]), __jacJsx("div", {"className": "grid grid-cols-1 md:grid-cols-3 gap-4"}, [__jacJsx(QuickActionCard, {"color": "blue", "title": "Skills", "description": "View your current skillset", "icon": __jacJsx(Puzzle, {"className": "w-6 h-6"}, []), "onClick": e => {
      setActiveLink("skills");
    }}, []), __jacJsx(QuickActionCard, {"color": "purple", "title": "Roles", "description": "Targeted career roles", "icon": __jacJsx(Briefcase, {"className": "w-6 h-6"}, []), "onClick": e => {
      setActiveLink("roles");
    }}, []), __jacJsx(QuickActionCard, {"color": "green", "title": "Arise AI", "description": "Learn with AI", "icon": __jacJsx(Bubbles, {"className": "w-6 h-6"}, []), "onClick": e => {
      setActiveLink("ariseai");
    }}, [])])]), __jacJsx("div", {}, [__jacJsx("h3", {"className": "mt-4 text-base font-normal text-gray-300 mb-6"}, ["My Roadmaps"]), __jacJsx("div", {"className": "grid grid-cols-1 md:grid-cols-3 gap-4"}, [roadmapData.map(roadmap => {
      return __jacJsx(RoadmapContent, {"key": roadmap.id, "roadmap": roadmap.body.role_title, "markdown": roadmap.body.learning_path}, []);
    })])])]), activeLink === "notifications" && __jacJsx("div", {}, [selectedNotification ? __jacJsx("div", {}, [__jacJsx("button", {"onClick": e => {
      setSelectedNotification(null);
    }, "className": "flex items-center gap-2 text-gray-400 hover:text-white transition-colors mb-6 bg-transparent border-none cursor-pointer"}, [__jacJsx("svg", {"className": "w-5 h-5", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M15 19l-7-7 7-7"}, [])]), __jacJsx("span", {}, ["Back to notifications"])]), __jacJsx("div", {"className": "rounded-lg p-8"}, [__jacJsx("div", {"className": "flex items-start gap-4 mb-6 pb-6 border-b border-gray-800"}, [__jacJsx("div", {"className": "w-16 h-16 rounded-full flex items-center justify-center flex-shrink-0 " + selectedNotification.type === "message" ? "bg-orange-500" : selectedNotification.type === "event" ? "bg-blue-500" : selectedNotification.type === "success" ? "bg-green-500" : "bg-yellow-500"}, [selectedNotification.type === "message" && __jacJsx("svg", {"className": "w-8 h-8 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"}, [])]), selectedNotification.type === "event" && __jacJsx("svg", {"className": "w-8 h-8 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"}, [])]), selectedNotification.type === "success" && __jacJsx("svg", {"className": "w-8 h-8 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M5 13l4 4L19 7"}, [])]), selectedNotification.type === "warning" && __jacJsx("svg", {"className": "w-8 h-8 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"}, [])])]), __jacJsx("div", {"className": "flex-1"}, [__jacJsx("h2", {"className": "text-white text-2xl font-bold mb-2"}, [selectedNotification.title]), __jacJsx("div", {"className": "flex items-center gap-4 text-sm text-gray-400"}, [__jacJsx("span", {}, [selectedNotification.time]), __jacJsx("span", {"className": "w-1 h-1 bg-gray-600 rounded-full"}, []), __jacJsx("span", {"className": "capitalize"}, [selectedNotification.type])])])]), __jacJsx("div", {"className": "text-gray-300 leading-relaxed"}, [__jacJsx("p", {}, [selectedNotification.description])]), __jacJsx("div", {"className": "mt-8 flex gap-3"}, [__jacJsx("button", {"onClick": e => {
      let updatedNotifications = notifications.filter(n => {
        return n.id !== selectedNotification.id;
      });
      setNotifications(updatedNotifications);
      setSelectedNotification(null);
    }, "className": "px-6 py-3 bg-transparent text-red-400 border border-red-400 rounded-lg hover:bg-red-400 hover:text-white transition-all cursor-pointer font-semibold"}, ["Delete"])])])]) : __jacJsx("div", {}, [__jacJsx("div", {"className": "flex items-center justify-between mb-6"}, [__jacJsx("div", {}, [__jacJsx("h1", {"className": "text-2xl md:text-3xl font-bold text-white mb-2"}, ["Notifications"]), __jacJsx("p", {"className": "text-gray-400"}, ["You have ", unreadCount, " new notifications."])]), unreadCount > 0 && __jacJsx("button", {"onClick": e => {
      let updatedNotifications = notifications.map(n => {
        return {id: n.id, "key": n.type, title: n.title, description: n.description, time: n.time, read: true};
      });
      setNotifications(updatedNotifications);
    }, "className": "px-6 py-3 bg-[#101010ff] text-white rounded-lg hover:bg-[#1a1a1a] transition-all border border-gray-700 cursor-pointer font-semibold"}, ["Mark all as read"])]), __jacJsx("div", {"className": "rounded-lg"}, [notifications.map(notification => {
      let iconBg = "bg-none";
      let isUnread = notification.read === false;
      return __jacJsx("div", {"key": notification.id, "className": "border-b border-gray-800 last:border-b-0 p-6 hover:bg-[#0b0b0b] transition-all cursor-pointer", "onClick": e => {
        setSelectedNotification(notification);
        if (isUnread) {
          let updatedNotifications = notifications.map(n => {
            if (n.id === notification.id) {
              return {id: n.id, "key": n.type, title: n.title, description: n.description, time: n.time, read: true};
            }
            return n;
          });
          setNotifications(updatedNotifications);
        }
      }}, [__jacJsx("div", {"className": "flex items-start gap-4"}, [__jacJsx("div", {"className": "w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0 " + iconBg}, [notification.type === "message" && __jacJsx("svg", {"className": "w-6 h-6 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"}, [])]), notification.type === "event" && __jacJsx("svg", {"className": "w-6 h-6 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"}, [])]), notification.type === "success" && __jacJsx("svg", {"className": "w-6 h-6 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M5 13l4 4L19 7"}, [])]), notification.type === "warning" && __jacJsx("svg", {"className": "w-6 h-6 text-white", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"}, [])])]), __jacJsx("div", {"className": "flex-1 min-w-0"}, [__jacJsx("div", {"className": "flex items-start justify-between gap-4 mb-1"}, [__jacJsx("h3", {"className": "text-white font-semibold flex items-center gap-2"}, [notification.title, isUnread && __jacJsx("span", {"className": "w-2 h-2 bg-primary rounded-full"}, [])]), __jacJsx("span", {"className": "text-gray-400 text-sm flex-shrink-0"}, [notification.time])]), __jacJsx("p", {"className": "text-gray-400 text-sm line-clamp-2"}, [notification.description])])])]);
    })])])]), activeLink === "skills" && __jacJsx(SelectionManager, {"title": "Select Your Skills", "description": "Choose or add your skills", "placeholder": "Search or type a skill and press Enter", "selectedLabel": "Selected Skills", "availableLabel": "Available Skills", "availableItems": "none", "selectedItems": selectedSkills, "setSelectedItems": setSelectedSkills, "onSave": handleSaveSkills}, []), activeLink === "roles" && __jacJsx(SelectionManager, {"title": "Select Your Roles", "description": "Choose or add your target roles", "placeholder": "Search or type a role and press Enter", "selectedLabel": "Selected Roles", "availableLabel": "Available Roles", "availableItems": "none", "selectedItems": selectedRoles, "setSelectedItems": setSelectedRoles, "onSave": () => {}}, []), activeLink === "roadmap" && __jacJsx("div", {}, [__jacJsx("h1", {"className": "text-2xl md:text-3xl font-bold text-white mb-6"}, ["My Roadmap"]), __jacJsx("p", {"className": "text-gray-400"}, ["Your personalized learning path"]), __jacJsx("div", {"className": "grid grid-cols-1 md:grid-cols-3 gap-4"}, [roadmapData.map(roadmap => {
      return __jacJsx(RoadmapContent, {"key": roadmap.id, "roadmap": roadmap.body.role_title, "markdown": roadmap.body.learning_path}, []);
    })])]), activeLink === "roadmap-inside" && __jacJsx("div", {}, [__jacJsx("button", {"onClick": e => {
      setActiveLink("roadmap");
    }, "className": "flex items-center gap-2 text-gray-400 hover:text-white transition-colors mb-6 bg-transparent border-none cursor-pointer"}, [__jacJsx("svg", {"className": "w-5 h-5", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M15 19l-7-7 7-7"}, [])]), __jacJsx("span", {}, ["Back to Roadmaps"])]), __jacJsx("div", {"className": "rounded-lg p-8"}, [__jacJsx("div", {"className": "max-w-4xl mx-auto px-6 py-8 text-white"}, [__jacJsx(ReactMarkdown, {"components": {h1: props => {
      return __jacJsx("h1", {"className": "text-4xl font-bold mb-6 pb-2 border-b border-gray-700"}, [props.children]);
    }, h2: props => {
      return __jacJsx("h2", {"className": "text-3xl font-semibold mt-8 mb-4 pb-2 border-b border-gray-700"}, [props.children]);
    }, h3: props => {
      return __jacJsx("h3", {"className": "text-2xl font-semibold mt-6 mb-3"}, [props.children]);
    }, h4: props => {
      return __jacJsx("h4", {"className": "text-xl font-semibold mt-4 mb-2"}, [props.children]);
    }, p: props => {
      return __jacJsx("p", {"className": "mb-4 leading-7 text-gray-200"}, [props.children]);
    }, ul: props => {
      return __jacJsx("ul", {"className": "list-disc ml-6 mb-4 space-y-2"}, [props.children]);
    }, ol: props => {
      return __jacJsx("ol", {"className": "list-decimal ml-6 mb-4 space-y-2"}, [props.children]);
    }, li: props => {
      return __jacJsx("li", {"className": "leading-7 text-gray-200"}, [props.children]);
    }, strong: props => {
      return __jacJsx("strong", {"className": "font-semibold text-white"}, [props.children]);
    }, em: props => {
      return __jacJsx("em", {"className": "italic text-gray-300"}, [props.children]);
    }, code: props => {
      return __jacJsx("code", {"className": "bg-gray-800 text-pink-400 px-1.5 py-0.5 rounded text-sm font-mono"}, [props.children]);
    }, pre: props => {
      return __jacJsx("pre", {"className": "bg-gray-900 p-4 rounded-lg overflow-x-auto mb-4 border border-gray-700"}, [props.children]);
    }, blockquote: props => {
      return __jacJsx("blockquote", {"className": "border-l-4 border-gray-600 pl-4 italic text-gray-400 my-4"}, [props.children]);
    }, a: props => {
      return __jacJsx("a", {"className": "text-blue-400 hover:text-blue-300 underline", "href": props.href}, [props.children]);
    }}}, [roadmapMarkdown])])])]), activeLink === "ariseai" && __jacJsx(ChatBot, {}, [])]);
  }
  function ChatBot() {
    let [messages, setMessages] = useState([{id: 1, "key": "bot", content: "Hello! I\\'m Arise AI. How can I help you with your learning journey today?", timestamp: "12:00"}]);
    let [inputValue, setInputValue] = useState("");
    let [isTyping, setIsTyping] = useState(false);
    let messagesEndRef = useRef(null);
    function scrollToBottom() {
      messagesEndRef.current.scrollIntoView({behavior: "smooth"});
    }
    useEffect(() => {
      scrollToBottom();
    }, [messages, isTyping]);
    function handleSendMessage() {
      if (inputValue.trim() === "") {
        return;
      }
      let userMessage = {id: messages.length + 1, "key": "user", content: inputValue, timestamp: "12:14"};
      setMessages(prev => {
        return prev.concat([userMessage]);
      });
      setInputValue("");
      setIsTyping(true);
      setTimeout(() => {
        let botResponses = ["That's a great question! Let me help you with that.", "I understand. Here's what I can tell you about that topic.", "Interesting! Based on your skills, I'd recommend focusing on...", "Let me break that down for you step by step.", "That's an excellent area to explore. Here are some resources..."];
        let botMessage = {id: messages.length + 2, "key": "bot", content: botResponses[Math.floor(Math.random() * botResponses.length)], timestamp: "12:65"};
        setMessages(prev => {
          return prev.concat([botMessage]);
        });
        setIsTyping(false);
      }, 2000);
    }
    function TypingIndicator() {
      return __jacJsx("div", {"className": "flex items-start gap-3 mb-4"}, [__jacJsx("div", {"className": "w-8 h-8 rounded-full bg-purple-600 flex items-center justify-center flex-shrink-0"}, [__jacJsx("span", {"className": "text-white text-sm font-semibold"}, ["AI"])]), __jacJsx("div", {"className": "bg-[#1a1a1a] rounded-2xl rounded-tl-sm px-6 py-3 max-w-[80%]"}, [__jacJsx("div", {"style": {"display": "flex", "justifyContent": "center", "alignItems": "center", "gap": "6px", "height": "20px"}}, [__jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, [])])])]);
    }
    return __jacJsx("div", {"className": "flex flex-col h-[calc(100vh-3rem)]"}, [__jacJsx("div", {"className": "mb-12"}, []), __jacJsx("div", {"className": "flex-1 overflow-y-auto mb-4 pr-2 scrollbar-thin scrollbar-thumb-gray-700 scrollbar-track-transparent"}, [messages.map(message => {
      let messageBase = "flex items-start gap-3 mb-4";
      let messageAlign = message.key === "user" ? "flex-row-reverse" : "";
      let avatarBase = "w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0";
      let avatarColor = message.key === "user" ? "bg-purple-600" : "bg-purple-600";
      let bubbleBase = "rounded-2xl px-4 py-3";
      let bubbleStyle = message.key === "user" ? "bg-purple-600 text-white rounded-tr-sm" : "bg-[#1a1a1a] text-gray-100 rounded-tl-sm";
      let timestampBase = "text-xs text-gray-500 mt-1";
      let timestampAlign = message.key === "user" ? "text-right" : "text-left";
      return __jacJsx("div", {"key": message.id, "className": messageBase + " " + messageAlign}, [__jacJsx("div", {"className": avatarBase + " " + avatarColor}, [__jacJsx("span", {"className": "text-white text-sm font-semibold"}, [message.key === "user" ? "U" : "AI"])]), __jacJsx("div", {"className": "flex flex-col max-w-[80%]"}, [__jacJsx("div", {"className": bubbleBase + " " + bubbleStyle}, [__jacJsx("p", {"className": "text-sm leading-relaxed"}, [message.content])]), __jacJsx("span", {"className": timestampBase + " " + timestampAlign}, [message.timestamp])])]);
    }), isTyping ? TypingIndicator() : "", __jacJsx("div", {"ref": messagesEndRef}, [])]), __jacJsx("div", {"className": "border-t border-gray-800 pt-4"}, [__jacJsx("div", {"className": "relative flex items-center gap-2"}, [__jacJsx("input", {"type": "text", "value": inputValue, "onChange": e => {
      setInputValue(e.target.value);
    }, "onKeyPress": e => {
      if (e.key === "Enter" && !e.shiftKey) {
        e.preventDefault();
        handleSendMessage();
      }
    }, "placeholder": "Type your message...", "className": "flex-1  border border-gray-700 rounded-lg px-4 py-3 text-white placeholder-gray-500 focus:outline-none focus:border-purple-600 transition-colors"}, []), __jacJsx("button", {"onClick": e => {
      handleSendMessage();
    }, "disabled": inputValue.trim() === "", "className": "bg-purple-600 text-white p-3 rounded-lg hover:bg-purple-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center"}, [__jacJsx(Send, {"className": "w-5 h-5"}, [])])])])]);
  }
  function RoadmapContent(props) {
    return __jacJsx("div", {"onClick": e => {
      setActiveLink("roadmap-inside");
      setRoadmapMarkdown(props.markdown);
    }, "className": "bg-gradient-to-br from-purple-600 to-blue-500 w-full h-[170px] rounded-[30px] p-[5px] mt-4"}, [__jacJsx("div", {"className": "bg-black h-[88%] rounded-[30px] p-5"}, [__jacJsx(Map, {"className": "w-6 h-6 text-[#6e11b0]"}, []), __jacJsx("div", {"className": "text-white mt-3 capitalize"}, [props.roadmap]), __jacJsx("div", {"className": "text-gray-400 text-sm mt-1 cursor-pointer flex flex-row items-center"}, ["View More"])])]);
  }
  function InsightContent(props) {
    return __jacJsx("div", {}, [__jacJsx("p", {"className": "group font-regular text-[12px] relative block overflow-hidden rounded-lg border border-black bg-black p-2.5 text-neutral-400 no-underline mb-2 hover:border-black hover:text-neutral-100 sm:p-3.5"}, [props.skill])]);
  }
  return __jacJsx("div", {"className": "min-h-screen bg-black"}, [sidebarOpen && __jacJsx("div", {"onClick": e => {
    setSidebarOpen(false);
  }, "className": "fixed inset-0 bg-black bg-opacity-50 z-[99999] lg:hidden"}, []), profileOpen && __jacJsx("div", {"onClick": e => {
    setProfileOpen(false);
  }, "className": "fixed inset-0 bg-black bg-opacity-50 z-[99999] lg:hidden"}, []), __jacJsx(DashSideBar, {}, []), __jacJsx(MobileDashSideBar, {}, []), __jacJsx("div", {"className": "md:ml-64 lg:mr-80 min-h-screen"}, [__jacJsx(DashHeader, {}, []), __jacJsx("div", {"className": "pt-16 lg:pt-0"}, [__jacJsx(DashContent, {}, [])])]), __jacJsx("div", {"className": "hidden lg:block fixed top-0 right-0"}, [__jacJsx(ProfilePanel, {}, [])]), __jacJsx(MobileProfilePanel, {}, [])]);
}
export { Dashboard };
