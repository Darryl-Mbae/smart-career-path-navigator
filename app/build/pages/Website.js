function _slicedToArray(r, e) { return _arrayWithHoles(r) || _iterableToArrayLimit(r, e) || _unsupportedIterableToArray(r, e) || _nonIterableRest(); }
function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }
function _unsupportedIterableToArray(r, a) { if (r) { if ("string" == typeof r) return _arrayLikeToArray(r, a); var t = {}.toString.call(r).slice(8, -1); return "Object" === t && r.constructor && (t = r.constructor.name), "Map" === t || "Set" === t ? Array.from(r) : "Arguments" === t || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(t) ? _arrayLikeToArray(r, a) : void 0; } }
function _arrayLikeToArray(r, a) { (null == a || a > r.length) && (a = r.length); for (var e = 0, n = Array(a); e < a; e++) n[e] = r[e]; return n; }
function _iterableToArrayLimit(r, l) { var t = null == r ? null : "undefined" != typeof Symbol && r[Symbol.iterator] || r["@@iterator"]; if (null != t) { var e, n, i, u, a = [], f = !0, o = !1; try { if (i = (t = t.call(r)).next, 0 === l) { if (Object(t) !== t) return; f = !1; } else for (; !(f = (e = i.call(t)).done) && (a.push(e.value), a.length !== l); f = !0); } catch (r) { o = !0, n = r; } finally { try { if (!f && null != t["return"] && (u = t["return"](), Object(u) !== u)) return; } finally { if (o) throw n; } } return a; } }
function _arrayWithHoles(r) { if (Array.isArray(r)) return r; }
import { __jacJsx, __jacSpawn } from "@jac-client/utils";
import { useState } from "react";
import { useNavigate } from "@jac-client/utils";
function Website() {
  var _useState = useState(false),
    _useState2 = _slicedToArray(_useState, 2),
    sideBarActive = _useState2[0],
    setSideBarActivate = _useState2[1];
  function NavBar(props) {
    var links = ["CHANGELOG", "PRICING", "FAQs", "RESOURCES"];
    var navigate = useNavigate();
    function MobileNav() {
      return __jacJsx("div", {
        "className": "flex md:hidden items-center justify-between text-white"
      }, [__jacJsx("a", {
        "href": "/app",
        "className": "text-[1.125rem] font-semibold cursor-pointer text-white no-underline"
      }, ["Arise"]), __jacJsx("button", {
        "onClick": function onClick(e) {
          props.setSideBarActivate(props.sideBarActive ? false : true);
        },
        "type": "button"
      }, [])]);
    }
    function DesktopNav() {
      return __jacJsx("div", {
        "className": "hidden md:flex  items-center justify-between text-white "
      }, [__jacJsx("a", {
        "href": "/app",
        "className": "text-[1.125rem] font-semibold cursor-pointer text-white no-underline"
      }, ["Arise"]), __jacJsx("div", {
        "className": "flex items-center gap-[2rem]"
      }, [__jacJsx("ul", {
        "className": "relative z-10 flex items-center gap-[10px] list-none"
      }, [links.map(function (link) {
        return __jacJsx("li", {
          "key": link,
          "className": "relative text-[14px] cursor-pointer px-2 py-1 rounded-[4px]"
        }, [link]);
      })]), __jacJsx("button", {
        "onClick": function onClick(e) {
          navigate("/auth");
        },
        "className": "w-auto bg-primary text-white border-none cursor-pointer text-[16px] px-10 py-4 rounded-[5px] transition-transform duration-200 ease-in-out hover:translate-y-1"
      }, ["Get Started"])])]);
    }
    return __jacJsx("div", {
      "className": "sticky top-4 z-[99999] w-[calc(92%-6px)] mx-auto py-4 px-6 rounded-md transition-all duration-200 bg-[rgba(0,0,0,.5)] backdrop-blur-[12px] border border-transparent"
    }, [__jacJsx(MobileNav, {}, []), __jacJsx(DesktopNav, {}, [])]);
  }
  function Sidebar(props) {
    return __jacJsx("div", {}, []);
  }
  function Homepage() {
    var _useState3 = useState(false),
      _useState4 = _slicedToArray(_useState3, 2),
      btn1Hover = _useState4[0],
      setBtn1Hover = _useState4[1];
    var _useState5 = useState(false),
      _useState6 = _slicedToArray(_useState5, 2),
      btn2Hover = _useState6[0],
      setBtn2Hover = _useState6[1];
    var preconnect1 = document.createElement("link");
    preconnect1.rel = "preconnect";
    preconnect1.href = "https://fonts.googleapis.com";
    document.head.appendChild(preconnect1);
    var preconnect2 = document.createElement("link");
    preconnect2.rel = "preconnect";
    preconnect2.href = "https://fonts.gstatic.com";
    preconnect2.crossOrigin = "anonymous";
    document.head.appendChild(preconnect2);
    var fontLink = document.createElement("link");
    fontLink.href = "https://fonts.googleapis.com/css2?family=Zalando+Sans+SemiExpanded:ital,wght@0,200..900;1,200..900&display=swap";
    fontLink.rel = "stylesheet";
    document.head.appendChild(fontLink);
    return __jacJsx("div", {
      "className": "h-[75vh] w-[80%] mx-auto flex flex-col text-white mt-[5vh] grid grid-cols-[100%] md:grid-cols-[60%_40%]"
    }, [__jacJsx("div", {
      "className": "flex flex-col"
    }, [__jacJsx("div", {
      "className": "px-5 py-2 rounded-2xl bg-primary w-max mb-2 "
    }, ["Find Your Future"]), __jacJsx("h1", {
      "style": {
        "fontFamily": "\"Zalando Sans\", sans-serif"
      },
      "className": "text-5xl md:text-6xl leading-none font-bold my-2"
    }, ["AI-Powered Career Mapping for the Modern Workforce "]), __jacJsx("p", {
      "className": "w-[95%]"
    }, ["Your skills tell a story. We analyze them, match them to emerging roles, and create a personalized growth roadmap — turning uncertainty into clarity and ambition into direction."]), __jacJsx("div", {
      "className": "w-[90%] mt-[2rem] flex flex-col md:flex-row gap-3 md:items-center"
    }, [__jacJsx("button", {
      "type": "button",
      "className": "w-auto bg-primary text-white border-none cursor-pointer text-base px-10 py-4 rounded-md transition-transform duration-200 ease-in-out hover:translate-y-1"
    }, ["Get Started"]), __jacJsx("button", {
      "type": "button",
      "onClick": function onClick(e) {
        var section = document.getElementById("demo");
        section.scrollIntoView({
          behavior: "smooth"
        });
      },
      "class": "w-auto border border-white bg-transparent text-white cursor-pointer text-base px-10 py-4 rounded-md transition-transform duration-200 ease-in-out hover:translate-y-1"
    }, ["View Demo"])])])]);
  }
  function Demo() {
    return __jacJsx("div", {
      "className": "w-full h-[102vh] mt-1 rounded-[50px] bg-primary"
    }, []);
  }
  function Features() {
    return __jacJsx("div", {}, []);
  }
  function Pricing() {
    return __jacJsx("div", {}, []);
  }
  function NewsletterSubscribe() {
    return __jacJsx("div", {}, []);
  }
  function FAQs() {
    return __jacJsx("div", {}, []);
  }
  function Footer() {
    return __jacJsx("div", {}, []);
  }
  return __jacJsx("div", {
    "className": "w-full min-h-screen m-0 p-0 bg-black relative font-sans overflow-hidden"
  }, [__jacJsx(NavBar, {
    "sideBarActive": sideBarActive,
    "setSideBarActivate": setSideBarActivate
  }, []), __jacJsx(Sidebar, {
    "sideBarActive": sideBarActive,
    "setSideBarActivate": setSideBarActivate
  }, []), "   ", __jacJsx(Homepage, {}, []), __jacJsx(Demo, {}, []), __jacJsx(Features, {}, []), __jacJsx(Pricing, {}, []), __jacJsx(NewsletterSubscribe, {}, []), __jacJsx(FAQs, {}, []), __jacJsx(Footer, {}, [])]);
}
export { Website };