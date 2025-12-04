function _slicedToArray(r, e) { return _arrayWithHoles(r) || _iterableToArrayLimit(r, e) || _unsupportedIterableToArray(r, e) || _nonIterableRest(); }
function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }
function _unsupportedIterableToArray(r, a) { if (r) { if ("string" == typeof r) return _arrayLikeToArray(r, a); var t = {}.toString.call(r).slice(8, -1); return "Object" === t && r.constructor && (t = r.constructor.name), "Map" === t || "Set" === t ? Array.from(r) : "Arguments" === t || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(t) ? _arrayLikeToArray(r, a) : void 0; } }
function _arrayLikeToArray(r, a) { (null == a || a > r.length) && (a = r.length); for (var e = 0, n = Array(a); e < a; e++) n[e] = r[e]; return n; }
function _iterableToArrayLimit(r, l) { var t = null == r ? null : "undefined" != typeof Symbol && r[Symbol.iterator] || r["@@iterator"]; if (null != t) { var e, n, i, u, a = [], f = !0, o = !1; try { if (i = (t = t.call(r)).next, 0 === l) { if (Object(t) !== t) return; f = !1; } else for (; !(f = (e = i.call(t)).done) && (a.push(e.value), a.length !== l); f = !0); } catch (r) { o = !0, n = r; } finally { try { if (!f && null != t["return"] && (u = t["return"](), Object(u) !== u)) return; } finally { if (o) throw n; } } return a; } }
function _arrayWithHoles(r) { if (Array.isArray(r)) return r; }
import { __jacJsx, __jacSpawn } from "@jac-client/utils";
import { useState } from "react";
import { Mail, LogOut, Puzzle, Briefcase, Map } from "lucide-react";
import jaseciImg from "@jac-client/assets/images/jaseci.webp";
function Dashboard() {
  var _useState = useState(false),
    _useState2 = _slicedToArray(_useState, 2),
    sidebarOpen = _useState2[0],
    setSidebarOpen = _useState2[1];
  var _useState3 = useState(false),
    _useState4 = _slicedToArray(_useState3, 2),
    profileOpen = _useState4[0],
    setProfileOpen = _useState4[1];
  var _useState5 = useState("dashboard"),
    _useState6 = _slicedToArray(_useState5, 2),
    activeLink = _useState6[0],
    setActiveLink = _useState6[1];
  var _useState7 = useState([]),
    _useState8 = _slicedToArray(_useState7, 2),
    selectedSkills = _useState8[0],
    setSelectedSkills = _useState8[1];
  var _useState9 = useState([]),
    _useState0 = _slicedToArray(_useState9, 2),
    selectedRoles = _useState0[0],
    setSelectedRoles = _useState0[1];
  var _useState1 = useState([{
      id: 1,
      "key": "message",
      title: "New message from Jane",
      description: "Hey, just wanted to follow up on our meeting yesterday.",
      time: "2 hours ago",
      read: false
    }, {
      id: 2,
      "key": "event",
      title: "Upcoming event",
      description: "Team meeting scheduled for Friday at 2pm.",
      time: "1 day ago",
      read: false
    }, {
      id: 3,
      "key": "success",
      title: "Task completed",
      description: "You completed the \"Update website content\" task.",
      time: "3 days ago",
      read: true
    }, {
      id: 4,
      "key": "warning",
      title: "Account suspended",
      description: "Your account has been suspended due to a billing issue.",
      time: "1 week ago",
      read: true
    }]),
    _useState10 = _slicedToArray(_useState1, 2),
    notifications = _useState10[0],
    setNotifications = _useState10[1];
  var _useState11 = useState(null),
    _useState12 = _slicedToArray(_useState11, 2),
    selectedNotification = _useState12[0],
    setSelectedNotification = _useState12[1];
  var unreadCount = notifications.filter(function (n) {
    return n.read === false;
  }).length;
  var baseLinkClasses = "flex items-center gap-3 px-4 py-3 rounded-lg transition-all cursor-pointer ";
  var dashboardClasses = activeLink === "dashboard" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  var notificationsClasses = activeLink === "notifications" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  var skillsClasses = activeLink === "skills" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  var rolesClasses = activeLink === "roles" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  var roadmapClasses = activeLink === "roadmap" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  var quizzesClasses = activeLink === "quizzes" ? "bg-primary text-white" : "text-gray-300 hover:bg-[#101010ff] hover:text-white";
  var devSkills = ["JavaScript", "Python", "React", "Node.js", "TypeScript", "HTML & CSS", "Django", "Flutter", "Git & GitHub", "SQL & Databases", "REST APIs", "GraphQL", "Docker", "Agile & Scrum"];
  var devRoles = ["Frontend Developer", "Backend Developer", "Fullstack Developer", "Mobile Developer", "DevOps Engineer", "UI/UX Designer", "Data Scientist", "Machine Learning Engineer"];
  function DashSideBar() {
    return __jacJsx("div", {
      "className": "hidden md:flex md:w-64 bg-[#0b0b0b] h-screen flex-col border-r border-gray-800 fixed left-0 top-0"
    }, [__jacJsx("div", {
      "className": "p-6"
    }, [__jacJsx("div", {
      "className": "text-xl font-semibold text-white"
    }, ["Arise"])]), __jacJsx("nav", {
      "className": "flex-1 p-4 overflow-y-auto"
    }, [__jacJsx("div", {
      "className": "mb-6"
    }, [__jacJsx("div", {
      "className": "text-gray-500 text-xs uppercase font-semibold my-2 px-4 mb-4"
    }, ["Main"]), __jacJsx("ul", {
      "className": "list-none p-0 m-0 ml-[8px]"
    }, [__jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("dashboard");
      },
      "className": baseLinkClasses + dashboardClasses
    }, [__jacJsx("span", {}, ["Dashboard"])])]), __jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("profile");
        setSidebarOpen(false);
      },
      "className": baseLinkClasses + quizzesClasses
    }, [__jacJsx("span", {}, ["Profile"])])]), __jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("roadmap");
      },
      "className": baseLinkClasses + roadmapClasses
    }, [__jacJsx("span", {}, ["My Roadmap"])])]), __jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("quizzes");
      },
      "className": baseLinkClasses + quizzesClasses
    }, [__jacJsx("span", {}, ["Quizzes"])])]), " ", __jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("notifications");
      },
      "className": baseLinkClasses + notificationsClasses
    }, [__jacJsx("span", {
      "className": "flex items-center justify-between w-full"
    }, [__jacJsx("span", {}, ["Notifications"]), unreadCount > 0 && __jacJsx("span", {
      "className": "ml-auto bg-primary text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center"
    }, [unreadCount])])])])])]), __jacJsx("div", {}, [__jacJsx("div", {
      "className": "text-gray-500 text-xs uppercase font-semibold m-y2 px-4 mb-4"
    }, ["Actions"]), __jacJsx("ul", {
      "className": "list-none p-0 m-0 ml-[8px]"
    }, [__jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("skills");
      },
      "className": baseLinkClasses + skillsClasses
    }, [__jacJsx("span", {}, ["Skills"])])]), __jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("roles");
      },
      "className": baseLinkClasses + rolesClasses
    }, [__jacJsx("span", {}, ["Roles"])])])])])]), __jacJsx("div", {
      "className": "p-4 "
    }, [__jacJsx("div", {
      "className": "flex items-center gap-3 px-4 py-3 text-red-400"
    }, [__jacJsx(LogOut, {}, []), __jacJsx("div", {
      "className": "text-sm text-red-400 font-medium"
    }, ["Logout"])])])]);
  }
  function MobileDashSideBar() {
    var baseClasses = "fixed top-0 left-0 bg-[#0b0b0b] h-screen w-[80%] max-w-[300px] transform transition-transform duration-300 ease-in-out z-[100000] flex flex-col border-r border-gray-800";
    var positionClass = sidebarOpen ? "translate-x-0" : "-translate-x-full";
    return __jacJsx("div", {
      "className": baseClasses + " " + positionClass
    }, [__jacJsx("div", {
      "className": "p-6 border-b border-gray-800 flex items-center justify-between"
    }, [__jacJsx("div", {
      "className": "text-xl font-semibold text-white"
    }, ["Arise"]), __jacJsx("button", {
      "onClick": function onClick(e) {
        setSidebarOpen(false);
      },
      "className": "text-gray-400 hover:text-white transition-colors bg-transparent border-none cursor-pointer"
    }, [__jacJsx("svg", {
      "className": "w-6 h-6",
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 2,
      "d": "M6 18L18 6M6 6l12 12"
    }, [])])])]), __jacJsx("nav", {
      "className": "flex-1 p-4 overflow-y-auto"
    }, [__jacJsx("div", {
      "className": "mb-6"
    }, [__jacJsx("div", {
      "className": "text-gray-500 text-xs uppercase font-semibold mb-2 px-4"
    }, ["Main"]), __jacJsx("ul", {
      "className": "list-none p-0 m-0  ml-[8px]"
    }, [__jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("dashboard");
        setSidebarOpen(false);
      },
      "className": baseLinkClasses + dashboardClasses
    }, [__jacJsx("span", {}, ["Dashboard"])])]), __jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("profile");
        setSidebarOpen(false);
      },
      "className": baseLinkClasses + quizzesClasses
    }, [__jacJsx("span", {}, ["Profile"])])]), __jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("roadmap");
        setSidebarOpen(false);
      },
      "className": baseLinkClasses + roadmapClasses
    }, [__jacJsx("span", {}, ["My Roadmap"])])]), __jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("quizzes");
        setSidebarOpen(false);
      },
      "className": baseLinkClasses + quizzesClasses
    }, [__jacJsx("span", {}, ["Quizzes"])])]), __jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("notifications");
        setSidebarOpen(false);
      },
      "className": baseLinkClasses + notificationsClasses
    }, [__jacJsx("span", {
      "className": "flex items-center justify-between w-full"
    }, [__jacJsx("span", {}, ["Notifications"]), unreadCount > 0 && __jacJsx("span", {
      "className": "ml-auto bg-primary text-white text-xs font-bold rounded-full w-5 h-5 flex items-center justify-center"
    }, [unreadCount])])])])])]), __jacJsx("div", {}, [__jacJsx("div", {
      "className": "text-gray-500 text-xs uppercase font-semibold mb-2 px-4"
    }, ["Actions"]), __jacJsx("ul", {
      "className": "list-none p-0 m-0  ml-[8px]"
    }, [__jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("skills");
        setSidebarOpen(false);
      },
      "className": baseLinkClasses + skillsClasses
    }, [__jacJsx("span", {}, ["Skills"])])]), __jacJsx("li", {
      "className": "mb-[6px]"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        setActiveLink("roles");
        setSidebarOpen(false);
      },
      "className": baseLinkClasses + rolesClasses
    }, [__jacJsx("span", {}, ["Roles"])])])])])]), __jacJsx("div", {
      "className": "p-4 border-t border-gray-800"
    }, [__jacJsx("div", {
      "className": "flex items-center gap-3 px-4 py-3"
    }, [__jacJsx("div", {
      "className": "w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white font-semibold"
    }, ["U"]), __jacJsx("div", {
      "className": "flex-1"
    }, [__jacJsx("div", {
      "className": "text-white text-sm font-medium"
    }, ["User Name"]), __jacJsx("div", {
      "className": "text-gray-400 text-xs"
    }, ["user@email.com"])])])])]);
  }
  function ProfilePanel() {
    return __jacJsx("div", {
      "className": "hidden lg:block lg:w-80 bg-[#0b0b0b] h-screen border-l border-gray-800 p-6"
    }, [__jacJsx("div", {
      "className": "flex flex-col items-center mb-6"
    }, [__jacJsx("div", {
      "className": "w-20 h-20 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-2xl mb-4"
    }, ["U"]), __jacJsx("div", {
      "className": "text-white font-medium"
    }, ["User Name"]), __jacJsx("div", {
      "className": "text-gray-400 text-sm"
    }, ["user@email.com"])]), __jacJsx("div", {}, [__jacJsx("h3", {
      "className": "mt-4 text-base font-normal text-gray-300 mb-6"
    }, ["Skills Insight"]), __jacJsx("div", {
      "className": "h-[27vh] w-full bg-[black] rounded-md"
    }, [])]), __jacJsx("div", {}, [__jacJsx("h3", {
      "className": "mt-4 text-base font-normal text-gray-300 mb-6"
    }, ["Recommendations"]), __jacJsx("div", {
      "className": "h-[27vh] w-full bg-[black] rounded-md"
    }, [])])]);
  }
  function MobileProfilePanel() {
    var baseClasses = "fixed top-0 right-0 bg-[#0b0b0b] h-screen w-[80%] max-w-[300px] transform transition-transform duration-300 ease-in-out z-[100000] border-l border-gray-800 p-6 overflow-y-auto";
    var positionClass = profileOpen ? "translate-x-0" : "translate-x-full";
    return __jacJsx("div", {
      "className": baseClasses + " " + positionClass
    }, [__jacJsx("div", {
      "className": "flex items-center justify-between mb-6"
    }, [__jacJsx("h3", {
      "className": "text-white font-semibold text-lg"
    }, ["Profile"]), __jacJsx("button", {
      "onClick": function onClick(e) {
        setProfileOpen(false);
      },
      "className": "text-gray-400 hover:text-white transition-colors bg-transparent border-none cursor-pointer"
    }, [__jacJsx("svg", {
      "className": "w-6 h-6",
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 2,
      "d": "M6 18L18 6M6 6l12 12"
    }, [])])])]), __jacJsx("div", {
      "className": "flex flex-col items-center mb-6"
    }, [__jacJsx("div", {
      "className": "w-20 h-20 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-2xl mb-4"
    }, ["U"]), __jacJsx("div", {
      "className": "text-white font-medium"
    }, ["User Name"]), __jacJsx("div", {
      "className": "text-gray-400 text-sm"
    }, ["user@email.com"])])]);
  }
  function DashHeader() {
    return __jacJsx("div", {
      "className": "lg:hidden fixed top-0 left-0 right-0 bg-[#0b0b0b] border-b border-gray-800 p-4 flex items-center justify-between z-[1000]"
    }, [__jacJsx("button", {
      "onClick": function onClick(e) {
        setSidebarOpen(true);
      },
      "className": "text-white bg-transparent border-none cursor-pointer"
    }, [__jacJsx("svg", {
      "className": "w-6 h-6",
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 2,
      "d": "M4 6h16M4 12h16M4 18h16"
    }, [])])]), __jacJsx("div", {
      "className": "text-xl font-semibold text-white"
    }, ["Arise"]), __jacJsx("button", {
      "onClick": function onClick(e) {
        setProfileOpen(true);
      },
      "className": "w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white font-semibold text-sm border-none cursor-pointer"
    }, ["U"])]);
  }
  function SelectionManager(props) {
    var _useState13 = useState(""),
      _useState14 = _slicedToArray(_useState13, 2),
      inputValue = _useState14[0],
      setInputValue = _useState14[1];
    return __jacJsx("div", {}, [__jacJsx("div", {
      "className": "flex items-center justify-between mb-6"
    }, [__jacJsx("div", {}, []), __jacJsx("button", {
      "onClick": props.onSave,
      "className": "px-6 py-3 bg-primary text-white rounded-lg hover:bg-opacity-80 transition-all border-none cursor-pointer font-semibold"
    }, ["Save Changes"])]), __jacJsx("div", {
      "className": "rounded-lg"
    }, [__jacJsx("div", {
      "className": "mb-0 font-semibold text-white text-lg mb-2"
    }, [props.title]), __jacJsx("p", {
      "className": "text-gray-400 text-sm mb-6"
    }, [props.description]), __jacJsx("div", {
      "className": "relative mb-6"
    }, [__jacJsx("input", {
      "type": "text",
      "placeholder": props.placeholder,
      "value": inputValue,
      "onChange": function onChange(e) {
        setInputValue(e.target.value);
      },
      "onKeyDown": function onKeyDown(e) {
        if (e.key === "Enter" && inputValue.trim() !== "") {
          var alreadySelected = props.selectedItems.includes(inputValue.trim());
          if (alreadySelected === false) {
            var newSelected = props.selectedItems.concat([inputValue.trim()]);
            props.setSelectedItems(newSelected);
          }
          setInputValue("");
        }
      },
      "className": "w-full md:w-[70%] px-4 py-3 pl-10 bg-[#0b0b0b] border border-gray-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-primary transition-colors"
    }, []), __jacJsx("svg", {
      "className": "absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-500",
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 2,
      "d": "M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
    }, [])])]), props.selectedItems.length > 0 && __jacJsx("div", {
      "className": "mb-6"
    }, [__jacJsx("div", {
      "className": "text-gray-400 text-sm mb-2"
    }, [props.selectedLabel]), __jacJsx("div", {
      "className": "flex flex-wrap gap-2"
    }, [props.selectedItems.map(function (item) {
      return __jacJsx("div", {
        "key": item,
        "className": "bg-primary text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer flex items-center gap-2 hover:bg-opacity-80 transition-all"
      }, [item, __jacJsx("svg", {
        "onClick": function onClick(e) {
          props.setSelectedItems(props.selectedItems.filter(function (i) {
            return i !== item;
          }));
        },
        "className": "w-4 h-4 hover:scale-110 transition-transform",
        "fill": "none",
        "stroke": "currentColor",
        "viewBox": "0 0 24 24"
      }, [__jacJsx("path", {
        "strokeLinecap": "round",
        "strokeLinejoin": "round",
        "strokeWidth": 2,
        "d": "M6 18L18 6M6 6l12 12"
      }, [])])]);
    })])]), __jacJsx("div", {
      "className": "w-full md:w-[80%]"
    }, [__jacJsx("div", {
      "className": "text-gray-400 text-sm mb-2"
    }, [props.availableLabel]), __jacJsx("div", {
      "className": "flex flex-wrap gap-2 overflow-y-auto max-h-[40vh]"
    }, [props.availableItems.map(function (item) {
      var isSelected = props.selectedItems.includes(item);
      if (isSelected === false) {
        return __jacJsx("div", {
          "key": item,
          "onClick": function onClick(e) {
            var newSelected = props.selectedItems.concat([item]);
            props.setSelectedItems(newSelected);
          },
          "className": "border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-primary hover:bg-[#0b0b0b]"
        }, [item]);
      }
      return null;
    })])])])]);
  }
  function QuickActionCard(props) {
    var iconBg = props.color === "blue" ? "bg-blue-900/15" : props.color === "purple" ? "bg-purple-900/15" : props.color === "green" ? "bg-green-900/15" : "bg-gray-900";
    var iconColor = props.color === "blue" ? "text-blue-400" : props.color === "purple" ? "text-purple-400" : props.color === "green" ? "text-green-400" : "text-gray-400";
    return __jacJsx("div", {
      "onClick": props.onClick,
      "className": "border border-gray-300/20 rounded-md p-4 hover:border-primary transition-all cursor-pointer group"
    }, [__jacJsx("div", {
      "className": "flex items-start gap-4"
    }, [__jacJsx("div", {
      "className": iconBg + " w-12 h-12 rounded-lg flex items-center justify-center flex-shrink-0  transition-transform"
    }, [__jacJsx("div", {
      "className": iconColor
    }, [props.icon])]), __jacJsx("div", {
      "className": "flex-1"
    }, [__jacJsx("h3", {
      "className": "text-white font-semibold text-base mb-1"
    }, [props.title]), __jacJsx("p", {
      "className": "text-gray-400 text-sm"
    }, [props.description])])])]);
  }
  function DashContent() {
    return __jacJsx("div", {
      "className": "flex-1 p-6 md:p-8"
    }, [activeLink === "dashboard" && __jacJsx("div", {}, [__jacJsx("h1", {
      "className": "text-2xl md:text-3xl font-bold text-white mb-6"
    }, ["Welcome Back!"]), __jacJsx("div", {
      "className": "grid grid-cols-1 md:grid-cols-[70%_30%] gap-4 md:gap-1"
    }, [__jacJsx("div", {
      "className": "w-[98%] h-[35vh] bg-gradient-to-br from-purple-600 to-blue-500 rounded-2xl p-8 flex flex-col justify-between relative overflow-hidden"
    }, [__jacJsx("div", {
      "className": "absolute top-0 right-0 w-64 h-64 bg-white opacity-5 rounded-full blur-3xl"
    }, []), __jacJsx("div", {
      "className": "absolute bottom-0 right-20 w-40 h-40 bg-white opacity-5 rounded-full blur-2xl"
    }, []), __jacJsx("div", {
      "className": "relative z-10"
    }, [__jacJsx("div", {
      "className": "text-white text-xs uppercase tracking-wider font-semibold mb-3 opacity-90"
    }, ["Online Course"]), __jacJsx("h2", {
      "className": "text-white text-2xl md:text-3xl font-bold leading-tight mb-6"
    }, ["Sharpen Your Skills with", __jacJsx("br", {}, []), "Professional Online Courses"])]), __jacJsx("div", {
      "className": "relative z-10"
    }, [__jacJsx("button", {
      "className": "bg-black text-white pl-8 pr-3 py-3 rounded-full font-semibold flex items-center gap-3 hover:bg-gray-900 transition-all hover:translate-x-1 shadow-lg"
    }, [__jacJsx("span", {}, ["Join Now"]), __jacJsx("div", {
      "className": "w-6 h-6 bg-white rounded-full flex items-center justify-center"
    }, [__jacJsx("svg", {
      "className": "w-3 h-3 text-black",
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 3,
      "d": "M9 5l7 7-7 7"
    }, [])])])])])]), __jacJsx("div", {
      "className": "relative h-[35vh] border border-gray-300/30 rounded-lg p-6 overflow-hidden"
    }, [__jacJsx("img", {
      "src": jaseciImg,
      "alt": "jaseci",
      "className": "z-10 absolute inset-0 w-full h-full object-cover"
    }, []), __jacJsx("div", {
      "className": "z-50 flex"
    }, [__jacJsx("div", {
      "className": "absolute text-xs top-[10px] right-[10px] rounded-md bg-orange-500 text-white px-3 py-2"
    }, ["Trending"]), __jacJsx("button", {
      "className": "cursor-pointer absolute bottom-[15px] left-1/2 -translate-x-1/2 bg-orange-500 text-white rounded-md px-6 py-2 hover:bg-orange-600 transition-colors font-medium w-[90%]"
    }, ["Learn Jaseci"]), "                               "])])]), __jacJsx("div", {}, [__jacJsx("h3", {
      "className": "mt-4 text-base font-normal text-gray-300 mb-6"
    }, ["Quick Actions"]), __jacJsx("div", {
      "className": "grid grid-cols-1 md:grid-cols-3 gap-4"
    }, [__jacJsx(QuickActionCard, {
      "color": "blue",
      "title": "Skills",
      "description": "View your current skillset",
      "icon": __jacJsx(Puzzle, {
        "className": "w-6 h-6"
      }, []),
      "onClick": function onClick(e) {
        setActiveLink("skills");
      }
    }, []), __jacJsx(QuickActionCard, {
      "color": "purple",
      "title": "Roles",
      "description": "Targeted career roles",
      "icon": __jacJsx(Briefcase, {
        "className": "w-6 h-6"
      }, []),
      "onClick": function onClick(e) {
        setActiveLink("roles");
      }
    }, []), __jacJsx(QuickActionCard, {
      "color": "green",
      "title": "Roadmap",
      "description": "View learning path",
      "icon": __jacJsx(Map, {
        "className": "w-6 h-6"
      }, []),
      "onClick": function onClick(e) {
        setActiveLink("roadmap");
      }
    }, [])])]), __jacJsx("div", {}, [__jacJsx("h3", {
      "className": "mt-4 text-base font-normal text-gray-300 mb-6"
    }, ["Quizes"])])]), activeLink === "notifications" && __jacJsx("div", {}, [selectedNotification ? __jacJsx("div", {}, [__jacJsx("button", {
      "onClick": function onClick(e) {
        setSelectedNotification(null);
      },
      "className": "flex items-center gap-2 text-gray-400 hover:text-white transition-colors mb-6 bg-transparent border-none cursor-pointer"
    }, [__jacJsx("svg", {
      "className": "w-5 h-5",
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 2,
      "d": "M15 19l-7-7 7-7"
    }, [])]), __jacJsx("span", {}, ["Back to notifications"])]), __jacJsx("div", {
      "className": "rounded-lg p-8"
    }, [__jacJsx("div", {
      "className": "flex items-start gap-4 mb-6 pb-6 border-b border-gray-800"
    }, [__jacJsx("div", {
      "className": "w-16 h-16 rounded-full flex items-center justify-center flex-shrink-0 " + selectedNotification.type === "message" ? "bg-orange-500" : selectedNotification.type === "event" ? "bg-blue-500" : selectedNotification.type === "success" ? "bg-green-500" : "bg-yellow-500"
    }, [selectedNotification.type === "message" && __jacJsx("svg", {
      "className": "w-8 h-8 text-white",
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 2,
      "d": "M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
    }, [])]), selectedNotification.type === "event" && __jacJsx("svg", {
      "className": "w-8 h-8 text-white",
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 2,
      "d": "M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
    }, [])]), selectedNotification.type === "success" && __jacJsx("svg", {
      "className": "w-8 h-8 text-white",
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 2,
      "d": "M5 13l4 4L19 7"
    }, [])]), selectedNotification.type === "warning" && __jacJsx("svg", {
      "className": "w-8 h-8 text-white",
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 2,
      "d": "M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"
    }, [])])]), __jacJsx("div", {
      "className": "flex-1"
    }, [__jacJsx("h2", {
      "className": "text-white text-2xl font-bold mb-2"
    }, [selectedNotification.title]), __jacJsx("div", {
      "className": "flex items-center gap-4 text-sm text-gray-400"
    }, [__jacJsx("span", {}, [selectedNotification.time]), __jacJsx("span", {
      "className": "w-1 h-1 bg-gray-600 rounded-full"
    }, []), __jacJsx("span", {
      "className": "capitalize"
    }, [selectedNotification.type])])])]), __jacJsx("div", {
      "className": "text-gray-300 leading-relaxed"
    }, [__jacJsx("p", {}, [selectedNotification.description])]), __jacJsx("div", {
      "className": "mt-8 flex gap-3"
    }, [__jacJsx("button", {
      "onClick": function onClick(e) {
        var updatedNotifications = notifications.filter(function (n) {
          return n.id !== selectedNotification.id;
        });
        setNotifications(updatedNotifications);
        setSelectedNotification(null);
      },
      "className": "px-6 py-3 bg-transparent text-red-400 border border-red-400 rounded-lg hover:bg-red-400 hover:text-white transition-all cursor-pointer font-semibold"
    }, ["Delete"])])])]) : __jacJsx("div", {}, [__jacJsx("div", {
      "className": "flex items-center justify-between mb-6"
    }, [__jacJsx("div", {}, [__jacJsx("h1", {
      "className": "text-2xl md:text-3xl font-bold text-white mb-2"
    }, ["Notifications"]), __jacJsx("p", {
      "className": "text-gray-400"
    }, ["You have ", unreadCount, " new notifications."])]), unreadCount > 0 && __jacJsx("button", {
      "onClick": function onClick(e) {
        var updatedNotifications = notifications.map(function (n) {
          return {
            id: n.id,
            "key": n.type,
            title: n.title,
            description: n.description,
            time: n.time,
            read: true
          };
        });
        setNotifications(updatedNotifications);
      },
      "className": "px-6 py-3 bg-[#101010ff] text-white rounded-lg hover:bg-[#1a1a1a] transition-all border border-gray-700 cursor-pointer font-semibold"
    }, ["Mark all as read"])]), __jacJsx("div", {
      "className": "rounded-lg"
    }, [notifications.map(function (notification) {
      var iconBg = notification.type === "message" ? "bg-orange-500" : notification.type === "event" ? "bg-blue-500" : notification.type === "success" ? "bg-green-500" : "bg-yellow-500";
      var isUnread = notification.read === false;
      return __jacJsx("div", {
        "key": notification.id,
        "className": "border-b border-gray-800 last:border-b-0 p-6 hover:bg-[#0b0b0b] transition-all cursor-pointer",
        "onClick": function onClick(e) {
          setSelectedNotification(notification);
          if (isUnread) {
            var updatedNotifications = notifications.map(function (n) {
              if (n.id === notification.id) {
                return {
                  id: n.id,
                  "key": n.type,
                  title: n.title,
                  description: n.description,
                  time: n.time,
                  read: true
                };
              }
              return n;
            });
            setNotifications(updatedNotifications);
          }
        }
      }, [__jacJsx("div", {
        "className": "flex items-start gap-4"
      }, [__jacJsx("div", {
        "className": "w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0 " + iconBg
      }, [notification.type === "message" && __jacJsx("svg", {
        "className": "w-6 h-6 text-white",
        "fill": "none",
        "stroke": "currentColor",
        "viewBox": "0 0 24 24"
      }, [__jacJsx("path", {
        "strokeLinecap": "round",
        "strokeLinejoin": "round",
        "strokeWidth": 2,
        "d": "M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"
      }, [])]), notification.type === "event" && __jacJsx("svg", {
        "className": "w-6 h-6 text-white",
        "fill": "none",
        "stroke": "currentColor",
        "viewBox": "0 0 24 24"
      }, [__jacJsx("path", {
        "strokeLinecap": "round",
        "strokeLinejoin": "round",
        "strokeWidth": 2,
        "d": "M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
      }, [])]), notification.type === "success" && __jacJsx("svg", {
        "className": "w-6 h-6 text-white",
        "fill": "none",
        "stroke": "currentColor",
        "viewBox": "0 0 24 24"
      }, [__jacJsx("path", {
        "strokeLinecap": "round",
        "strokeLinejoin": "round",
        "strokeWidth": 2,
        "d": "M5 13l4 4L19 7"
      }, [])]), notification.type === "warning" && __jacJsx("svg", {
        "className": "w-6 h-6 text-white",
        "fill": "none",
        "stroke": "currentColor",
        "viewBox": "0 0 24 24"
      }, [__jacJsx("path", {
        "strokeLinecap": "round",
        "strokeLinejoin": "round",
        "strokeWidth": 2,
        "d": "M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"
      }, [])])]), __jacJsx("div", {
        "className": "flex-1 min-w-0"
      }, [__jacJsx("div", {
        "className": "flex items-start justify-between gap-4 mb-1"
      }, [__jacJsx("h3", {
        "className": "text-white font-semibold flex items-center gap-2"
      }, [notification.title, isUnread && __jacJsx("span", {
        "className": "w-2 h-2 bg-primary rounded-full"
      }, [])]), __jacJsx("span", {
        "className": "text-gray-400 text-sm flex-shrink-0"
      }, [notification.time])]), __jacJsx("p", {
        "className": "text-gray-400 text-sm line-clamp-2"
      }, [notification.description])])])]);
    })])])]), activeLink === "skills" && __jacJsx(SelectionManager, {
      "title": "Select Your Skills",
      "description": "Choose or add your skills",
      "placeholder": "Search or type a skill and press Enter",
      "selectedLabel": "Selected Skills",
      "availableLabel": "Available Skills",
      "availableItems": devSkills,
      "selectedItems": selectedSkills,
      "setSelectedItems": setSelectedSkills,
      "onSave": function onSave() {}
    }, []), activeLink === "roles" && __jacJsx(SelectionManager, {
      "title": "Select Your Roles",
      "description": "Choose or add your target roles",
      "placeholder": "Search or type a role and press Enter",
      "selectedLabel": "Selected Roles",
      "availableLabel": "Available Roles",
      "availableItems": devRoles,
      "selectedItems": selectedRoles,
      "setSelectedItems": setSelectedRoles,
      "onSave": function onSave() {}
    }, []), activeLink === "roadmap" && __jacJsx("div", {}, [__jacJsx("h1", {
      "className": "text-2xl md:text-3xl font-bold text-white mb-6"
    }, ["My Roadmap"]), __jacJsx("p", {
      "className": "text-gray-400"
    }, ["Your personalized learning path"])]), activeLink === "quizzes" && __jacJsx("div", {}, [__jacJsx("h1", {
      "className": "text-2xl md:text-3xl font-bold text-white mb-6"
    }, ["Quizzes"]), __jacJsx("p", {
      "className": "text-gray-400"
    }, ["Test your knowledge"])])]);
  }
  return __jacJsx("div", {
    "className": "min-h-screen bg-black"
  }, [sidebarOpen && __jacJsx("div", {
    "onClick": function onClick(e) {
      setSidebarOpen(false);
    },
    "className": "fixed inset-0 bg-black bg-opacity-50 z-[99999] lg:hidden"
  }, []), profileOpen && __jacJsx("div", {
    "onClick": function onClick(e) {
      setProfileOpen(false);
    },
    "className": "fixed inset-0 bg-black bg-opacity-50 z-[99999] lg:hidden"
  }, []), __jacJsx(DashSideBar, {}, []), __jacJsx(MobileDashSideBar, {}, []), __jacJsx("div", {
    "className": "md:ml-64 lg:mr-80 min-h-screen"
  }, [__jacJsx(DashHeader, {}, []), __jacJsx("div", {
    "className": "pt-16 lg:pt-0"
  }, [__jacJsx(DashContent, {}, [])])]), __jacJsx("div", {
    "className": "hidden lg:block fixed top-0 right-0"
  }, [__jacJsx(ProfilePanel, {}, [])]), __jacJsx(MobileProfilePanel, {}, [])]);
}
export { Dashboard };