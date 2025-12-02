function _regenerator() { /*! regenerator-runtime -- Copyright (c) 2014-present, Facebook, Inc. -- license (MIT): https://github.com/babel/babel/blob/main/packages/babel-helpers/LICENSE */ var e, t, r = "function" == typeof Symbol ? Symbol : {}, n = r.iterator || "@@iterator", o = r.toStringTag || "@@toStringTag"; function i(r, n, o, i) { var c = n && n.prototype instanceof Generator ? n : Generator, u = Object.create(c.prototype); return _regeneratorDefine2(u, "_invoke", function (r, n, o) { var i, c, u, f = 0, p = o || [], y = !1, G = { p: 0, n: 0, v: e, a: d, f: d.bind(e, 4), d: function d(t, r) { return i = t, c = 0, u = e, G.n = r, a; } }; function d(r, n) { for (c = r, u = n, t = 0; !y && f && !o && t < p.length; t++) { var o, i = p[t], d = G.p, l = i[2]; r > 3 ? (o = l === n) && (u = i[(c = i[4]) ? 5 : (c = 3, 3)], i[4] = i[5] = e) : i[0] <= d && ((o = r < 2 && d < i[1]) ? (c = 0, G.v = n, G.n = i[1]) : d < l && (o = r < 3 || i[0] > n || n > l) && (i[4] = r, i[5] = n, G.n = l, c = 0)); } if (o || r > 1) return a; throw y = !0, n; } return function (o, p, l) { if (f > 1) throw TypeError("Generator is already running"); for (y && 1 === p && d(p, l), c = p, u = l; (t = c < 2 ? e : u) || !y;) { i || (c ? c < 3 ? (c > 1 && (G.n = -1), d(c, u)) : G.n = u : G.v = u); try { if (f = 2, i) { if (c || (o = "next"), t = i[o]) { if (!(t = t.call(i, u))) throw TypeError("iterator result is not an object"); if (!t.done) return t; u = t.value, c < 2 && (c = 0); } else 1 === c && (t = i["return"]) && t.call(i), c < 2 && (u = TypeError("The iterator does not provide a '" + o + "' method"), c = 1); i = e; } else if ((t = (y = G.n < 0) ? u : r.call(n, G)) !== a) break; } catch (t) { i = e, c = 1, u = t; } finally { f = 1; } } return { value: t, done: y }; }; }(r, o, i), !0), u; } var a = {}; function Generator() {} function GeneratorFunction() {} function GeneratorFunctionPrototype() {} t = Object.getPrototypeOf; var c = [][n] ? t(t([][n]())) : (_regeneratorDefine2(t = {}, n, function () { return this; }), t), u = GeneratorFunctionPrototype.prototype = Generator.prototype = Object.create(c); function f(e) { return Object.setPrototypeOf ? Object.setPrototypeOf(e, GeneratorFunctionPrototype) : (e.__proto__ = GeneratorFunctionPrototype, _regeneratorDefine2(e, o, "GeneratorFunction")), e.prototype = Object.create(u), e; } return GeneratorFunction.prototype = GeneratorFunctionPrototype, _regeneratorDefine2(u, "constructor", GeneratorFunctionPrototype), _regeneratorDefine2(GeneratorFunctionPrototype, "constructor", GeneratorFunction), GeneratorFunction.displayName = "GeneratorFunction", _regeneratorDefine2(GeneratorFunctionPrototype, o, "GeneratorFunction"), _regeneratorDefine2(u), _regeneratorDefine2(u, o, "Generator"), _regeneratorDefine2(u, n, function () { return this; }), _regeneratorDefine2(u, "toString", function () { return "[object Generator]"; }), (_regenerator = function _regenerator() { return { w: i, m: f }; })(); }
function _regeneratorDefine2(e, r, n, t) { var i = Object.defineProperty; try { i({}, "", {}); } catch (e) { i = 0; } _regeneratorDefine2 = function _regeneratorDefine(e, r, n, t) { function o(r, n) { _regeneratorDefine2(e, r, function (e) { return this._invoke(r, n, e); }); } r ? i ? i(e, r, { value: n, enumerable: !t, configurable: !t, writable: !t }) : e[r] = n : (o("next", 0), o("throw", 1), o("return", 2)); }, _regeneratorDefine2(e, r, n, t); }
function asyncGeneratorStep(n, t, e, r, o, a, c) { try { var i = n[a](c), u = i.value; } catch (n) { return void e(n); } i.done ? t(u) : Promise.resolve(u).then(r, o); }
function _asyncToGenerator(n) { return function () { var t = this, e = arguments; return new Promise(function (r, o) { var a = n.apply(t, e); function _next(n) { asyncGeneratorStep(a, r, o, _next, _throw, "next", n); } function _throw(n) { asyncGeneratorStep(a, r, o, _next, _throw, "throw", n); } _next(void 0); }); }; }
function _slicedToArray(r, e) { return _arrayWithHoles(r) || _iterableToArrayLimit(r, e) || _unsupportedIterableToArray(r, e) || _nonIterableRest(); }
function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }
function _unsupportedIterableToArray(r, a) { if (r) { if ("string" == typeof r) return _arrayLikeToArray(r, a); var t = {}.toString.call(r).slice(8, -1); return "Object" === t && r.constructor && (t = r.constructor.name), "Map" === t || "Set" === t ? Array.from(r) : "Arguments" === t || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(t) ? _arrayLikeToArray(r, a) : void 0; } }
function _arrayLikeToArray(r, a) { (null == a || a > r.length) && (a = r.length); for (var e = 0, n = Array(a); e < a; e++) n[e] = r[e]; return n; }
function _iterableToArrayLimit(r, l) { var t = null == r ? null : "undefined" != typeof Symbol && r[Symbol.iterator] || r["@@iterator"]; if (null != t) { var e, n, i, u, a = [], f = !0, o = !1; try { if (i = (t = t.call(r)).next, 0 === l) { if (Object(t) !== t) return; f = !1; } else for (; !(f = (e = i.call(t)).done) && (a.push(e.value), a.length !== l); f = !0); } catch (r) { o = !0, n = r; } finally { try { if (!f && null != t["return"] && (u = t["return"](), Object(u) !== u)) return; } finally { if (o) throw n; } } return a; } }
function _arrayWithHoles(r) { if (Array.isArray(r)) return r; }
import { __jacJsx, __jacSpawn } from "@jac-client/utils";
import { useState, useEffect } from "react";
import { Brain, CloudUpload, Goal, Route as Node, ChevronLeft } from "lucide-react";
import { fileToBase64 } from "../fileutils.js";
import { useNavigate } from "@jac-client/utils";
function Onboarding() {
  var _useState = useState(1),
    _useState2 = _slicedToArray(_useState, 2),
    currentStep = _useState2[0],
    setCurrentStep = _useState2[1];
  var _useState3 = useState(0),
    _useState4 = _slicedToArray(_useState3, 2),
    stepCompleted = _useState4[0],
    setStepCompleted = _useState4[1];
  var _useState5 = useState(""),
    _useState6 = _slicedToArray(_useState5, 2),
    navbtnHover = _useState6[0],
    setNavBtnHover = _useState6[1];
  var _useState7 = useState(25),
    _useState8 = _slicedToArray(_useState7, 2),
    progress = _useState8[0],
    setProgress = _useState8[1];
  var _useState9 = useState(false),
    _useState0 = _slicedToArray(_useState9, 2),
    resumeHover = _useState0[0],
    setResumeHover = _useState0[1];
  var _useState1 = useState([]),
    _useState10 = _slicedToArray(_useState1, 2),
    selectedInterests = _useState10[0],
    setSelectedInterests = _useState10[1];
  var _useState11 = useState([]),
    _useState12 = _slicedToArray(_useState11, 2),
    selectedRoles = _useState12[0],
    setSelectedRoles = _useState12[1];
  var _useState13 = useState([]),
    _useState14 = _slicedToArray(_useState13, 2),
    suggestedRoles = _useState14[0],
    setSuggestedRoles = _useState14[1];
  var _useState15 = useState(false),
    _useState16 = _slicedToArray(_useState15, 2),
    dragActive = _useState16[0],
    setDragActive = _useState16[1];
  var _useState17 = useState(""),
    _useState18 = _slicedToArray(_useState17, 2),
    fileName = _useState18[0],
    setFileName = _useState18[1];
  var _useState19 = useState(null),
    _useState20 = _slicedToArray(_useState19, 2),
    file = _useState20[0],
    setFile = _useState20[1];
  var _useState21 = useState(""),
    _useState22 = _slicedToArray(_useState21, 2),
    error = _useState22[0],
    setError = _useState22[1];
  var _useState23 = useState(false),
    _useState24 = _slicedToArray(_useState23, 2),
    canProceed = _useState24[0],
    setCanProceed = _useState24[1];
  var _useState25 = useState(false),
    _useState26 = _slicedToArray(_useState25, 2),
    isLoading = _useState26[0],
    setIsLoading = _useState26[1];
  var navigate = useNavigate();
  var devSkills = ["JavaScript", "Python", "React", "Node.js", "TypeScript", "HTML & CSS", "Django", "Flutter", "Git & GitHub", "SQL & Databases", "REST APIs", "GraphQL", "Docker", "Agile & Scrum"];
  var devRoles = ["Frontend Developer", "Backend Developer", "Fullstack Developer", "Mobile Developer", "DevOps Engineer", "UI/UX Designer", "Data Scientist", "Machine Learning Engineer"];
  useEffect(function () {
    var percent = currentStep / 4 * 100;
    setProgress(percent + "%");
  }, [currentStep]);
  var steps = [{
    id: 1,
    title: "Upload Your CV",
    description: "Let our AI analyze your experience and extract your current skills.",
    icon: __jacJsx(CloudUpload, {
      "style": {
        "fontSize": "0.75rem"
      }
    }, []),
    completed: false
  }, {
    id: 2,
    title: "Review & Update Skills",
    description: "Confirm AI-detected skills and add any we might have missed.",
    icon: __jacJsx(Brain, {
      "style": {
        "fontSize": "0.75rem"
      }
    }, []),
    completed: false
  }, {
    id: 3,
    title: "Set Career Goals",
    description: "Choose your target roles, industries, and career aspirations.",
    icon: __jacJsx(Goal, {
      "style": {
        "fontSize": "0.75rem"
      }
    }, []),
    completed: false
  }, {
    id: 4,
    title: "Get Your Roadmap",
    description: "Explore your personalized learning path and skill gap analysis.",
    icon: __jacJsx(Node, {
      "style": {
        "fontSize": "0.75rem"
      }
    }, []),
    completed: false
  }];
  function handleFileSelect(e) {
    var pickedFile = e.target.files[0];
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
      var droppedFile = e.dataTransfer.files[0];
      setFileName(droppedFile.name);
      setFile(droppedFile);
      e.dataTransfer.clearData();
      setError("");
      setCanProceed(true);
    }
  }
  function handleStep1Next() {
    return _handleStep1Next.apply(this, arguments);
  }
  function _handleStep1Next() {
    _handleStep1Next = _asyncToGenerator(/*#__PURE__*/_regenerator().m(function _callee() {
      var base64Data, result, user_skills, body, detected_skills, detected_interests, detected_certs, _t;
      return _regenerator().w(function (_context) {
        while (1) switch (_context.p = _context.n) {
          case 0:
            if (!(!canProceed || !file)) {
              _context.n = 1;
              break;
            }
            return _context.a(2);
          case 1:
            _context.p = 1;
            _context.n = 2;
            return __jacSpawn("create_resume_node", "", {});
          case 2:
            _context.n = 3;
            return fileToBase64(file);
          case 3:
            base64Data = _context.v;
            _context.n = 4;
            return __jacSpawn("upload_resume", "", {
              "file": base64Data,
              "name": file.name,
              "mime": file.type
            });
          case 4:
            result = _context.v;
            if (result) {
              _context.n = 5;
              break;
            }
            console.log("Failed");
            return _context.a(2);
          case 5:
            _context.n = 6;
            return __jacSpawn("save_resume", "", {});
          case 6:
            _context.n = 7;
            return __jacSpawn("update_resume_upload_status", "", {});
          case 7:
            _context.n = 8;
            return __jacSpawn("analyze_cv", "", {});
          case 8:
            user_skills = _context.v;
            if (!(!user_skills || !user_skills.reports || user_skills.reports.length === 0)) {
              _context.n = 9;
              break;
            }
            console.log("Failed");
            return _context.a(2);
          case 9:
            if (!(user_skills.reports[0]["status"] !== "Success")) {
              _context.n = 10;
              break;
            }
            console.log("Failed");
            return _context.a(2);
          case 10:
            try {
              body = "body" in user_skills.reports[0] ? user_skills.reports[0]["body"] : {};
              detected_skills = "skills" in body ? body["skills"] : [];
              detected_interests = "interests" in body ? body["interests"] : [];
              detected_certs = "certifications" in body ? body["certifications"] : [];
              setSelectedInterests(detected_skills);
            } catch (e) {
              console.log(e);
            }
            setCurrentStep(2);
            _context.n = 12;
            break;
          case 11:
            _context.p = 11;
            _t = _context.v;
            console.log(_t);
          case 12:
            _context.p = 12;
            setIsLoading(false);
            return _context.f(12);
          case 13:
            return _context.a(2);
        }
      }, _callee, null, [[1, 11, 12, 13]]);
    }));
    return _handleStep1Next.apply(this, arguments);
  }
  function handleStep2Next() {
    return _handleStep2Next.apply(this, arguments);
  }
  function _handleStep2Next() {
    _handleStep2Next = _asyncToGenerator(/*#__PURE__*/_regenerator().m(function _callee2() {
      var result, rolesReport, latestReport, _t2;
      return _regenerator().w(function (_context2) {
        while (1) switch (_context2.p = _context2.n) {
          case 0:
            _context2.p = 0;
            _context2.n = 1;
            return __jacSpawn("update_user_profile", "", {
              "updated_skills": selectedInterests
            });
          case 1:
            result = _context2.v;
            if (!result) {
              _context2.n = 3;
              break;
            }
            _context2.n = 2;
            return __jacSpawn("generate_role_suggestions", "", {});
          case 2:
            rolesReport = _context2.v;
            latestReport = rolesReport.reports[rolesReport.reports.length - 1];
            if (latestReport.status === "Success") {
              setSuggestedRoles(latestReport.body);
            } else {
              console.log("Failed to generate role suggestions: " + latestReport.message || "Unknown error");
            }
            setCurrentStep(3);
            _context2.n = 4;
            break;
          case 3:
            console.log("Failed to save profile. Please try again.");
          case 4:
            _context2.n = 6;
            break;
          case 5:
            _context2.p = 5;
            _t2 = _context2.v;
            console.log(_t2);
          case 6:
            _context2.p = 6;
            setIsLoading(false);
            return _context2.f(6);
          case 7:
            return _context2.a(2);
        }
      }, _callee2, null, [[0, 5, 6, 7]]);
    }));
    return _handleStep2Next.apply(this, arguments);
  }
  function Step(props) {
    var circleBase = "w-[40px] aspect-square rounded-full flex items-center justify-center relative z-10 transition-all duration-200 text-white";
    var circleShadow = props.step.id === currentStep ? "shadow-[0_0_20px_rgba(110,17,176,0.5)]" : "";
    var circleBg = props.step.id <= currentStep ? "bg-purple-800" : "bg-black";
    var lineBase = "absolute left-1/2 top-full -translate-x-1 z-[-1] h-[calc(100%+65px)] w-[2px] transition-all duration-200";
    var lineColor = props.step.id < currentStep ? "border-l-2 border-dashed border-purple-800" : "border-l-2 border-dashed border-gray-400";
    var titleBase = "mb-0 font-semibold text-[1.15rem]";
    var titleColor = props.step.id <= currentStep ? "text-white" : "text-whitesmoke";
    return __jacJsx("div", {
      "className": "flex flex-row gap-9 items-center w-3/4 mx-auto mb-[45px]"
    }, [__jacJsx("div", {
      "className": circleBase + " " + circleShadow + " " + circleBg
    }, [__jacJsx("div", {
      "className": "flex items-center justify-center relative w-full h-full"
    }, [props.step.icon, props.step.id !== 4 && __jacJsx("div", {
      "className": lineBase + " " + lineColor
    }, [])])]), __jacJsx("div", {}, [__jacJsx("h1", {
      "className": titleBase + " " + titleColor
    }, [props.step.title]), __jacJsx("p", {
      "className": "text-gray-400 mt-2 mb-0"
    }, [props.step.description])])]);
  }
  function Skills(props) {
    var _useState27 = useState(""),
      _useState28 = _slicedToArray(_useState27, 2),
      inputValue = _useState28[0],
      setInputValue = _useState28[1];
    return __jacJsx("div", {
      "className": "h-[60vh] w-full"
    }, [__jacJsx("div", {
      "className": "mb-0 font-semibold text-white text-[1.15rem]"
    }, ["Select Your Skills"]), __jacJsx("p", {
      "className": "text-gray-500 my-0 mt-[10px] mb-6"
    }, ["Choose or add your skills"]), __jacJsx("div", {
      "className": "relative mb-6"
    }, [__jacJsx("input", {
      "type": "text",
      "placeholder": "Search or type a skill and press Enter",
      "value": inputValue,
      "onChange": function onChange(e) {
        setInputValue(e.target.value);
      },
      "onKeyDown": function onKeyDown(e) {
        if (e.key === "Enter" && inputValue.trim() !== "") {
          var alreadySelected = props.selectedInterests.includes(inputValue.trim());
          if (alreadySelected === false) {
            var newSelected = props.selectedInterests.concat([inputValue.trim()]);
            props.setSelectedInterests(newSelected);
          }
          setInputValue("");
        }
      },
      "className": "w-full px-4 py-3 pl-10 bg-[#101010ff] border border-gray-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-[#6e11b0] transition-colors"
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
    }, [])])]), props.selectedInterests.length > 0 && __jacJsx("div", {
      "className": "mb-6"
    }, [__jacJsx("div", {
      "className": "text-gray-400 text-sm mb-2"
    }, ["Selected Skills"]), __jacJsx("div", {
      "className": "flex flex-wrap gap-2"
    }, [props.selectedInterests.map(function (skill) {
      return __jacJsx("div", {
        "key": skill,
        "className": "bg-primary text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer flex items-center gap-2 hover:bg-opacity-80 transition-all"
      }, [skill, __jacJsx("svg", {
        "onClick": function onClick(e) {
          props.setSelectedInterests(props.selectedInterests.filter(function (i) {
            return i !== skill;
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
    })])])]);
  }
  function Roles(props) {
    var _useState29 = useState(""),
      _useState30 = _slicedToArray(_useState29, 2),
      inputValue = _useState30[0],
      setInputValue = _useState30[1];
    return __jacJsx("div", {
      "className": "h-[60vh] w-full"
    }, [__jacJsx("div", {
      "className": "mb-0 font-semibold text-white text-[1.15rem]"
    }, ["Select Your Roles"]), __jacJsx("p", {
      "className": "text-gray-500 my-0 mt-[10px] mb-6"
    }, ["Choose or add your roles"]), __jacJsx("div", {
      "className": "relative mb-6"
    }, [__jacJsx("input", {
      "type": "text",
      "placeholder": "Search or type a role and press Enter",
      "value": inputValue,
      "onChange": function onChange(e) {
        setInputValue(e.target.value);
      },
      "onKeyDown": function onKeyDown(e) {
        if (e.key === "Enter" && inputValue.trim() !== "") {
          var alreadySelected = props.selectedRoles.includes(inputValue.trim());
          if (alreadySelected === false) {
            var newSelected = props.selectedRoles.concat([inputValue.trim()]);
            props.setSelectedRoles(newSelected);
          }
          setInputValue("");
        }
      },
      "className": "w-full px-4 py-3 pl-10 bg-[#101010ff] border border-gray-700 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-[#6e11b0] transition-colors"
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
    }, [])])]), props.selectedRoles.length > 0 && __jacJsx("div", {
      "className": "mb-6"
    }, [__jacJsx("div", {
      "className": "text-gray-400 text-sm mb-2"
    }, ["Selected Roles"]), __jacJsx("div", {
      "className": "flex flex-wrap gap-2"
    }, [props.selectedRoles.map(function (role) {
      return __jacJsx("div", {
        "key": role,
        "className": "bg-primary text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer flex items-center gap-2 hover:bg-opacity-80 transition-all"
      }, [role, __jacJsx("svg", {
        "onClick": function onClick(e) {
          props.setSelectedRoles(props.selectedRoles.filter(function (i) {
            return i !== role;
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
    })])]), __jacJsx("div", {}, [__jacJsx("div", {
      "className": "text-gray-400 text-sm mb-2"
    }, ["Available Roles"]), __jacJsx("div", {
      "className": "flex flex-wrap gap-2 overflow-y-auto md:max-h-[25vh]"
    }, [props.suggestedRoles.map(function (role, index) {
      var isSelected = props.selectedRoles.includes(role.title);
      if (isSelected === false) {
        return __jacJsx("div", {
          "key": index,
          "onClick": function onClick(e) {
            var newSelected = props.selectedRoles.concat([role.title]);
            props.setSelectedRoles(newSelected);
          },
          "className": "border border-gray-500 text-white px-4 py-2 rounded-full text-sm font-medium cursor-pointer transition-all hover:border-[#6e11b0] hover:bg-[#0b0b0b]"
        }, [role.title]);
      }
      return null;
    })])])]);
  }
  function LoadingDots() {
    return __jacJsx("div", {
      "style": {
        "display": "flex",
        "justifyContent": "center",
        "alignItems": "center",
        "gap": "6px",
        "height": "20px"
      }
    }, [__jacJsx("span", {
      "className": "loading-dot"
    }, []), __jacJsx("span", {
      "className": "loading-dot"
    }, []), __jacJsx("span", {
      "className": "loading-dot"
    }, [])]);
  }
  return __jacJsx("div", {
    "className": "w-full bg-black h-screen grid grid-cols-[100%} md:grid-cols-[45%_55%] relative text-white"
  }, [__jacJsx("div", {
    "className": "hidden w-full h-full md:flex justify-center items-center"
  }, [__jacJsx("div", {
    "className": "m-auto bg-[#0b0b0b] w-[95%] h-[90%] z-[9999] rounded-[10px] flex flex-col justify-center items-center overflow-hidden"
  }, [steps.map(function (step) {
    return __jacJsx(Step, {
      "key": step.id,
      "step": step,
      "isActive": currentStep === step.id
    }, []);
  }), "   "])]), __jacJsx("div", {
    "className": "w-full h-[95%] my-auto flex justify-center items-center"
  }, [__jacJsx("div", {
    "className": "w-[90%] h-[90%] flex flex-col justify-center"
  }, [__jacJsx("div", {
    "className": "text-gray-500 uppercase"
  }, ["Step ", currentStep, " of 4"]), __jacJsx("div", {
    "className": "w-full md:w-[80%] h-[11px] rounded-[20px] bg-[#0b0b0b] overflow-hidden my-5"
  }, [__jacJsx("div", {
    "style": {
      "height": "100%",
      "width": progress,
      "backgroundColor": "#6e11b0",
      "transition": "0.3s ease",
      "borderRadius": "20px"
    }
  }, [])]), currentStep === 1 && __jacJsx("div", {
    "className": "h-[60vh]"
  }, [__jacJsx("div", {
    "className": "mb-0 font-semibold text-white text-[1.15rem]"
  }, ["Upload your CV"]), __jacJsx("p", {
    "className": "text-gray-500 my-0 mt-[10px]"
  }, ["Let us start by understanding your background"]), __jacJsx("div", {
    "onDragOver": handleDragOver,
    "onDragLeave": handleDragLeave,
    "onDrop": handleDrop,
    "className": "my-[30px] h-[40vh] w-full md:w-[80%] rounded-[15px] flex flex-col justify-center items-center border-2 border-dashed border-gray-500 bg-[#0b0b0b] md:bg-[#101010ff] hover:border-[#6e11b0] hover:bg-[#0b0b0b] transition-all duration-200"
  }, [__jacJsx("div", {
    "className": "w-[55px] aspect-square rounded-full bg-black flex items-center justify-center mb-[15px]"
  }, [__jacJsx(CloudUpload, {
    "className": "text-[0.75rem] text-[#6e11b0]"
  }, [])]), __jacJsx("p", {
    "className": "text-gray-500 my-0 my-5 text-[.9em]"
  }, ["Supported formats: PDF, DOC, DOCX (Max 5MB)"]), __jacJsx("div", {}, []), __jacJsx("input", {
    "type": "file",
    "accept": ".pdf,.doc,.docx",
    "onChange": handleFileSelect,
    "className": "hidden",
    "id": "resumeInput"
  }, []), __jacJsx("label", {
    "for": "resumeInput",
    "className": "w-auto px-6 py-4 border-none rounded-lg bg-[#6e11b0] text-white font-semibold text-sm cursor-pointer transition-all duration-200 mt-[10px] shadow-[0_0_20px_rgba(110,17,176,0.2)]"
  }, ["Upload from Computer"]), fileName && __jacJsx("p", {
    "className": "mt-5 text-sm text-white font-medium"
  }, ["Uploaded: ", fileName])])]), currentStep === 2 && __jacJsx(Skills, {
    "interests": devSkills,
    "selectedInterests": selectedInterests,
    "setSelectedInterests": setSelectedInterests
  }, []), currentStep === 3 && __jacJsx(Roles, {
    "suggestedRoles": suggestedRoles,
    "selectedRoles": selectedRoles,
    "setSelectedRoles": setSelectedRoles
  }, []), currentStep === 4 && __jacJsx("div", {
    "className": "h-[60vh] flex flex-col justify-center items-center text-center"
  }, [__jacJsx("div", {
    "className": "mb-0 font-semibold text-white text-[2rem] mb-4"
  }, ["You're All Set! 🎉"]), __jacJsx("p", {
    "className": "text-gray-400 text-lg max-w-[500px] mb-8"
  }, ["Your personalized career roadmap is ready. We've analyzed your skills, mapped them to your target roles, and created a custom learning path just for you."]), __jacJsx("div", {
    "className": "flex flex-col gap-4 mb-8"
  }, [__jacJsx("div", {
    "className": "flex items-center gap-3 text-gray-300"
  }, [__jacJsx("div", {
    "className": "w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center"
  }, [__jacJsx("svg", {
    "className": "w-4 h-4 text-white",
    "fill": "none",
    "stroke": "currentColor",
    "viewBox": "0 0 24 24"
  }, [__jacJsx("path", {
    "strokeLinecap": "round",
    "strokeLinejoin": "round",
    "strokeWidth": 2,
    "d": "M5 13l4 4L19 7"
  }, [])])]), __jacJsx("span", {}, ["Skills analyzed and mapped"])]), __jacJsx("div", {
    "className": "flex items-center gap-3 text-gray-300"
  }, [__jacJsx("div", {
    "className": "w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center"
  }, [__jacJsx("svg", {
    "className": "w-4 h-4 text-white",
    "fill": "none",
    "stroke": "currentColor",
    "viewBox": "0 0 24 24"
  }, [__jacJsx("path", {
    "strokeLinecap": "round",
    "strokeLinejoin": "round",
    "strokeWidth": 2,
    "d": "M5 13l4 4L19 7"
  }, [])])]), __jacJsx("span", {}, ["Career goals identified"])]), __jacJsx("div", {
    "className": "flex items-center gap-3 text-gray-300"
  }, [__jacJsx("div", {
    "className": "w-6 h-6 rounded-full bg-[#6e11b0] flex items-center justify-center"
  }, [__jacJsx("svg", {
    "className": "w-4 h-4 text-white",
    "fill": "none",
    "stroke": "currentColor",
    "viewBox": "0 0 24 24"
  }, [__jacJsx("path", {
    "strokeLinecap": "round",
    "strokeLinejoin": "round",
    "strokeWidth": 2,
    "d": "M5 13l4 4L19 7"
  }, [])])]), __jacJsx("span", {}, ["Personalized roadmap generated"])])]), __jacJsx("p", {
    "className": "text-gray-500 text-sm mt-6"
  }, ["Ready to start your career transformation?"])]), __jacJsx("div", {
    "className": "flex flex-row gap-[25px] items-center"
  }, [currentStep > 1 && __jacJsx("div", {
    "onClick": function onClick(e) {
      setCurrentStep(currentStep - 1);
    },
    "className": "flex flex-row items-center cursor-pointer"
  }, [" ", __jacJsx(ChevronLeft, {}, []), "Back"]), __jacJsx("button", {
    "type": "button",
    "onClick": function onClick(e) {
      if (currentStep < 4) {
        setIsLoading(true);
        if (currentStep === 1) {
          handleStep1Next();
        } else if (currentStep === 2) {
          handleStep2Next();
        } else if (currentStep === 3) {}
      } else {
        navigate("/dashboard");
      }
    },
    "disabled": isLoading,
    "className": "w-[180px] bg-[#6e11b0] text-white border-none px-10 py-4 rounded-[5px] cursor-pointer text-base transition-transform duration-200 hover:translate-y-1 disabled:opacity-50 disabled:cursor-not-allowed"
  }, ["   ", isLoading ? LoadingDots() : currentStep === 4 ? "Get Started" : "Next"])])])])]);
}
export { Onboarding };