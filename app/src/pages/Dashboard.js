import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { useState, useEffect, useRef } from "react";
import { renderAsync } from "docx-preview";
import ReactMarkdown from "react-markdown";
import { Mail, Bubbles, LogOut, Puzzle, Briefcase, Map, Send, Loader2 } from "lucide-react";
import jaseciImg from "@jac-client/assets/images/jaseci.webp";
import { useNavigate, jacIsLoggedIn, jacLogout } from "@jac-client/utils";
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
  let [selectedCertifications, setSelectedCertifications] = useState([]);
  let [cvPreviewOpen, setCvPreviewOpen] = useState(false);
  let [cvFileBase64, setCvFileBase64] = useState("");
  let [cvFileName, setCvFileName] = useState("");
  let [cvMimeType, setCvMimeType] = useState("");
  let [cvPreviewUrl, setCvPreviewUrl] = useState("");
  let [notifications, setNotifications] = useState([]);
  let [selectedNotification, setSelectedNotification] = useState(null);
  let [notifError, setNotifError] = useState("");
  let [isLoadingNotifications, setIsLoadingNotifications] = useState(true);
  let notifPollRef = useRef(null);
  let fetchingRef = useRef(false);
  let docxContainerRef = useRef(null);
  let pollSeconds = 120;
  function safeStr(x) {
    if (x === null) {
      return "";
    }
    return "" + x;
  }
  function safeArr(x) {
    if (x === null) {
      return [];
    }
    return x;
  }
  function safeTypeFromBackend(t) {
    let tt = safeStr(t).toLowerCase();
    if (tt === "message") {
      return "message";
    }
    if (tt === "event") {
      return "event";
    }
    if (tt === "warning") {
      return "warning";
    }
    return "success";
  }
  function pickReport(data) {
    if (data === null) {
      return null;
    }
    if ("reports" in data === false) {
      return null;
    }
    let reps = data["reports"];
    if (reps === null || reps.length === 0) {
      return null;
    }
    let i = 0;
    while (i < reps.length) {
      let r = reps[i];
      if (r !== null && "status" in r && safeStr(r["status"]).toLowerCase() === "success") {
        return r;
      }
      i = i + 1;
    }
    return reps[0];
  }
  async function safeParseJSON(res) {
    try {
      return await res.json();
    } catch (e) {
      try {
        let t = await res.text();
        return JSON.parse(t);
      } catch (e2) {
        return null;
      }
    }
  }
  function mergeReadFlags(prev, incoming) {
    let out = [];
    let i = 0;
    while (i < incoming.length) {
      let n = incoming[i];
      if (n === null) {
        i = i + 1;
        continue;
      }
      let nid = safeStr(n.id);
      let wasRead = false;
      let j = 0;
      while (j < prev.length) {
        let p = prev[j];
        if (p !== null && safeStr(p.id) === nid) {
          wasRead = p.read === true;
          break;
        }
        j = j + 1;
      }
      if (wasRead === true) {
        n.read = true;
      }
      out.push(n);
      i = i + 1;
    }
    return out;
  }
  async function fetchLiveNotifications(showSpinner) {
    if (fetchingRef.current === true) {
      return;
    }
    fetchingRef.current = true;
    if (showSpinner === true) {
      setIsLoadingNotifications(true);
    }
    setNotifError("");
    try {
      let result = await __jacSpawn("live_job_market_trends_notifications", "", {"location": "worldwide", "focus": "all", "max_jobs_per_source": 25, "max_notifications": 5});
      if (result === null || result.reports === null || result.reports.length === 0) {
        setNotifError("No report returned from server.");
        setIsLoadingNotifications(false);
        fetchingRef.current = false;
        return;
      }
      let rep = result.reports[0];
      let i = 0;
      while (i < result.reports.length) {
        if (result.reports[i].status === "Success") {
          rep = result.reports[i];
          break;
        }
        i = i + 1;
      }
      if (rep.status !== "Success") {
        let msg = safeStr(rep.message);
        if (msg === "") {
          msg = "Server returned Fail.";
        }
        setNotifError(msg);
      }
      let body = "body" in rep ? rep.body : rep;
      let nots = "notifications" in body ? body.notifications : [];
      nots = safeArr(nots);
      let mapped = nots.map(n => {
        let nid = safeStr(n.id);
        let t = safeTypeFromBackend(n.type);
        let title = safeStr(n.title);
        let desc = safeStr(n.description);
        let timeText = "local_time" in n && safeStr(n.local_time) !== "" ? safeStr(n.local_time) : safeStr(n.time);
        let urlVal = safeStr(n.url);
        return {id: nid, "key": t, title: title, description: desc, time: timeText, url: urlVal, read: false};
      });
      setNotifications(prev => {
        return mergeReadFlags(prev, mapped);
      });
    } catch (err) {
      console.log(err);
      setNotifError("Live notification error.");
    }
    setIsLoadingNotifications(false);
    fetchingRef.current = false;
  }
  let unreadCount = notifications.filter(n => {
    return n.read === false;
  }).length;
  unreadCount = notifications.filter(n => {
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
  let certificationsClasses = activeLink === "certifications" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  let devRoles = ["Frontend Developer", "Backend Developer", "Fullstack Developer", "Mobile Developer", "DevOps Engineer", "UI/UX Designer", "Data Scientist", "Machine Learning Engineer"];
  async function getUserDetails() {
    try {
      let result = await __jacSpawn("get_user_details", "", {});
      let profile = await __jacSpawn("get_user_profile", "", {});
      let data = profile.reports[0].body.skills;
      let certData = profile.reports[0].body.certifications;
      let certObjects = certData.map(cert => {
        let certName = "";
        if (cert.name) {
          certName = cert.name;
        } else {
          certName = cert.title;
        }
        return {name: certName, url: cert.url};
      });
      setSelectedCertifications(certObjects);
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
      let roleObjects = roles.map(role => {
        let roleName = "";
        if (role.title) {
          roleName = role.title;
        } else {
          roleName = role.name;
        }
        return {name: roleName};
      });
      setSelectedRoles(roleObjects);
      let allRoadmaps = [];
      for (const role of roles) {
        let roleTitle = "";
        if (role.title) {
          roleTitle = role.title;
        } else {
          roleTitle = role.name;
        }
        let result = await __jacSpawn("retrieve_skill_gaps", "", {"role_title": roleTitle});
        setUserSkillGap(userSkillgap.concat(result.result.gaps));
        let roadmap = await __jacSpawn("get_road_map", "", {"role_title": roleTitle});
        if (roadmap.reports.length > 0) {
          let rep = roadmap.reports[0];
          if (rep.status === "Success") {
            allRoadmaps.push(rep);
          } else {
            allRoadmaps.push({"id": "temp_" + roleTitle, "body": {"role_title": roleTitle, "learning_path": "GENERATING_ROADMAP"}});
            generateRoadmap(roleTitle);
          }
        }
      }
      setRoadmapData(allRoadmaps);
    } catch (err) {
      console.log(err);
    }
  }
  async function generateRoadmap(roleTitle) {
    try {
      await __jacSpawn("recommend_learning_paths", "", {"role_title": roleTitle});
      getSkillGap();
    } catch (err) {
      console.log(err);
    }
  }
  useEffect(() => {
    getUserDetails();
    getSkillGap();
    fetchResume(false);
  }, []);
  useEffect(() => {
    setTimeout(() => {
      fetchLiveNotifications(true);
    }, 2000);
    notifPollRef.current = setInterval(() => {
      fetchLiveNotifications(false);
    }, 1200000);
    return () => {
      if (notifPollRef.current !== null) {
        clearInterval(notifPollRef.current);
        notifPollRef.current = null;
      }
    };
  }, []);
  function handleLogout() {
    jacLogout();
    navigate("/");
  }
  function normalizeNotif(raw) {
    let n_id = raw && raw.id ? raw.id : "n_" + "" + window.performance.now();
    let n_type = raw && raw.type ? raw.type : "event";
    let n_title = raw && raw.title ? raw.title : "Notification";
    let n_desc = raw && raw.description ? raw.description : "";
    let n_time = raw && raw.local_time ? raw.local_time : raw && raw.time ? raw.time : "";
    let n_url = raw && raw.url ? raw.url : "";
    let n_read = false;
    if (raw && raw.read === true) {
      n_read = true;
    }
    return {id: n_id, "key": n_type, title: n_title, description: n_desc, time: n_time, url: n_url, read: n_read};
  }
  function mergeNotifs(prev, incoming) {
    let merged = prev;
    for (const inc of incoming) {
      let idx = merged.findIndex(p => {
        return p.id === inc.id;
      });
      if (idx === -1) {
        merged = [inc].concat(merged);
      } else {
        let old = merged[idx];
        merged[idx] = {id: inc.id, "key": inc.type, title: inc.title, description: inc.description, time: inc.time, url: inc.url, read: old.read};
      }
    }
    return merged.slice(0, 80);
  }
  function LoadingDots() {
    return __jacJsx("div", {"style": {"display": "flex", "justifyContent": "center", "alignItems": "center", "gap": "6px", "height": "20px"}}, [__jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, [])]);
  }
  function handleSaveSkills() {
    saveSkills();
  }
  async function saveSkills() {
    setIsLoading(true);
    try {
      let result = await __jacSpawn("update_user_profile", "", {"updated_skills": selectedSkills, "updated_certifications": selectedCertifications});
      if (result) {
        setIsLoading(false);
      }
    } catch (err) {
      console.log(err);
    }
  }
  async function saveCertifications() {
    setIsLoading(true);
    try {
      let result = await __jacSpawn("update_user_profile", "", {"updated_certifications": selectedCertifications, "updated_skills": selectedSkills});
      if (result) {
        setIsLoading(false);
      }
    } catch (err) {
      console.log(err);
    }
  }
  function handleSaveCertifications() {
    saveCertifications();
  }
  async function openResumePreview() {
    await fetchResume(true);
  }
  async function fetchResume(openPreview) {
    try {
      let resume = await __jacSpawn("retrieve_resume", "", {});
      if (resume.reports.length > 0) {
        let reported = resume.reports[0];
        if (reported.status === "Success") {
          let body = reported.body;
          setCvFileBase64(body.file_base64);
          setCvFileName(body.name);
          setCvMimeType(body.mime);
          if (openPreview) {
            setCvPreviewOpen(true);
          }
        }
      }
    } catch (err) {
      console.log(err);
    }
  }
  useEffect(() => {
    if (cvFileBase64 !== "") {
      let dataUrl = "data:" + cvMimeType + ";base64," + cvFileBase64;
      fetch(dataUrl).then(response => {
        return response.blob();
      }).then(blob => {
        let url = URL.createObjectURL(blob);
        setCvPreviewUrl(url);
      });
    }
  }, [cvFileBase64]);
  useEffect(() => {
    if (cvPreviewOpen && cvPreviewUrl !== "" && cvMimeType.includes("wordprocessingml")) {
      fetch(cvPreviewUrl).then(response => {
        return response.blob();
      }).then(blob => {
        if (docxContainerRef.current) {
          renderAsync(blob, docxContainerRef.current, null, {"inWrapper": false, "ignoreWidth": false, "ignoreHeight": false});
        }
      });
    }
  }, [cvPreviewOpen, cvPreviewUrl, cvMimeType]);
  function CvPreviewModal() {
    if (cvPreviewOpen === false) {
      return "";
    }
    return __jacJsx("div", {"className": "fixed inset-0 bg-black/70 flex items-center justify-center z-50"}, [__jacJsx("div", {"className": "bg-[#0b0b0b] w-[80%] h-[80%] rounded-xl shadow-lg flex flex-col"}, [__jacJsx("div", {"className": "flex items-center justify-between p-4 border-b border-gray-800"}, [__jacJsx("div", {"className": "text-white font-medium"}, [cvFileName]), __jacJsx("button", {"onClick": () => {
      setCvPreviewOpen(false);
    }, "className": "text-gray-400 hover:text-white cursor-pointer"}, ["✕"])]), __jacJsx("div", {"className": "flex-1 overflow-auto bg-white p-4", "style": {"display": "flex", "flexDirection": "column"}}, [cvMimeType.includes("wordprocessingml") ? __jacJsx("div", {"ref": docxContainerRef, "style": {"width": "100%", "minHeight": "500px"}}, []) : __jacJsx("iframe", {"src": cvPreviewUrl, "className": "w-full h-full border-none"}, [])])])]);
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
    }, "className": baseLinkClasses + notificationsClasses}, [__jacJsx("span", {"className": "flex items-center justify-between w-full"}, [__jacJsx("span", {}, ["Notifications"]), isLoadingNotifications ? __jacJsx("span", {"className": "ml-auto"}, [__jacJsx(Loader2, {"className": "w-4 h-4 animate-spin text-gray-500"}, [])]) : unreadCount > 0 ? __jacJsx("span", {"className": "ml-auto bg-primary text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center"}, [unreadCount]) : ""])])])])]), __jacJsx("div", {}, [__jacJsx("div", {"className": "text-gray-500 text-xs uppercase font-semibold m-y2 px-4 mb-4"}, ["Actions"]), __jacJsx("ul", {"className": "list-none p-0 m-0 ml-[8px]"}, [__jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("skills");
    }, "className": baseLinkClasses + skillsClasses}, [__jacJsx("span", {}, ["Skills"])])]), __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("roles");
    }, "className": baseLinkClasses + rolesClasses}, [__jacJsx("span", {}, ["Roles"])])]), __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("certifications");
    }, "className": baseLinkClasses + certificationsClasses}, [__jacJsx("span", {}, ["Certifications"])])])])])]), __jacJsx("div", {"className": "p-4 "}, [__jacJsx("div", {"className": "flex items-center gap-3 px-4 py-3 text-red-400", "onClick": handleLogout}, [__jacJsx(LogOut, {}, []), __jacJsx("div", {"className": "text-sm text-red-400 font-medium"}, ["Logout"])])])]);
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
    }, "className": baseLinkClasses + rolesClasses}, [__jacJsx("span", {}, ["Roles"])])]), __jacJsx("li", {"className": "mb-[6px]"}, [__jacJsx("div", {"onClick": e => {
      setActiveLink("certifications");
    }, "className": baseLinkClasses + certificationsClasses}, [__jacJsx("span", {}, ["Certifications"])])])])])]), __jacJsx("div", {"className": "p-4 "}, [__jacJsx("div", {"className": "flex items-center gap-3 px-4 py-3 text-red-400", "onClick": handleLogout}, [__jacJsx(LogOut, {}, []), __jacJsx("div", {"className": "text-sm text-red-400 font-medium"}, ["Logout"])])])]);
  }
  function ProfilePanel() {
    return __jacJsx("div", {"className": "hidden lg:flex lg:flex-col lg:w-72 bg-[#0b0b0b] h-screen border-l border-gray-800"}, [__jacJsx("div", {"className": "p-6"}, [__jacJsx("div", {"className": "flex flex-col items-center mb-6"}, [__jacJsx("div", {"className": "w-20 h-20 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-2xl mb-4"}, [userDetails.full_name ? userDetails.full_name[0] : "U"]), __jacJsx("div", {"className": "text-white font-medium"}, [userDetails.full_name ? userDetails.full_name : "Guest"]), __jacJsx("div", {"className": "text-gray-400 text-sm"}, [userDetails.email ? userDetails.email : ""])])]), __jacJsx("div", {"className": "flex-1 overflow-y-auto px-6 pb-6 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]"}, ["                        ", userSkillgap.length > 0 ? __jacJsx("div", {}, [userSkillgap[0].skills ? __jacJsx(null, {}, [__jacJsx("h3", {"className": "mt-4 text-base font-normal text-gray-300 mb-6"}, ["Skills Gap Analysis"]), userSkillgap[0].skills.slice(0, 3).map(skillgap => {
      return __jacJsx(InsightContent, {"key": skillgap.id, "skill": skillgap.name}, []);
    })]) : "", userSkillgap[0].certifications ? __jacJsx(null, {}, [__jacJsx("h3", {"className": "mt-6 text-base font-normal text-gray-300 mb-6"}, ["Certification recommendations"]), userSkillgap[0].certifications.slice(0, 2).map(cert => {
      return __jacJsx("a", {"key": cert._jac_id, "href": cert.url, "target": "_blank", "rel": "noopener noreferrer", "className": "block"}, [__jacJsx(InsightContent, {"skill": cert.title}, [])]);
    })]) : ""]) : "", __jacJsx("div", {"className": "mt-6"}, [__jacJsx("h3", {"className": "text-base font-normal text-gray-300 mb-4"}, ["My CV"]), __jacJsx("div", {"className": "w-full flex flex-col gap-4"}, [__jacJsx("div", {"onClick": () => {
      openResumePreview();
    }, "className": "flex items-start gap-3 p-3 bg-[black] rounded-lg hover:bg-[#1a1a1a] transition-colors cursor-pointer"}, [__jacJsx("div", {"className": "w-12 h-12 bg-red-500/10 rounded-lg flex items-center justify-center flex-shrink-0"}, [__jacJsx("svg", {"className": "w-6 h-6 text-red-500", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"}, [])])]), __jacJsx("div", {"className": "flex-1 min-w-0"}, [__jacJsx("div", {"className": "text-white font-medium text-sm mb-1 truncate"}, [cvFileName ? cvFileName : "No CV uploaded"]), __jacJsx("div", {"className": "text-gray-500 text-xs"}, ["Last updated: Dec 10, 2025"])])])])])])]);
  }
  function MobileProfilePanel() {
    let baseClasses = "fixed top-0 right-0 bg-[#0b0b0b] h-screen w-[80%] max-w-[300px] transform transition-transform duration-300 ease-in-out z-[100000] border-l border-gray-800 p-6 overflow-y-auto";
    let positionClass = profileOpen ? "translate-x-0" : "translate-x-full";
    return __jacJsx("div", {"className": baseClasses + " " + positionClass}, [__jacJsx("div", {"className": "flex items-center justify-between mb-6"}, [__jacJsx("h3", {"className": "text-white font-semibold text-lg"}, ["Profile"]), __jacJsx("button", {"onClick": e => {
      setProfileOpen(false);
    }, "className": "text-gray-400 hover:text-white transition-colors bg-transparent border-none cursor-pointer"}, [__jacJsx("svg", {"className": "w-6 h-6", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M6 18L18 6M6 6l12 12"}, [])])])]), __jacJsx("div", {"className": "p-6"}, [__jacJsx("div", {"className": "flex flex-col items-center mb-6"}, [__jacJsx("div", {"className": "w-20 h-20 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-2xl mb-4"}, [userDetails.full_name ? userDetails.full_name[0] : "U"]), __jacJsx("div", {"className": "text-white font-medium"}, [userDetails.full_name ? userDetails.full_name : "Guest"]), __jacJsx("div", {"className": "text-gray-400 text-sm"}, [userDetails.email ? userDetails.email : ""])])]), __jacJsx("div", {"className": "flex-1 overflow-y-auto px-2 pb-6 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]"}, ["                        ", userSkillgap.length > 0 ? __jacJsx("div", {}, [userSkillgap[0].skills ? __jacJsx(null, {}, [__jacJsx("h3", {"className": "mt-4 text-base font-normal text-gray-300 mb-6"}, ["Skills Gap Analysis"]), userSkillgap[0].skills.slice(0, 3).map(skillgap => {
      return __jacJsx(InsightContent, {"key": skillgap.id, "skill": skillgap.name}, []);
    })]) : "", userSkillgap[0].certifications ? __jacJsx(null, {}, [__jacJsx("h3", {"className": "mt-6 text-base font-normal text-gray-300 mb-6"}, ["Certification recommendations"]), userSkillgap[0].certifications.slice(0, 2).map(cert => {
      return __jacJsx("a", {"key": cert._jac_id, "href": cert.url, "target": "_blank", "rel": "noopener noreferrer", "className": "block"}, [__jacJsx(InsightContent, {"skill": cert.title}, [])]);
    })]) : ""]) : "", __jacJsx("div", {"className": "mt-6"}, [__jacJsx("h3", {"className": "text-base font-normal text-gray-300 mb-4"}, ["My CV"]), __jacJsx("div", {"className": "w-full flex flex-col gap-4"}, [__jacJsx("div", {"onClick": () => {
      openResumePreview();
    }, "className": "flex items-start gap-3 p-3 bg-[black] rounded-lg hover:bg-[#1a1a1a] transition-colors cursor-pointer"}, [__jacJsx("div", {"className": "w-12 h-12 bg-red-500/10 rounded-lg flex items-center justify-center flex-shrink-0"}, [__jacJsx("svg", {"className": "w-6 h-6 text-red-500", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M7 21h10a2 2 0 002-2V9.414a1 1 0 00-.293-.707l-5.414-5.414A1 1 0 0012.586 3H7a2 2 0 00-2 2v14a2 2 0 002 2z"}, [])])]), __jacJsx("div", {"className": "flex-1 min-w-0"}, [__jacJsx("div", {"className": "text-white font-medium text-sm mb-1 truncate"}, [cvFileName ? cvFileName : "No CV uploaded"]), __jacJsx("div", {"className": "text-gray-500 text-xs"}, ["Last updated: Dec 10, 2025"])])])])])])]);
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
    return __jacJsx("div", {"className": "flex-1 p-6 md:p-8"}, [activeLink === "dashboard" && __jacJsx("div", {"className": "[&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]"}, [__jacJsx("h1", {"className": "text-2xl md:text-3xl font-bold text-white mb-6"}, ["Welcome Back!"]), __jacJsx("div", {"className": "grid grid-cols-1 md:grid-cols-[72%_28%] gap-4 md:gap-1 "}, [__jacJsx("div", {"className": "w-[98%] h-[35vh] bg-gradient-to-br from-purple-600 to-blue-500 rounded-2xl p-8 flex flex-col justify-between relative overflow-hidden"}, [__jacJsx("div", {"className": "absolute top-0 right-0 w-64 h-64 bg-white opacity-5 rounded-full blur-3xl"}, []), __jacJsx("div", {"className": "absolute bottom-0 right-20 w-40 h-40 bg-white opacity-5 rounded-full blur-2xl"}, []), __jacJsx("div", {"className": "relative z-10"}, [__jacJsx("div", {"className": "text-white text-xs uppercase tracking-wider font-semibold mb-3 opacity-90"}, ["Online Course"]), __jacJsx("h2", {"className": "text-white text-2xl md:text-3xl font-bold leading-tight mb-6"}, ["Sharpen Your Skills with", __jacJsx("br", {}, []), "Professional Online Courses"])]), __jacJsx("div", {"className": "relative z-10"}, [__jacJsx("button", {"onClick": () => {
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
    }, "className": "px-6 py-3 bg-transparent text-red-400 border border-red-400 rounded-lg hover:bg-red-400 hover:text-white transition-all cursor-pointer font-semibold"}, ["Delete"]), selectedNotification.url && safeStr(selectedNotification.url) !== "" && __jacJsx("button", {"onClick": e => {
      window.open(selectedNotification.url, "_blank");
    }, "className": "px-6 py-3 bg-[#101010ff] text-white rounded-lg hover:bg-[#1a1a1a] transition-all border border-gray-700 cursor-pointer font-semibold"}, ["Open Link"])])])]) : __jacJsx("div", {}, [__jacJsx("div", {"className": "flex items-center justify-between mb-6"}, [__jacJsx("div", {}, [__jacJsx("h1", {"className": "text-2xl md:text-3xl font-bold text-white mb-2"}, ["Notifications"]), __jacJsx("p", {"className": "text-gray-400"}, ["You have ", unreadCount, " new notifications."])]), unreadCount > 0 && __jacJsx("button", {"onClick": e => {
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
    })])])]), activeLink === "skills" && __jacJsx(SelectionManager, {"title": "Select Your Skills", "description": "Choose or add your skills", "placeholder": "Search or type a skill and press Enter", "selectedLabel": "Selected Skills", "availableLabel": "Available Skills", "availableItems": "none", "selectedItems": selectedSkills, "setSelectedItems": setSelectedSkills, "onSave": handleSaveSkills}, []), activeLink === "roles" && __jacJsx(SelectionManager, {"title": "Select Your Roles", "description": "Choose or add your target roles", "placeholder": "Search or type a role and press Enter", "selectedLabel": "Selected Roles", "availableLabel": "Available Roles", "availableItems": "none", "selectedItems": selectedRoles, "setSelectedItems": setSelectedRoles, "onSave": () => {}}, []), activeLink === "certifications" && __jacJsx(SelectionManager, {"title": "Select Your Certifications", "description": "Choose or add your certifications", "placeholder": "Search or type a certification and press Enter", "selectedLabel": "Selected Certifications", "availableLabel": "Available Certifications", "availableItems": "none", "selectedItems": selectedCertifications, "setSelectedItems": setSelectedCertifications, "onSave": handleSaveCertifications}, []), activeLink === "roadmap" && __jacJsx("div", {}, [__jacJsx("h1", {"className": "text-2xl md:text-3xl font-bold text-white mb-6"}, ["My Roadmap"]), __jacJsx("p", {"className": "text-gray-400"}, ["Your personalized learning path"]), __jacJsx("div", {"className": "grid grid-cols-1 md:grid-cols-3 gap-4"}, [roadmapData.map(roadmap => {
      return __jacJsx(RoadmapContent, {"key": roadmap.id, "roadmap": roadmap.body.role_title, "markdown": roadmap.body.learning_path}, []);
    })])]), activeLink === "roadmap-inside" && __jacJsx("div", {}, [__jacJsx("button", {"onClick": e => {
      setActiveLink("roadmap");
    }, "className": "flex items-center gap-2 text-gray-400 hover:text-white transition-colors mb-6 bg-transparent border-none cursor-pointer"}, [__jacJsx("svg", {"className": "w-5 h-5", "fill": "none", "stroke": "currentColor", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"strokeLinecap": "round", "strokeLinejoin": "round", "strokeWidth": 2, "d": "M15 19l-7-7 7-7"}, [])]), __jacJsx("span", {}, ["Back to Roadmaps"])]), __jacJsx("div", {"className": "rounded-lg p-8"}, [roadmapMarkdown === "GENERATING_ROADMAP" ? __jacJsx("div", {"className": "flex flex-col items-center justify-center p-20 min-h-[400px]"}, [__jacJsx("div", {"className": "bg-blue-600/20 backdrop-blur-sm border border-blue-500/30 p-8 rounded-2xl flex flex-col items-center gap-4 shadow-xl shadow-blue-900/10"}, [__jacJsx("div", {"style": {"display": "flex", "justifyContent": "center", "alignItems": "center", "gap": "8px", "height": "40px"}}, [__jacJsx("span", {"className": "loading-dot w-3 h-3 bg-blue-400"}, []), __jacJsx("span", {"className": "loading-dot w-3 h-3 bg-blue-400", "style": {"animationDelay": "0.2s"}}, []), __jacJsx("span", {"className": "loading-dot w-3 h-3 bg-blue-400", "style": {"animationDelay": "0.4s"}}, [])]), __jacJsx("div", {"className": "text-blue-300 font-medium tracking-wide animate-pulse"}, ["Generating your personalized roadmap..."])])]) : __jacJsx("div", {"className": "max-w-4xl mx-auto px-2 lg:px-6 py-8 text-white"}, [__jacJsx(ReactMarkdown, {"components": {h1: props => {
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
    function safeStr(x) {
      if (x === null) {
        return "";
      }
      return "" + x;
    }
    function trimStr(x) {
      let s = safeStr(x);
      return s.trim();
    }
    function getUserName() {
      let nm = "";
      try {
        if (userDetails !== null && "full_name" in userDetails && userDetails["full_name"] !== null) {
          nm = trimStr(userDetails["full_name"]);
        }
      } catch (e) {}
      if (nm === "") {
        nm = "You";
      }
      return nm;
    }
    function getUserInitial() {
      let nm = getUserName();
      if (nm === "") {
        return "U";
      }
      return "" + nm[0].toUpperCase();
    }
    function getTimeNowLabel() {
      return "Now";
    }
    let [messages, setMessages] = useState([{"id": "greet", "type": "bot", "content": "Hello! I'm Arise AI. How can I help you with your learning journey today?", "timestamp": "12:00"}]);
    let [inputValue, setInputValue] = useState("");
    let [isTyping, setIsTyping] = useState(false);
    let messagesEndRef = useRef(null);
    function scrollToBottom() {
      try {
        if (messagesEndRef.current !== null) {
          messagesEndRef.current.scrollIntoView({"behavior": "smooth"});
        }
      } catch (e) {}
    }
    useEffect(() => {
      scrollToBottom();
    }, [messages, isTyping]);
    function extractReply(result) {
      if (result !== null && "reply" in result && result["reply"] !== null) {
        return safeStr(result["reply"]);
      }
      if (result !== null && "reports" in result && result["reports"] !== null && result["reports"].length > 0) {
        for (const r of result["reports"]) {
          if (r !== null && "reply" in r && r["reply"] !== null) {
            return safeStr(r["reply"]);
          }
          if (r !== null && "body" in r && r["body"] !== null && "reply" in r["body"] && r["body"]["reply"] !== null) {
            return safeStr(r["body"]["reply"]);
          }
        }
      }
      return "Sorry \u2014 I couldn\u2019t generate a reply right now. Please try again.";
    }
    async function handleSendMessage() {
      if (inputValue.trim() === "" || isTyping === true) {
        return;
      }
      let trimmed = inputValue.trim();
      let userMessage = {"id": "u_" + "" + window.performance.now(), "type": "user", "content": trimmed, "timestamp": getTimeNowLabel()};
      setMessages(prev => {
        return prev.concat([userMessage]);
      });
      setInputValue("");
      setIsTyping(true);
      let replyText = "Sorry \u2014 I couldn\u2019t generate a reply right now. Please try again.";
      try {
        let uid = "local-user";
        try {
          if (userDetails !== null) {
            if ("email" in userDetails && userDetails["email"] !== null && trimStr(userDetails["email"]) !== "") {
              uid = safeStr(userDetails["email"]);
            } else {
              uid = getUserName();
            }
          } else {
            uid = getUserName();
          }
        } catch (e_uid) {}
        let result = await __jacSpawn("career_chat", "", {"user_id": uid, "message": trimmed, "focus_area": "General guidance"});
        replyText = extractReply(result);
      } catch (e) {
        console.log(e);
        replyText = "Sorry \u2014 I had trouble reaching Arise AI backend. Please try again.";
      }
      let botMessage = {"id": "b_" + "" + window.performance.now(), "type": "bot", "content": replyText, "timestamp": getTimeNowLabel()};
      setMessages(prev => {
        return prev.concat([botMessage]);
      });
      setIsTyping(false);
    }
    function TypingIndicator() {
      return __jacJsx("div", {"className": "flex justify-start mb-10 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]"}, [__jacJsx("div", {"className": "flex items-end gap-4"}, [__jacJsx("div", {"className": "w-10 h-10 rounded-full bg-purple-600 flex items-center justify-center flex-shrink-0"}, [__jacJsx("span", {"className": "text-white text-sm font-semibold"}, ["AI"])]), __jacJsx("div", {"className": "flex flex-col items-start"}, [__jacJsx("div", {"className": "text-white font-bold text-sm mb-2"}, ["Arise AI"]), __jacJsx("div", {"className": "bg-[#1a1a1a] text-white rounded-2xl px-5 py-3 max-w-[560px]"}, [__jacJsx("div", {"style": {"display": "flex", "justifyContent": "center", "alignItems": "center", "gap": "6px", "height": "20px"}}, [__jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, []), __jacJsx("span", {"className": "loading-dot"}, [])])]), __jacJsx("div", {"className": "text-xs text-gray-500 mt-2"}, ["..."])])])]);
    }
    return __jacJsx("div", {"className": "flex flex-col h-[calc(100vh-3rem)]"}, [__jacJsx("div", {"className": "mb-8"}, []), __jacJsx("div", {"className": "flex-1 overflow-y-auto pr-2"}, [messages.map(m => {
      let t = "bot";
      try {
        if (m !== null && "type" in m && m["type"] !== null) {
          t = "" + m["type"].toLowerCase();
        }
      } catch (e) {
        t = "bot";
      }
      let isUser = t === "user";
      let mid = "m_" + "" + window.performance.now();
      try {
        if (m !== null && "id" in m && m["id"] !== null) {
          mid = safeStr(m["id"]);
        }
      } catch (e2) {}
      let content = "";
      try {
        if (m !== null && "content" in m && m["content"] !== null) {
          content = safeStr(m["content"]);
        }
      } catch (e3) {}
      let ts = "Now";
      try {
        if (m !== null && "timestamp" in m && m["timestamp"] !== null) {
          ts = safeStr(m["timestamp"]);
        }
      } catch (e4) {}
      if (isUser) {
        return __jacJsx("div", {"key": mid, "className": "flex justify-end mb-10"}, [__jacJsx("div", {"className": "flex items-end gap-4"}, [__jacJsx("div", {"className": "flex flex-col items-end"}, [__jacJsx("div", {"className": "text-white font-bold text-sm mb-2"}, [getUserName()]), __jacJsx("div", {"className": "bg-purple-600 text-white rounded-2xl px-5 py-3 text-sm leading-relaxed max-w-[560px]"}, [content]), __jacJsx("div", {"className": "text-xs text-gray-500 mt-2 text-right"}, [ts])]), __jacJsx("div", {"className": "w-10 h-10 rounded-full bg-purple-600 flex items-center justify-center flex-shrink-0"}, [__jacJsx("span", {"className": "text-white text-sm font-semibold"}, [getUserInitial()])])])]);
      }
      return __jacJsx("div", {"key": mid, "className": "flex justify-start mb-10"}, [__jacJsx("div", {"className": "flex items-end gap-4"}, [__jacJsx("div", {"className": "w-10 h-10 rounded-full bg-purple-600 flex items-center justify-center flex-shrink-0"}, [__jacJsx("span", {"className": "text-white text-sm font-semibold"}, ["AI"])]), __jacJsx("div", {"className": "flex flex-col items-start"}, [__jacJsx("div", {"className": "text-white font-bold text-sm mb-2"}, ["Arise AI"]), __jacJsx("div", {"className": "bg-[#1a1a1a] text-white rounded-2xl px-5 py-3 text-sm leading-relaxed max-w-[560px]"}, [__jacJsx(ReactMarkdown, {"components": {p: props => {
        return __jacJsx("p", {"className": "mb-2 last:mb-0"}, [props.children]);
      }, ul: props => {
        return __jacJsx("ul", {"className": "list-disc ml-4 mb-2"}, [props.children]);
      }, ol: props => {
        return __jacJsx("ol", {"className": "list-decimal ml-4 mb-2"}, [props.children]);
      }, li: props => {
        return __jacJsx("li", {"className": "mb-1"}, [props.children]);
      }, strong: props => {
        return __jacJsx("strong", {"className": "font-bold text-white"}, [props.children]);
      }, h1: props => {
        return __jacJsx("h1", {"className": "text-lg font-bold mb-2"}, [props.children]);
      }, h2: props => {
        return __jacJsx("h2", {"className": "text-md font-bold mb-2"}, [props.children]);
      }, h3: props => {
        return __jacJsx("h3", {"className": "text-sm font-bold mb-1"}, [props.children]);
      }}}, [content])]), __jacJsx("div", {"className": "text-xs text-gray-500 mt-2 text-left"}, [ts])])])]);
    }), isTyping ? TypingIndicator() : "", __jacJsx("div", {"ref": messagesEndRef}, [])]), __jacJsx("div", {"className": "border-t border-gray-800 pt-4"}, [__jacJsx("div", {"className": "relative flex items-center gap-2"}, [__jacJsx("input", {"type": "text", "value": inputValue, "onChange": e => {
      setInputValue(e.target.value);
    }, "onKeyPress": e => {
      if (e.key === "Enter" && !e.shiftKey) {
        e.preventDefault();
        handleSendMessage();
      }
    }, "placeholder": "Type your message...", "className": "flex-1 border border-gray-700 rounded-lg px-4 py-3 text-white placeholder-gray-500 focus:outline-none focus:border-purple-600 transition-colors bg-transparent"}, []), __jacJsx("button", {"onClick": e => {
      handleSendMessage();
    }, "disabled": inputValue.trim() === "" || isTyping === true, "className": "bg-purple-600 text-white p-3 rounded-lg hover:bg-purple-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center"}, [__jacJsx(Send, {"className": "w-5 h-5"}, [])])])])]);
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
  }, "className": "fixed inset-0 bg-black bg-opacity-50 z-[99999] lg:hidden"}, []), __jacJsx(DashSideBar, {}, []), __jacJsx(MobileDashSideBar, {}, []), __jacJsx("div", {"className": "md:ml-64 lg:mr-72 min-h-screen"}, [__jacJsx(DashHeader, {}, []), __jacJsx("div", {"className": "pt-16 lg:pt-0"}, [__jacJsx(DashContent, {}, [])])]), __jacJsx("div", {"className": "hidden lg:block fixed top-0 right-0"}, [__jacJsx(ProfilePanel, {}, [])]), __jacJsx(MobileProfilePanel, {}, []), __jacJsx(CvPreviewModal, {}, [])]);
}
export { Dashboard };
