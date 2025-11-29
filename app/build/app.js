function _typeof(o) { "@babel/helpers - typeof"; return _typeof = "function" == typeof Symbol && "symbol" == typeof Symbol.iterator ? function (o) { return typeof o; } : function (o) { return o && "function" == typeof Symbol && o.constructor === Symbol && o !== Symbol.prototype ? "symbol" : typeof o; }, _typeof(o); }
function _defineProperty(e, r, t) { return (r = _toPropertyKey(r)) in e ? Object.defineProperty(e, r, { value: t, enumerable: !0, configurable: !0, writable: !0 }) : e[r] = t, e; }
function _toPropertyKey(t) { var i = _toPrimitive(t, "string"); return "symbol" == _typeof(i) ? i : i + ""; }
function _toPrimitive(t, r) { if ("object" != _typeof(t) || !t) return t; var e = t[Symbol.toPrimitive]; if (void 0 !== e) { var i = e.call(t, r || "default"); if ("object" != _typeof(i)) return i; throw new TypeError("@@toPrimitive must return a primitive value."); } return ("string" === r ? String : Number)(t); }
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
import { Mail, Brain, CloudUpload, Check, Goal, Route as Node, ChevronUp, ChevronLeft } from "lucide-react";
import { Accordion } from "radix-ui";
import { Router, Routes, Route, Link, Navigate, useNavigate, jacSignup, jacLogin, jacLogout, jacIsLoggedIn } from "@jac-client/utils";
import { fileToBase64 } from "./fileutils.js";
import "./styles.css";
function Website() {
  function NavBar() {
    var links = ["CHANGELOG", "PRICING", "FAQs", "RESOURCES"];
    var _useState = useState(""),
      _useState2 = _slicedToArray(_useState, 2),
      navbtnHover = _useState2[0],
      setNavBtnHover = _useState2[1];
    var navigate = useNavigate();
    return __jacJsx("div", {
      "style": {
        "position": "sticky",
        "border": "1px solid transparent",
        "top": "1rem",
        "zIndex": "99999",
        "width": "calc(92% - 6px)",
        "marginInline": "auto",
        "paddingBlock": "1rem",
        "paddingInline": "1.5rem",
        "display": "flex",
        "alignItems": "center",
        "justifyContent": "space-between",
        "color": "white",
        "borderRadius": "0.375rem",
        "transition": "all 200ms ease-in",
        "backgroundColor": "rgba(0,0,0,.5)",
        "backdropFilter": "blur(12px)"
      }
    }, [__jacJsx("a", {
      "href": "/app",
      "style": {
        "fontSize": "1.125rem",
        "fontWeight": "600",
        "cursor": "pointer",
        "color": "white",
        "textDecoration": "none"
      }
    }, ["Arise"]), __jacJsx("div", {
      "style": {
        "display": "flex",
        "alignItems": "center",
        "gap": "2rem"
      }
    }, [__jacJsx("ul", {
      "style": {
        "position": "relative",
        "zIndex": "10",
        "display": "flex",
        "alignItems": "center",
        "gap": "10px",
        "listStyle": "none"
      }
    }, [links.map(function (link) {
      return __jacJsx("li", {
        "key": link,
        "style": {
          "position": "relative",
          "fontSize": "14px",
          "cursor": "pointer",
          "padding": "4px 8px",
          "borderRadius": "4px"
        }
      }, [link]);
    })]), __jacJsx("button", {
      "type": "button",
      "onClick": function onClick(e) {
        navigate("/auth");
      },
      "onMouseEnter": function onMouseEnter(e) {
        setNavBtnHover(true);
      },
      "onMouseLeave": function onMouseLeave(e) {
        setNavBtnHover(false);
      },
      "style": {
        "width": "auto",
        "backgroundColor": "#6e11b0",
        "color": "white",
        "border": "none",
        "paddingInline": "2.5rem",
        "paddingBlock": "1rem",
        "borderRadius": "5px",
        "cursor": "pointer",
        "fontSize": "16px",
        "transform": navbtnHover ? "translateY(0.25rem)" : "translateY(0)",
        "transition": "transform 0.2s ease"
      }
    }, ["Get Started"])])]);
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
    return __jacJsx("div", {
      "style": {
        "height": "70vh",
        "width": "80%",
        "marginInline": "auto",
        "display": "flex",
        "flexDirection": "column",
        "color": "white",
        "marginTop": "5vh"
      }
    }, [__jacJsx("div", {
      "style": {
        "padding": "0.635rem 1.375rem",
        "borderRadius": "20px",
        "backgroundColor": "#6e11b0",
        "color": "white",
        "width": "fit-content",
        "marginBottom": "0.5rem"
      }
    }, ["Find Your Future"]), __jacJsx("h1", {
      "style": {
        "fontWeight": "700",
        "fontSize": "3.75rem",
        "width": "60%",
        "fontFamily": "'Zalando Sans SemiExpanded', sans-serif",
        "lineHeight": "1"
      }
    }, ["AI-Powered Career Mapping for the Modern Workforce"]), __jacJsx("p", {
      "style": {
        "fontSize": "18px",
        "width": "55%"
      }
    }, ["Your skills tell a story. We analyze them, match them to emerging roles, and create a personalized growth roadmap — turning uncertainty into clarity and ambition into direction."]), __jacJsx("div", {
      "style": {
        "width": "40%",
        "marginTop": "2rem",
        "display": "flex",
        "flexDirection": "row",
        "gap": "1rem",
        "alignItems": "center"
      }
    }, [__jacJsx("button", {
      "type": "button",
      "onMouseEnter": function onMouseEnter(e) {
        setBtn1Hover(true);
      },
      "onMouseLeave": function onMouseLeave(e) {
        setBtn1Hover(false);
      },
      "style": {
        "width": "auto",
        "backgroundColor": "#6e11b0",
        "color": "white",
        "border": "none",
        "paddingInline": "2.5rem",
        "paddingBlock": "1rem",
        "borderRadius": "5px",
        "cursor": "pointer",
        "fontSize": "16px",
        "transform": btn1Hover ? "translateY(0.25rem)" : "translateY(0)",
        "transition": "transform 0.2s ease"
      }
    }, ["Get Started"]), __jacJsx("button", {
      "type": "button",
      "onMouseEnter": function onMouseEnter(e) {
        setBtn2Hover(true);
      },
      "onMouseLeave": function onMouseLeave(e) {
        setBtn2Hover(false);
      },
      "onClick": function onClick(e) {
        var section = document.getElementById("demo");
        section.scrollIntoView({
          behavior: "smooth"
        });
      },
      "style": {
        "width": "auto",
        "border": "1px solid white",
        "backgroundColor": "transparent",
        "color": "white",
        "paddingInline": "2.5rem",
        "paddingBlock": "1rem",
        "borderRadius": "5px",
        "cursor": "pointer",
        "fontSize": "16px",
        "transform": btn2Hover ? "translateY(0.25rem)" : "translateY(0)",
        "transition": "transform 0.2s ease"
      }
    }, ["View Demo"])])]);
  }
  function Demo() {
    return __jacJsx("div", {
      "id": "demo",
      "style": {
        "width": "100%",
        "height": "102vh",
        "marginTop": "0.25rem",
        "borderRadius": "50px",
        "backgroundColor": "#6e11b0"
      }
    }, []);
  }
  function Features() {
    return __jacJsx("div", {}, [__jacJsx("h1", {}, ["Features"])]);
  }
  function Pricing() {
    return __jacJsx("div", {}, [__jacJsx("h1", {}, ["Pricing"])]);
  }
  function NewsletterSubscribe() {
    var _useState7 = useState(""),
      _useState8 = _slicedToArray(_useState7, 2),
      email = _useState8[0],
      setEmail = _useState8[1];
    var _useState9 = useState(false),
      _useState0 = _slicedToArray(_useState9, 2),
      isSubmitting = _useState0[0],
      setIsSubmitting = _useState0[1];
    var _useState1 = useState(false),
      _useState10 = _slicedToArray(_useState1, 2),
      btnHover = _useState10[0],
      setBtnHover = _useState10[1];
    return __jacJsx("div", {
      "style": {
        "width": "88%",
        "borderRadius": "1.5rem",
        "marginInline": "auto",
        "color": "white",
        "padding": "4rem 1.5rem",
        "marginTop": "4rem",
        "marginBottom": "4rem",
        "display": "flex",
        "flexDirection": "column",
        "alignItems": "center",
        "justifyContent": "center",
        "boxShadow": "0 25px 50px -12px rgba(0,0,0,0.25)"
      }
    }, [__jacJsx(Mail, {
      "style": {
        "width": "40px",
        "height": "40px",
        "marginBottom": "1rem",
        "color": "#d8b4fe"
      }
    }, []), __jacJsx("h2", {
      "style": {
        "fontWeight": "bold",
        "fontSize": "2.25rem",
        "textAlign": "center",
        "marginBottom": "1.75rem",
        "width": "60%",
        "fontFamily": "'Zalando Sans SemiExpanded', sans-serif"
      }
    }, ["Stay Ahead of the Curve"]), __jacJsx("p", {
      "style": {
        "fontSize": "16px",
        "color": "#f5f5f5",
        "textAlign": "center",
        "marginBottom": "2rem",
        "maxWidth": "36rem"
      }
    }, ["Get exclusive insights, product updates, and early accessdelivered straight to your inbox."]), __jacJsx("form", {
      "style": {
        "width": "50%",
        "display": "flex",
        "flexDirection": "row",
        "gap": "1rem",
        "marginInline": "auto"
      }
    }, [__jacJsx("input", {
      "type": "email",
      "placeholder": "Enter your email",
      "value": email,
      "disabled": isSubmitting,
      "required": true,
      "onChange": function onChange(e) {
        setEmail(e.target.value);
      },
      "style": {
        "flexGrow": 1,
        "padding": "1rem 1.25rem",
        "borderRadius": "0.5rem",
        "border": "none",
        "backgroundColor": "#0b0b0b",
        "color": "white",
        "outline": "none",
        "transition": "border 0.2s ease"
      }
    }, []), __jacJsx("button", {
      "type": "submit",
      "disabled": isSubmitting,
      "style": {
        "width": "auto",
        "padding": "1rem 1.5rem",
        "border": "none",
        "borderRadius": "0.5rem",
        "backgroundColor": "#5b21b6",
        "color": "white",
        "fontWeight": "600",
        "textTransform": "uppercase",
        "fontSize": "0.875rem",
        "cursor": "pointer",
        "transform": btnHover ? "translateY(0.25rem)" : "translateY(0)",
        "transition": "all 0.2s eFase",
        "opacity": isSubmitting ? 0.5 : 1
      }
    }, [isSubmitting ? "Subscribing..." : "Subscribe"])])]);
  }
  function FAQs() {
    var _useState11 = useState(null),
      _useState12 = _slicedToArray(_useState11, 2),
      arrow = _useState12[0],
      setArrow = _useState12[1];
    console.log(arrow);
    var faqData = [{
      question: "How does Arise generate personalized career paths?",
      answer: "Our **AI Career Engine** analyzes your skills, interests, work values, and personality traits through comprehensive assessments. It then matches these insights with labor market data, industry trends, and millions of career trajectories to generate tailored pathway recommendations with actionable steps.",
      value: "career-generation"
    }, {
      question: "What is the accuracy of your job matching algorithm?",
      answer: "Our matching algorithm achieves **92% accuracy** in identifying suitable roles based on user profiles and preferences. We continuously refine our models using feedback from successful placements and evolving job market data to improve match quality.",
      value: "accuracy"
    }, {
      question: "Can Arise help me if I'm looking to change careers?",
      answer: "Absolutely! **Career transition** is one of our core strengths. We identify transferable skills from your current experience, map them to new industries, and create step-by-step transition plans including skill gaps, recommended training, and timeline projections.",
      value: "career-change"
    }, {
      question: "What platforms and integrations do you support?",
      answer: "Arise integrates with **LinkedIn, Indeed, Glassdoor, and major job boards** to provide real-time opportunities. We also connect with learning platforms like Coursera and Udemy to recommend relevant courses, and offer a mobile app for on-the-go career guidance.",
      value: "integrations"
    }, {
      question: "How is my personal data and career information protected?",
      answer: "We prioritize your privacy with **end-to-end encryption** and strict data protection policies. Your career data, assessments, and job search activity are never shared with third parties without explicit consent. We comply with GDPR, CCPA, and industry-standard security protocols.",
      value: "privacy-security"
    }, {
      question: "Do you provide ongoing career guidance or just one-time recommendations?",
      answer: "Arise offers **continuous career guidance** that evolves with you. Our AI tracks your progress, updates recommendations based on skill development, monitors market changes, and provides quarterly career check-ins to ensure you stay on track toward your goals.",
      value: "ongoing-support"
    }, {
      question: "Can I customize my career preferences and filters?",
      answer: "Yes! You have full control to customize preferences including **salary expectations, location flexibility, work-life balance priorities, company culture, remote work options, and industry preferences**. Our recommendations adapt in real-time to your updated preferences.",
      value: "customization"
    }];
    return __jacJsx("div", {
      "id": "FAQs",
      "style": {
        "width": "88%",
        "maxWidth": "56rem",
        "marginInline": "auto",
        "paddingBlock": "5rem"
      }
    }, [__jacJsx("h2", {
      "style": {
        "fontSize": "2.25rem",
        "fontWeight": "bold",
        "textAlign": "center",
        "mmarginBottom": "2.5rem",
        "color": "white"
      }
    }, ["Frequently Asked Questions"]), __jacJsx(Accordion.Root, {
      "type": "single",
      "collapsible": true
    }, [faqData.map(function (faq) {
      return __jacJsx("div", {}, [__jacJsx(Accordion.Item, {
        "value": faq.value,
        "key": faq.value,
        "style": {
          "borderBottom": "1px solid rgba(255,255,255,0.1)",
          "backgroundColor": "#6e11b0",
          "padding": "1.75rem 1rem",
          "borderRadius": "0.5rem",
          "transition": "background-color 0.2s ease",
          "marginTop": "10px"
        }
      }, [__jacJsx(Accordion.Trigger, {
        "onClick": function onClick(e) {
          arrow !== faq.value ? setArrow(faq.value) : setArrow("");
        },
        "style": {
          "textAlign": "left",
          "fontSize": "1rem",
          "color": "white",
          "background": "none",
          "border": "none",
          "width": "100%",
          "cursor": "pointer",
          "display": "flex",
          "flexDirection": "row",
          "justifyContent": "space-between",
          "alignItems": "center"
        }
      }, [faq.question, __jacJsx(ChevronUp, {
        "style": {
          "transform": arrow === faq.value ? "rotate(180deg)" : "none",
          "transition": "all ease 0.3s"
        }
      }, [])]), __jacJsx(Accordion.Content, {
        "style": {
          "paddingTop": "0.5rem",
          "paddingBottom": "0",
          "color": "#d1d5db"
        }
      }, [faq.answer])])]);
    })])]);
  }
  function Footer() {
    var currentYear = "2025";
    var socialLinks = [{
      name: "Twitter",
      href: "https://twitter.com/arisecareer",
      path: "M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"
    }, {
      name: "Instagram",
      href: "https://instagram.com/arisecareer",
      path: "M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"
    }, {
      name: "GitHub",
      href: "https://github.com/arisecareer",
      path: "M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"
    }, {
      name: "LinkedIn",
      href: "https://linkedin.com/company/arisecareer",
      path: "M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"
    }];
    var footerSections = [{
      title: "Platform",
      links: [{
        label: "Career Assessment",
        href: "/assessment"
      }, {
        label: "Path Generator",
        href: "/paths"
      }, {
        label: "Job Matching",
        href: "/jobs"
      }]
    }, {
      title: "Resources",
      links: [{
        label: "Career Guides",
        href: "/guides"
      }, {
        label: "Skill Library",
        href: "/skills"
      }, {
        label: "Success Stories",
        href: "/stories"
      }]
    }, {
      title: "Company",
      links: [{
        label: "About Us",
        href: "/about"
      }, {
        label: "Contact",
        href: "/contact"
      }, {
        label: "Careers",
        href: "/careers"
      }]
    }, {
      title: "Support",
      links: [{
        label: "Help Center",
        href: "/help"
      }, {
        label: "API Docs",
        href: "/docs"
      }, {
        label: "Community",
        href: "/community"
      }, {
        label: "Report Issue",
        href: "/report"
      }]
    }];
    var legalLinks = [{
      label: "Privacy Policy",
      href: "/privacy"
    }, {
      label: "Terms of Service",
      href: "/terms"
    }, {
      label: "Data Usage",
      href: "/data-policy"
    }];
    return __jacJsx("footer", {
      "style": {
        "paddingBlock": "3rem",
        "width": "100%"
      }
    }, [__jacJsx("div", {
      "style": {
        "width": "100%",
        "maxWidth": "80rem",
        "marginInline": "auto",
        "paddingInline": "2rem"
      }
    }, [__jacJsx("div", {
      "style": {
        "backgroundColor": "#0b0b0b",
        "borderRadius": "30px",
        "boxShadow": "0 10px 15px -3px rgba(0, 0, 0, 0.1)",
        "padding": "3rem"
      }
    }, [__jacJsx("div", {
      "style": {
        "display": "grid",
        "gridTemplateColumns": "repeat(5, 1fr)",
        "gap": "2rem",
        "paddingBottom": "2.5rem",
        "borderBottom": "1px solid #2d2d2d"
      }
    }, [__jacJsx("div", {
      "style": {
        "gridColumn": "span 2",
        "display": "flex",
        "flexDirection": "column",
        "gap": "1.5rem"
      }
    }, [__jacJsx("div", {
      "style": {
        "display": "flex",
        "alignItems": "center",
        "gap": "0.5rem"
      }
    }, [__jacJsx("svg", {
      "style": {
        "width": "24px",
        "height": "24px",
        "color": "#10b981"
      },
      "fill": "none",
      "stroke": "currentColor",
      "viewBox": "0 0 24 24"
    }, [__jacJsx("path", {
      "strokeLinecap": "round",
      "strokeLinejoin": "round",
      "strokeWidth": 2,
      "d": "M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"
    }, [])]), __jacJsx("span", {
      "style": {
        "fontSize": "1.5rem",
        "fontWeight": "700",
        "color": "white"
      }
    }, ["Arise"])]), __jacJsx("p", {
      "style": {
        "fontSize": "0.875rem",
        "color": "#9ca3af",
        "maxWidth": "20rem",
        "lineHeight": "1.5"
      }
    }, ["Empowering individuals to discover and navigate their ideal career paths through AI-driven insights, personalized recommendations, and continuous guidance."]), __jacJsx("div", {
      "style": {
        "display": "flex",
        "gap": "1rem",
        "paddingTop": "0.5rem"
      }
    }, [socialLinks.map(function (social) {
      return __jacJsx("a", {
        "key": social.name,
        "href": social.href,
        "target": "_blank",
        "rel": "noopener noreferrer",
        "style": {
          "color": "#9ca3af",
          "cursor": "pointer",
          "transition": "color 0.2s"
        }
      }, [__jacJsx("svg", {
        "style": {
          "width": "20px",
          "height": "20px"
        },
        "fill": "currentColor",
        "viewBox": "0 0 24 24"
      }, [__jacJsx("path", {
        "d": social.path
      }, [])])]);
    })])]), __jacJsx("div", {
      "style": {
        "gridColumn": "span 3",
        "display": "grid",
        "gridTemplateColumns": "repeat(4, 1fr)",
        "gap": "1.5rem"
      }
    }, [footerSections.map(function (section) {
      return __jacJsx("div", {
        "key": section.title,
        "style": {
          "display": "flex",
          "flexDirection": "column",
          "gap": "1rem"
        }
      }, [__jacJsx("h3", {
        "style": {
          "fontSize": "1rem",
          "fontWeight": "600",
          "color": "white",
          "marginBottom": "0.5rem"
        }
      }, [section.title]), section.links.map(function (link) {
        return __jacJsx("a", {
          "key": link.href,
          "href": link.href,
          "style": {
            "fontSize": "0.875rem",
            "color": "#9ca3af",
            "textDecoration": "none",
            "cursor": "pointer"
          }
        }, [link.label]);
      })]);
    })])]), __jacJsx("div", {
      "style": {
        "display": "flex",
        "justifyContent": "space-between",
        "alignItems": "center",
        "paddingTop": "1.5rem",
        "flexWrap": "wrap",
        "gap": "1rem"
      }
    }, [__jacJsx("p", {
      "style": {
        "fontSize": "0.875rem",
        "color": "#6b7280"
      }
    }, ["© ", currentYear, " Arise. All rights reserved."]), __jacJsx("div", {
      "style": {
        "display": "flex",
        "gap": "1.5rem",
        "fontSize": "0.875rem"
      }
    }, [legalLinks.map(function (link) {
      return __jacJsx("a", {
        "key": link.href,
        "href": link.href,
        "style": {
          "color": "#6b7280",
          "textDecoration": "none",
          "cursor": "pointer",
          "whiteSpace": "nowrap"
        }
      }, [link.label]);
    })])])])])]);
  }
  return __jacJsx("div", {
    "style": {
      "width": "100%",
      "minHeight": "100vh",
      "margin": "0px",
      "padding": "0px",
      "background": "black",
      "position": "relative",
      "fontFamily": "system-ui, sans-serif"
    }
  }, [" ", __jacJsx(NavBar, {}, []), __jacJsx(Homepage, {}, []), __jacJsx(Demo, {}, []), __jacJsx(Features, {}, []), __jacJsx(Pricing, {}, []), __jacJsx(NewsletterSubscribe, {}, []), __jacJsx(FAQs, {}, []), __jacJsx(Footer, {}, [])]);
}
function Auth() {
  var navigate = useNavigate();
  var _useState13 = useState(""),
    _useState14 = _slicedToArray(_useState13, 2),
    loginEmail = _useState14[0],
    setLoginEmail = _useState14[1];
  var _useState15 = useState(""),
    _useState16 = _slicedToArray(_useState15, 2),
    loginPassword = _useState16[0],
    setLoginPassword = _useState16[1];
  var _useState17 = useState(""),
    _useState18 = _slicedToArray(_useState17, 2),
    signupName = _useState18[0],
    setSignupName = _useState18[1];
  var _useState19 = useState(""),
    _useState20 = _slicedToArray(_useState19, 2),
    signupEmail = _useState20[0],
    setSignupEmail = _useState20[1];
  var _useState21 = useState(""),
    _useState22 = _slicedToArray(_useState21, 2),
    signupPassword = _useState22[0],
    setSignupPassword = _useState22[1];
  var _useState23 = useState(true),
    _useState24 = _slicedToArray(_useState23, 2),
    isSignIn = _useState24[0],
    setIsSignIn = _useState24[1];
  var _useState25 = useState(""),
    _useState26 = _slicedToArray(_useState25, 2),
    error = _useState26[0],
    setError = _useState26[1];
  function handleLogin(_x) {
    return _handleLogin.apply(this, arguments);
  }
  function _handleLogin() {
    _handleLogin = _asyncToGenerator(/*#__PURE__*/_regenerator().m(function _callee(e) {
      var success, resume_status;
      return _regenerator().w(function (_context) {
        while (1) switch (_context.n) {
          case 0:
            e.preventDefault();
            setError("");
            if (!(!loginEmail || !loginPassword)) {
              _context.n = 1;
              break;
            }
            setError("Please fill all fields");
            return _context.a(2);
          case 1:
            _context.n = 2;
            return jacLogin(loginEmail, loginPassword);
          case 2:
            success = _context.v;
            if (!success) {
              _context.n = 4;
              break;
            }
            _context.n = 3;
            return __jacSpawn("check_resume_upload_status", "", {});
          case 3:
            resume_status = _context.v;
            if (resume_status.reports[0]["body"] === true) {
              navigate("/dashboard");
            } else {
              navigate("/onboarding");
            }
            _context.n = 5;
            break;
          case 4:
            setError("Wrong email or password");
          case 5:
            return _context.a(2);
        }
      }, _callee);
    }));
    return _handleLogin.apply(this, arguments);
  }
  function handleSignup(_x2) {
    return _handleSignup.apply(this, arguments);
  }
  function _handleSignup() {
    _handleSignup = _asyncToGenerator(/*#__PURE__*/_regenerator().m(function _callee2(e) {
      var result, new_memory;
      return _regenerator().w(function (_context2) {
        while (1) switch (_context2.n) {
          case 0:
            e.preventDefault();
            setError("");
            if (!(!signupName || !signupEmail || !signupPassword)) {
              _context2.n = 1;
              break;
            }
            setError("Please fill in all fields");
            return _context2.a(2);
          case 1:
            _context2.n = 2;
            return jacSignup(signupEmail, signupPassword);
          case 2:
            result = _context2.v;
            if (!result["success"]) {
              _context2.n = 4;
              break;
            }
            _context2.n = 3;
            return __jacSpawn("initialize_memory", "", {
              "full_name": signupName,
              "email": signupEmail
            });
          case 3:
            new_memory = _context2.v;
            console.log("New Memory initialized:");
            console.log(new_memory);
            navigate("/onboarding");
            _context2.n = 5;
            break;
          case 4:
            setError(result["error"] ? result["error"] : "Signup failed");
          case 5:
            return _context2.a(2);
        }
      }, _callee2);
    }));
    return _handleSignup.apply(this, arguments);
  }
  function Header(title) {
    return __jacJsx("div", {
      "style": {
        "width": "calc(70% + 1.25rem)",
        "textAlign": "left",
        "marginBottom": "16px"
      }
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        navigate("/");
      },
      "style": {
        "display": "flex",
        "flexDirection": "row",
        "alignItems": "center",
        "color": "grey",
        "cursor": "pointer",
        "marginBottom": "8px"
      }
    }, [__jacJsx("span", {}, [__jacJsx(ChevronLeft, {}, [])]), "Back"]), __jacJsx("h2", {
      "style": {
        "color": "white",
        "margin": 0
      }
    }, [title])]);
  }
  var loginErrorBox = null;
  if (error && isSignIn) {
    loginErrorBox = __jacJsx("div", {
      "style": {
        "color": "#dc2626",
        "marginBottom": "10px",
        "fontSize": "14px"
      }
    }, [error]);
  }
  var signupErrorBox = null;
  if (error && !isSignIn) {
    signupErrorBox = __jacJsx("div", {
      "style": {
        "color": "#dc2626",
        "marginBottom": "10px",
        "fontSize": "14px"
      }
    }, [error]);
  }
  return __jacJsx("div", {
    "style": {
      "width": "100%",
      "height": "100vh",
      "display": "grid",
      "gridTemplateColumns": "50% 50%",
      "position": "relative",
      "color": "white"
    }
  }, [__jacJsx("div", {
    "style": {
      "width": "100%",
      "height": "100%",
      "display": "flex",
      "justifyContent": "center",
      "alignItems": "center"
    }
  }, [__jacJsx("div", {
    "style": {
      "width": "100%",
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center",
      "padding": "24px",
      "fontFamily": "'Inter', sans-serif"
    }
  }, [Header("Welcome back"), loginErrorBox, __jacJsx("form", {
    "onSubmit": handleLogin,
    "style": {
      "width": "100%",
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center"
    }
  }, [__jacJsx("input", {
    "type": "email",
    "placeholder": "Email",
    "value": loginEmail,
    "onChange": function onChange(e) {
      setLoginEmail(e.target.value);
    },
    "style": {
      "padding": "1.25rem",
      "borderRadius": "0.5rem",
      "border": "none",
      "backgroundColor": "#0b0b0b",
      "color": "white",
      "fontSize": "16px",
      "width": "70%",
      "marginBottom": "16px"
    }
  }, []), __jacJsx("input", {
    "type": "password",
    "placeholder": "Password",
    "value": loginPassword,
    "onChange": function onChange(e) {
      setLoginPassword(e.target.value);
    },
    "style": {
      "padding": "1.25rem",
      "borderRadius": "0.5rem",
      "border": "none",
      "backgroundColor": "#0b0b0b",
      "color": "white",
      "fontSize": "16px",
      "width": "70%",
      "marginBottom": "16px"
    }
  }, []), __jacJsx("button", {
    "type": "submit",
    "style": {
      "width": "calc(70% + 12px + 1.25rem)",
      "padding": "1.25rem",
      "borderRadius": "8px",
      "border": "none",
      "backgroundColor": "#6e11b0",
      "color": "white",
      "fontWeight": "600",
      "cursor": "pointer"
    }
  }, ["Sign In"])]), __jacJsx("p", {
    "style": {
      "marginTop": "19px",
      "fontSize": "14px",
      "color": "#bbbbbb",
      "textAlign": "center"
    }
  }, ["Don't have an account?", __jacJsx("span", {
    "onClick": function onClick(e) {
      setIsSignIn(false);
      setError("");
    },
    "style": {
      "color": "#6e11b0",
      "cursor": "pointer",
      "fontWeight": "600",
      "marginLeft": "5px"
    }
  }, ["Sign Up"])])])]), __jacJsx("div", {
    "style": {
      "width": "100%",
      "height": "100%",
      "display": "flex",
      "justifyContent": "center",
      "alignItems": "center"
    }
  }, [__jacJsx("div", {
    "style": {
      "width": "100%",
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center",
      "padding": "24px",
      "fontFamily": "'Inter', sans-serif"
    }
  }, [Header("Create your account"), signupErrorBox, __jacJsx("form", {
    "onSubmit": handleSignup,
    "style": {
      "width": "100%",
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center"
    }
  }, [__jacJsx("input", {
    "type": "text",
    "placeholder": "Full Name",
    "value": signupName,
    "onChange": function onChange(e) {
      setSignupName(e.target.value);
    },
    "style": {
      "padding": "1.25rem",
      "borderRadius": "0.5rem",
      "border": "none",
      "backgroundColor": "#0b0b0b",
      "color": "white",
      "fontSize": "16px",
      "width": "70%",
      "marginBottom": "16px"
    }
  }, []), __jacJsx("input", {
    "type": "email",
    "placeholder": "Email",
    "value": signupEmail,
    "onChange": function onChange(e) {
      setSignupEmail(e.target.value);
    },
    "style": {
      "padding": "1.25rem",
      "borderRadius": "0.5rem",
      "border": "none",
      "backgroundColor": "#0b0b0b",
      "color": "white",
      "fontSize": "16px",
      "width": "70%",
      "marginBottom": "16px"
    }
  }, []), __jacJsx("input", {
    "type": "password",
    "placeholder": "Password",
    "value": signupPassword,
    "onChange": function onChange(e) {
      setSignupPassword(e.target.value);
    },
    "style": {
      "padding": "1.25rem",
      "borderRadius": "0.5rem",
      "border": "none",
      "backgroundColor": "#0b0b0b",
      "color": "white",
      "fontSize": "16px",
      "width": "70%",
      "marginBottom": "16px"
    }
  }, []), __jacJsx("button", {
    "type": "submit",
    "style": {
      "width": "calc(70% + 12px + 1.25rem)",
      "padding": "1.25rem",
      "borderRadius": "8px",
      "border": "none",
      "backgroundColor": "#6e11b0",
      "color": "white",
      "fontWeight": "600",
      "cursor": "pointer"
    }
  }, ["Sign Up"])]), __jacJsx("p", {
    "style": {
      "marginTop": "19px",
      "fontSize": "14px",
      "color": "#bbbbbb",
      "textAlign": "center"
    }
  }, ["Already have an account?", __jacJsx("span", {
    "onClick": function onClick(e) {
      setIsSignIn(true);
      setError("");
    },
    "style": {
      "color": "#6e11b0",
      "cursor": "pointer",
      "fontWeight": "600",
      "marginLeft": "5px"
    }
  }, ["Sign In"])])])]), __jacJsx("div", {
    "style": {
      "width": "50%",
      "height": "100%",
      "position": "absolute",
      "top": "0px",
      "left": isSignIn ? "50%" : "0px",
      "transition": "all 300ms ease-in",
      "display": "flex",
      "justifyContent": "center",
      "alignItems": "center",
      "pointerEvents": "none"
    }
  }, [__jacJsx("div", {
    "style": {
      "margin": "auto",
      "backgroundColor": "#6e11b0",
      "width": "97%",
      "height": "97%",
      "zIndex": "9999",
      "borderRadius": "10px",
      "display": "flex",
      "justifyContent": "center",
      "alignItems": "center",
      "overflow": "hidden"
    }
  }, [])])]);
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
function Onboarding() {
  var _useState27 = useState(1),
    _useState28 = _slicedToArray(_useState27, 2),
    currentStep = _useState28[0],
    setCurrentStep = _useState28[1];
  var _useState29 = useState(0),
    _useState30 = _slicedToArray(_useState29, 2),
    stepCompleted = _useState30[0],
    setStepCompleted = _useState30[1];
  var _useState31 = useState(false),
    _useState32 = _slicedToArray(_useState31, 2),
    navbtnHover = _useState32[0],
    setNavBtnHover = _useState32[1];
  var _useState33 = useState("25%"),
    _useState34 = _slicedToArray(_useState33, 2),
    progress = _useState34[0],
    setProgress = _useState34[1];
  var _useState35 = useState(false),
    _useState36 = _slicedToArray(_useState35, 2),
    resumeHover = _useState36[0],
    setResumeHover = _useState36[1];
  var _useState37 = useState(""),
    _useState38 = _slicedToArray(_useState37, 2),
    alertMessage = _useState38[0],
    setAlertMessage = _useState38[1];
  var _useState39 = useState(false),
    _useState40 = _slicedToArray(_useState39, 2),
    alertVisible = _useState40[0],
    setAlertVisible = _useState40[1];
  var _useState41 = useState(false),
    _useState42 = _slicedToArray(_useState41, 2),
    allowSkip = _useState42[0],
    setAllowSkip = _useState42[1];
  var _useState43 = useState(false),
    _useState44 = _slicedToArray(_useState43, 2),
    dragActive = _useState44[0],
    setDragActive = _useState44[1];
  var _useState45 = useState(""),
    _useState46 = _slicedToArray(_useState45, 2),
    fileName = _useState46[0],
    setFileName = _useState46[1];
  var _useState47 = useState(null),
    _useState48 = _slicedToArray(_useState47, 2),
    file = _useState48[0],
    setFile = _useState48[1];
  var _useState49 = useState(""),
    _useState50 = _slicedToArray(_useState49, 2),
    error = _useState50[0],
    setError = _useState50[1];
  var _useState51 = useState(false),
    _useState52 = _slicedToArray(_useState51, 2),
    isLoading = _useState52[0],
    setIsLoading = _useState52[1];
  var _useState53 = useState(false),
    _useState54 = _slicedToArray(_useState53, 2),
    showManualEntry = _useState54[0],
    setShowManualEntry = _useState54[1];
  var _useState55 = useState(false),
    _useState56 = _slicedToArray(_useState55, 2),
    canProceed = _useState56[0],
    setCanProceed = _useState56[1];
  var navigate = useNavigate();
  var _useState57 = useState([]),
    _useState58 = _slicedToArray(_useState57, 2),
    skills = _useState58[0],
    setSkills = _useState58[1];
  var _useState59 = useState([]),
    _useState60 = _slicedToArray(_useState59, 2),
    interests = _useState60[0],
    setInterests = _useState60[1];
  var _useState61 = useState([]),
    _useState62 = _slicedToArray(_useState61, 2),
    certs = _useState62[0],
    setCerts = _useState62[1];
  var _useState63 = useState(""),
    _useState64 = _slicedToArray(_useState63, 2),
    newSkill = _useState64[0],
    setNewSkill = _useState64[1];
  var _useState65 = useState(""),
    _useState66 = _slicedToArray(_useState65, 2),
    newInterest = _useState66[0],
    setNewInterest = _useState66[1];
  var _useState67 = useState(""),
    _useState68 = _slicedToArray(_useState67, 2),
    newCert = _useState68[0],
    setNewCert = _useState68[1];
  var _useState69 = useState(true),
    _useState70 = _slicedToArray(_useState69, 2),
    step2Loading = _useState70[0],
    setStep2Loading = _useState70[1];
  var _useState71 = useState(false),
    _useState72 = _slicedToArray(_useState71, 2),
    savingProfile = _useState72[0],
    setSavingProfile = _useState72[1];
  function showAlert(msg) {
    setAlertMessage(msg);
    setAlertVisible(true);
    setTimeout(function () {
      setAlertVisible(false);
    }, 3500);
  }
  function loadStep2() {
    return _loadStep.apply(this, arguments);
  }
  function _loadStep() {
    _loadStep = _asyncToGenerator(/*#__PURE__*/_regenerator().m(function _callee3() {
      var profile, body, _t;
      return _regenerator().w(function (_context3) {
        while (1) switch (_context3.p = _context3.n) {
          case 0:
            setStep2Loading(true);
            _context3.p = 1;
            _context3.n = 2;
            return __jacSpawn("get_user_profile", "", {});
          case 2:
            profile = _context3.v;
            if (profile && profile.reports && profile.reports.length > 0) {
              body = profile.reports[0]["body"];
              setSkills("skills" in body ? body["skills"] : []);
              setInterests("interests" in body ? body["interests"] : []);
              setCerts("certifications" in body ? body["certifications"] : []);
            } else {
              setSkills([]);
              setInterests([]);
              setCerts([]);
            }
            _context3.n = 4;
            break;
          case 3:
            _context3.p = 3;
            _t = _context3.v;
            console.log(_t);
            showAlert("Failed to load profile. Try again later.");
          case 4:
            _context3.p = 4;
            setStep2Loading(false);
            return _context3.f(4);
          case 5:
            return _context3.a(2);
        }
      }, _callee3, null, [[1, 3, 4, 5]]);
    }));
    return _loadStep.apply(this, arguments);
  }
  useEffect(function () {
    if (currentStep === 2) {
      loadStep2();
    }
  }, [currentStep]);
  function addSkill() {
    if (newSkill.trim().length === 0) {
      return;
    }
    var exists = skills.filter(function (s) {
      return s.name.toLowerCase() === newSkill.trim().toLowerCase();
    }).length > 0;
    if (!exists) {
      setSkills(skills.concat([{
        "name": newSkill.trim(),
        "description": ""
      }]));
    }
    setNewSkill("");
  }
  function addInterest() {
    if (newInterest.trim().length === 0) {
      return;
    }
    var exists = interests.filter(function (i) {
      return i.name.toLowerCase() === newInterest.trim().toLowerCase();
    }).length > 0;
    if (!exists) {
      setInterests(interests.concat([{
        "name": newInterest.trim(),
        "description": ""
      }]));
    }
    setNewInterest("");
  }
  function addCert() {
    if (newCert.trim().length === 0) {
      return;
    }
    var exists = certs.filter(function (c) {
      return "title" in c && c.title.toLowerCase() === newCert.trim().toLowerCase();
    }).length > 0;
    if (!exists) {
      setCerts(certs.concat([{
        "title": newCert.trim(),
        "provider": "",
        "url": ""
      }]));
    }
    setNewCert("");
  }
  function removeSkill(name) {
    setSkills(skills.filter(function (s) {
      return s.name !== name;
    }));
  }
  function removeInterest(name) {
    setInterests(interests.filter(function (i) {
      return i.name !== name;
    }));
  }
  function removeCert(name) {
    setCerts(certs.filter(function (c) {
      return c.title !== name;
    }));
  }
  function saveStep2() {
    return _saveStep.apply(this, arguments);
  }
  function _saveStep() {
    _saveStep = _asyncToGenerator(/*#__PURE__*/_regenerator().m(function _callee4() {
      var result, _t2;
      return _regenerator().w(function (_context4) {
        while (1) switch (_context4.p = _context4.n) {
          case 0:
            if (!savingProfile) {
              _context4.n = 1;
              break;
            }
            return _context4.a(2);
          case 1:
            setSavingProfile(true);
            _context4.p = 2;
            _context4.n = 3;
            return __jacSpawn("update_user_profile", "", {
              "updated_skills": skills,
              "updated_interests": interests,
              "updated_certifications": certs
            });
          case 3:
            result = _context4.v;
            if (result) {
              setAllowSkip(false);
              setShowManualEntry(false);
              setCurrentStep(3);
            } else {
              showAlert("Failed to save profile. Please try again.");
            }
            _context4.n = 5;
            break;
          case 4:
            _context4.p = 4;
            _t2 = _context4.v;
            console.log(_t2);
            showAlert("An error occurred while saving. Try again.");
          case 5:
            _context4.p = 5;
            setSavingProfile(false);
            return _context4.f(5);
          case 6:
            return _context4.a(2);
        }
      }, _callee4, null, [[2, 4, 5, 6]]);
    }));
    return _saveStep.apply(this, arguments);
  }
  useEffect(function () {
    var percent = currentStep / 4 * 100;
    setProgress(percent + "%");
  }, [currentStep]);
  var steps = [{
    id: 1,
    title: "Upload Your CV",
    description: "",
    icon: __jacJsx(CloudUpload, {
      "style": {
        "fontSize": "0.75rem"
      }
    }, []),
    completed: false
  }, {
    id: 2,
    title: "Review & Update Profile",
    description: "",
    icon: __jacJsx(Brain, {
      "style": {
        "fontSize": "0.75rem"
      }
    }, []),
    completed: false
  }, {
    id: 3,
    title: "Set Career Goals",
    description: "",
    icon: __jacJsx(Goal, {
      "style": {
        "fontSize": "0.75rem"
      }
    }, []),
    completed: false
  }, {
    id: 4,
    title: "Get Your Roadmap",
    description: "",
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
    _handleStep1Next = _asyncToGenerator(/*#__PURE__*/_regenerator().m(function _callee5() {
      var base64Data, result, user_skills, body, detected_skills, detected_interests, detected_certs, _t3;
      return _regenerator().w(function (_context5) {
        while (1) switch (_context5.p = _context5.n) {
          case 0:
            if (!(!canProceed || isLoading || !file)) {
              _context5.n = 1;
              break;
            }
            return _context5.a(2);
          case 1:
            setIsLoading(true);
            setError("");
            setShowManualEntry(false);
            _context5.p = 2;
            _context5.n = 3;
            return __jacSpawn("create_resume_node", "", {});
          case 3:
            _context5.n = 4;
            return fileToBase64(file);
          case 4:
            base64Data = _context5.v;
            _context5.n = 5;
            return __jacSpawn("upload_resume", "", {
              "file": base64Data,
              "name": file.name,
              "mime": file.type
            });
          case 5:
            result = _context5.v;
            if (result) {
              _context5.n = 6;
              break;
            }
            showAlert("Resume upload failed");
            setShowManualEntry(true);
            setIsLoading(false);
            setAllowSkip(true);
            return _context5.a(2);
          case 6:
            _context5.n = 7;
            return __jacSpawn("save_resume", "", {});
          case 7:
            _context5.n = 8;
            return __jacSpawn("update_resume_upload_status", "", {});
          case 8:
            _context5.n = 9;
            return __jacSpawn("analyze_cv", "", {});
          case 9:
            user_skills = _context5.v;
            if (!(!user_skills || !user_skills.reports || user_skills.reports.length === 0)) {
              _context5.n = 10;
              break;
            }
            showAlert("Something went wrong. Please upload another document or enter details manually.");
            setAllowSkip(true);
            setShowManualEntry(true);
            setIsLoading(false);
            return _context5.a(2);
          case 10:
            if (!(user_skills.reports[0]["status"] !== "Success")) {
              _context5.n = 11;
              break;
            }
            showAlert("Something went wrong. Please upload another document or enter details manually.");
            setAllowSkip(true);
            setShowManualEntry(true);
            setIsLoading(false);
            return _context5.a(2);
          case 11:
            try {
              body = "body" in user_skills.reports[0] ? user_skills.reports[0]["body"] : {};
              detected_skills = "skills" in body ? body["skills"] : [];
              detected_interests = "interests" in body ? body["interests"] : [];
              detected_certs = "certifications" in body ? body["certifications"] : [];
              setSkills(detected_skills);
              setInterests(detected_interests);
              setCerts(detected_certs);
            } catch (e) {
              console.log(e);
            }
            setAllowSkip(false);
            setCurrentStep(2);
            _context5.n = 13;
            break;
          case 12:
            _context5.p = 12;
            _t3 = _context5.v;
            console.log(_t3);
            showAlert("Something went wrong. Try again later");
            setAllowSkip(true);
            setShowManualEntry(true);
          case 13:
            _context5.p = 13;
            setIsLoading(false);
            return _context5.f(13);
          case 14:
            return _context5.a(2);
        }
      }, _callee5, null, [[2, 12, 13, 14]]);
    }));
    return _handleStep1Next.apply(this, arguments);
  }
  var wrapperStyle = {
    "width": "100%",
    "height": "100vh",
    "display": "grid",
    "gridTemplateColumns": "45% 55%",
    "position": "relative",
    "color": "white",
    "fontFamily": "system-ui, sans-serif"
  };
  var leftPanelInnerStyle = {
    "margin": "auto",
    "backgroundColor": "#0b0b0b",
    "width": "95%",
    "height": "90%",
    "zIndex": "9999",
    "borderRadius": "10px",
    "display": "flex",
    "flexDirection": "column",
    "justifyContent": "center",
    "alignItems": "center",
    "overflow": "hidden"
  };
  var rightInnerStyle = {
    "width": "90%",
    "height": "90%",
    "display": "flex",
    "flexDirection": "column",
    "justifyContent": "center"
  };
  var uploadBoxStyle = {
    "marginBlock": "30px",
    "height": "40vh",
    "width": "80%",
    "borderRadius": "15px",
    "display": "flex",
    "flexDirection": "column",
    "justifyContent": "center",
    "alignItems": "center",
    "transition": "0.2s ease"
  };
  if (resumeHover) {
    uploadBoxStyle["border"] = "2px dashed #6e11b0";
    uploadBoxStyle["backgroundColor"] = "#0b0b0b";
  } else {
    uploadBoxStyle["border"] = "2px dashed grey";
    uploadBoxStyle["backgroundColor"] = "#101010ff";
  }
  var uploadLabelStyle = {
    "width": "auto",
    "padding": "1rem 1.5rem",
    "border": "none",
    "borderRadius": "0.5rem",
    "backgroundColor": "#6e11b0",
    "color": "white",
    "fontWeight": "600",
    "fontSize": "0.875rem",
    "cursor": "pointer",
    "transition": "all 0.2s ease",
    "marginTop": "10px",
    "boxShadow": "0 0 20px rgba(110, 17, 176, 0.2)"
  };
  var nextBtnBaseStyle = {
    "width": "180px",
    "border": "none",
    "paddingInline": "2.5rem",
    "paddingBlock": "1rem",
    "borderRadius": "5px",
    "cursor": "pointer",
    "fontSize": "16px",
    "transition": "transform 0.2s ease",
    "color": "white",
    "backgroundColor": "#6e11b0",
    "transform": navbtnHover ? "translateY(0.25rem)" : "translateY(0)"
  };
  if (currentStep === 1 && !canProceed || isLoading) {
    nextBtnBaseStyle["opacity"] = "0.4";
    nextBtnBaseStyle["cursor"] = "not-allowed";
  }
  var nextBtnContent = null;
  if (currentStep === 1 && isLoading) {
    nextBtnContent = LoadingDots();
  } else if (currentStep === 2 && savingProfile) {
    nextBtnContent = LoadingDots();
  } else {
    nextBtnContent = __jacJsx("label", {}, ["Next"]);
  }
  function Step(props) {
    var isActive = props.step.id === currentStep;
    var circleStyle = {
      "width": "40px",
      "aspectRatio": "1",
      "borderRadius": "50%",
      "display": "flex",
      "alignItems": "center",
      "justifyContent": "center",
      "color": "white",
      "position": "relative",
      "zIndex": "1",
      "transition": "all 0.2s ease",
      "boxShadow": "none",
      "backgroundColor": "#000000"
    };
    if (isActive || props.step.id < currentStep) {
      circleStyle["backgroundColor"] = "#6e11b0";
    } else {
      circleStyle["backgroundColor"] = "black";
    }
    if (isActive) {
      circleStyle["boxShadow"] = "0 0 20px rgba(110, 17, 176, 0.5)";
    }
    var connectorDisplay = null;
    if (props.step.id !== 4) {
      var connectorStyle = {
        "position": "absolute",
        "height": "calc(100% + 65px)",
        "width": "2px",
        "left": "calc(50% + 1px)",
        "top": "100%",
        "transform": "translateX(-50%)",
        "zIndex": "-1",
        "transition": "all 0.2s ease",
        "borderLeft": "2px dashed grey"
      };
      if (props.step.id < currentStep) {
        connectorStyle["borderLeft"] = "2px dashed #6e11b0";
      } else {
        connectorStyle["borderLeft"] = "2px dashed grey";
      }
      connectorDisplay = __jacJsx("div", {
        "style": connectorStyle
      }, []);
    }
    var titleStyle = {
      "marginBottom": "0px",
      "fontWeight": "600",
      "color": "rgba(255, 255, 255, 0.6)",
      "fontSize": "1.15rem"
    };
    if (props.step.id <= currentStep) {
      titleStyle["color"] = "white";
    }
    return __jacJsx("div", {
      "style": {
        "display": "flex",
        "flexDirection": "row",
        "gap": "36px",
        "alignItems": "center",
        "width": "75%",
        "marginInline": "auto",
        "marginBottom": "45px"
      }
    }, [__jacJsx("div", {
      "style": circleStyle
    }, [__jacJsx("div", {
      "style": {
        "display": "flex",
        "alignItems": "center",
        "justifyContent": "center"
      }
    }, [props.step.icon, connectorDisplay])]), __jacJsx("div", {}, [__jacJsx("h1", {
      "style": titleStyle
    }, [props.step.title]), __jacJsx("p", {
      "style": {
        "color": "grey",
        "marginBlock": "0px",
        "marginTop": "10px"
      }
    }, [props.step.description])])]);
  }
  var stepsList = steps.map(function (step) {
    return __jacJsx(Step, {
      "key": step.id,
      "step": step
    }, []);
  });
  var uploadedFileDisplay = null;
  if (fileName && fileName !== "") {
    uploadedFileDisplay = __jacJsx("div", {
      "style": {
        "marginTop": "20px",
        "fontSize": "14px",
        "color": "white",
        "fontWeight": "500"
      }
    }, ["Uploaded: ", fileName]);
  }
  var manualSkipDisplay = null;
  if (allowSkip && currentStep === 1) {
    manualSkipDisplay = __jacJsx("div", {
      "style": {
        "fontSize": "15px",
        "cursor": "pointer",
        "color": "white",
        "textDecoration": "underline",
        "fontWeight": "500"
      },
      "onClick": function onClick(e) {
        setAllowSkip(false);
        setCurrentStep(2);
      }
    }, ["Skip →"]);
  }
  var step1Content = null;
  if (currentStep === 1) {
    step1Content = __jacJsx("div", {
      "style": {
        "height": "60vh"
      }
    }, [__jacJsx("div", {
      "style": {
        "marginBottom": "0px",
        "fontWeight": "600",
        "color": "white",
        "fontSize": "1.15rem"
      }
    }, ["Upload your CV"]), __jacJsx("p", {
      "style": {
        "color": "grey",
        "marginBlock": "0px",
        "marginTop": "10px"
      }
    }, ["Let us start by understanding your background"]), __jacJsx("div", {
      "onMouseEnter": function onMouseEnter(e) {
        setResumeHover(true);
      },
      "onMouseLeave": function onMouseLeave(e) {
        setResumeHover(false);
      },
      "onDragOver": handleDragOver,
      "onDragLeave": handleDragLeave,
      "onDrop": handleDrop,
      "style": uploadBoxStyle
    }, [__jacJsx("div", {
      "style": {
        "width": "55px",
        "aspectRatio": "1",
        "borderRadius": "50%",
        "backgroundColor": "black",
        "display": "flex",
        "alignItems": "center",
        "justifyContent": "center",
        "marginBottom": "15px"
      }
    }, [__jacJsx(CloudUpload, {
      "style": {
        "fontSize": "0.75rem",
        "color": "#6e11b0"
      }
    }, [])]), __jacJsx("p", {
      "style": _defineProperty(_defineProperty({
        "color": "grey",
        "marginBlock": "0px"
      }, "marginBlock", "20px"), "fontSize", ".9em")
    }, ["Supported formats: PDF, DOC, DOCX (Max 5MB)"]), __jacJsx("input", {
      "type": "file",
      "accept": ".pdf,.doc,.docx",
      "onChange": handleFileSelect,
      "style": {
        "display": "none"
      },
      "id": "resumeInput"
    }, []), __jacJsx("label", {
      "for": "resumeInput",
      "style": uploadLabelStyle,
      "onMouseEnter": function onMouseEnter(e) {
        e.currentTarget.style.filter = "brightness(0.95)";
      },
      "onMouseLeave": function onMouseLeave(e) {
        e.currentTarget.style.filter = "brightness(1)";
      }
    }, ["Upload from Computer"]), uploadedFileDisplay])]);
  }
  var step2Content = null;
  if (currentStep === 2) {
    if (step2Loading) {
      step2Content = step2LoadingView;
    } else {
      step2Content = __jacJsx("div", {
        "style": {
          "height": "65vh",
          "overflowY": "auto",
          "paddingRight": "10px"
        }
      }, [__jacJsx("div", {
        "style": {
          "marginBottom": "25px"
        }
      }, [__jacJsx("h2", {
        "style": {
          "color": "white",
          "marginBottom": "8px"
        }
      }, ["Skills"]), __jacJsx("div", {
        "style": {
          "display": "flex",
          "flexDirection": "row",
          "gap": "10px",
          "marginBottom": "12px"
        }
      }, [__jacJsx("input", {
        "type": "text",
        "value": newSkill,
        "onChange": function onChange(e) {
          setNewSkill(e.target.value);
        },
        "onKeyDown": function onKeyDown(e) {
          if (e.key === "Enter") {
            addSkill();
          }
        },
        "placeholder": "Python, Project Management, etc.",
        "style": {
          "flex": "1",
          "backgroundColor": "#0b0b0b",
          "border": "1px solid #333",
          "color": "white",
          "padding": "8px",
          "borderRadius": "6px"
        }
      }, []), __jacJsx("button", {
        "onClick": function onClick(e) {
          addSkill();
        },
        "style": {
          "padding": "8px 12px",
          "backgroundColor": "#6e11b0",
          "color": "white",
          "border": "none",
          "borderRadius": "6px",
          "cursor": "pointer"
        }
      }, ["Add"])]), skills.length === 0 && __jacJsx("p", {
        "style": {
          "color": "grey"
        }
      }, ["No skills added"]), skills.length > 0 && __jacJsx("div", {
        "style": {
          "display": "flex",
          "flexWrap": "wrap",
          "gap": "8px"
        }
      }, [skills.map(function (s, idx) {
        return __jacJsx("div", {
          "key": idx,
          "style": {
            "display": "flex",
            "alignItems": "center",
            "gap": "6px",
            "padding": "4px 10px",
            "backgroundColor": "#0d0d0d",
            "borderRadius": "9999px",
            "fontSize": "0.85rem",
            "color": "white"
          }
        }, [__jacJsx("span", {}, [s.name]), __jacJsx("span", {
          "style": {
            "color": "#dc2626",
            "cursor": "pointer",
            "fontWeight": "700"
          },
          "onClick": function onClick(e) {
            removeSkill(s.name);
          }
        }, ["×"])]);
      })])]), __jacJsx("div", {
        "style": {
          "marginBottom": "25px"
        }
      }, [__jacJsx("h2", {
        "style": {
          "color": "white",
          "marginBottom": "8px"
        }
      }, ["Interests"]), __jacJsx("div", {
        "style": {
          "display": "flex",
          "flexDirection": "row",
          "gap": "10px",
          "marginBottom": "12px"
        }
      }, [__jacJsx("input", {
        "type": "text",
        "value": newInterest,
        "onChange": function onChange(e) {
          setNewInterest(e.target.value);
        },
        "onKeyDown": function onKeyDown(e) {
          if (e.key === "Enter") {
            addInterest();
          }
        },
        "placeholder": "Add new interest",
        "style": {
          "flex": "1",
          "backgroundColor": "#0b0b0b",
          "border": "1px solid #333",
          "color": "white",
          "padding": "8px",
          "borderRadius": "6px"
        }
      }, []), __jacJsx("button", {
        "onClick": function onClick(e) {
          addInterest();
        },
        "style": {
          "padding": "8px 12px",
          "backgroundColor": "#6e11b0",
          "color": "white",
          "border": "none",
          "borderRadius": "6px",
          "cursor": "pointer"
        }
      }, ["Add"])]), interests.length === 0 && __jacJsx("p", {
        "style": {
          "color": "grey"
        }
      }, ["No interests added"]), interests.length > 0 && __jacJsx("div", {
        "style": {
          "display": "flex",
          "flexWrap": "wrap",
          "gap": "8px"
        }
      }, [interests.map(function (i, idx) {
        return __jacJsx("div", {
          "key": idx,
          "style": {
            "display": "flex",
            "alignItems": "center",
            "gap": "6px",
            "padding": "4px 10px",
            "backgroundColor": "#0d0d0d",
            "borderRadius": "9999px",
            "fontSize": "0.85rem",
            "color": "white"
          }
        }, [__jacJsx("span", {}, [i.name]), __jacJsx("span", {
          "style": {
            "color": "#dc2626",
            "cursor": "pointer",
            "fontWeight": "700"
          },
          "onClick": function onClick(e) {
            removeInterest(i.name);
          }
        }, ["×"])]);
      })])]), __jacJsx("div", {}, [__jacJsx("h2", {
        "style": {
          "color": "white",
          "marginBottom": "8px"
        }
      }, ["Certifications"]), __jacJsx("div", {
        "style": {
          "display": "flex",
          "flexDirection": "row",
          "gap": "10px",
          "marginBottom": "12px"
        }
      }, [__jacJsx("input", {
        "type": "text",
        "value": newCert,
        "onChange": function onChange(e) {
          setNewCert(e.target.value);
        },
        "onKeyDown": function onKeyDown(e) {
          if (e.key === "Enter") {
            addCert();
          }
        },
        "placeholder": "Add certification",
        "style": {
          "flex": "1",
          "backgroundColor": "#0b0b0b",
          "border": "1px solid #333",
          "color": "white",
          "padding": "8px",
          "borderRadius": "6px"
        }
      }, []), __jacJsx("button", {
        "onClick": function onClick(e) {
          addCert();
        },
        "style": {
          "padding": "8px 12px",
          "backgroundColor": "#6e11b0",
          "color": "white",
          "border": "none",
          "borderRadius": "6px",
          "cursor": "pointer"
        }
      }, ["Add"])]), certs.length === 0 && __jacJsx("p", {
        "style": {
          "color": "grey"
        }
      }, ["No certifications added"]), certs.length > 0 && __jacJsx("div", {
        "style": {
          "display": "flex",
          "flexWrap": "wrap",
          "gap": "8px"
        }
      }, [certs.map(function (c, idx) {
        return __jacJsx("div", {
          "key": idx,
          "style": {
            "display": "flex",
            "alignItems": "center",
            "gap": "6px",
            "padding": "4px 10px",
            "backgroundColor": "#0d0d0d",
            "borderRadius": "9999px",
            "fontSize": "0.85rem",
            "color": "white"
          }
        }, [__jacJsx("span", {}, [c.title]), __jacJsx("span", {
          "style": {
            "color": "#dc2626",
            "cursor": "pointer",
            "fontWeight": "700"
          },
          "onClick": function onClick(e) {
            removeCert(c.title);
          }
        }, ["×"])]);
      })])])]);
    }
  }
  var step3Content = null;
  if (currentStep === 3) {
    step3Content = __jacJsx("div", {
      "style": {
        "height": "60vh"
      }
    }, ["hello"]);
  }
  var step4Content = null;
  if (currentStep === 4) {
    step4Content = __jacJsx("div", {
      "style": {
        "height": "60vh"
      }
    }, ["hello"]);
  }
  var backNav = null;
  if (currentStep > 1) {
    backNav = __jacJsx("div", {
      "onClick": function onClick(e) {
        setCurrentStep(currentStep - 1);
      },
      "style": {
        "display": "flex",
        "flexDirection": "row",
        "alignItems": "center",
        "cursor": "pointer"
      }
    }, [__jacJsx(ChevronLeft, {}, []), "Back"]);
  }
  var nextBtn = __jacJsx("button", {
    "type": "button",
    "onClick": function onClick(e) {
      if (currentStep === 1) {
        handleStep1Next();
      } else if (currentStep === 2) {
        saveStep2();
      } else if (currentStep < 4) {
        setCurrentStep(currentStep + 1);
      }
    },
    "onMouseEnter": function onMouseEnter(e) {
      setNavBtnHover(true);
    },
    "onMouseLeave": function onMouseLeave(e) {
      setNavBtnHover(false);
    },
    "style": nextBtnBaseStyle,
    "disabled": currentStep === 1 && !canProceed || isLoading
  }, [nextBtnContent]);
  var step2LoadingView = __jacJsx("div", {
    "style": {
      "color": "white",
      "fontSize": "1rem",
      "marginTop": "20px"
    }
  }, ["Loading your profile..."]);
  var alertBox = null;
  if (alertVisible) {
    alertBox = __jacJsx("div", {
      "style": {
        "position": "absolute",
        "top": "20px",
        "right": "20px",
        "padding": "12px 20px",
        "backgroundColor": "#dc2626",
        "color": "white",
        "borderRadius": "6px",
        "fontWeight": "600",
        "boxShadow": "0 0 15px rgba(0,0,0,0.4)",
        "transition": "0.3s ease"
      }
    }, [alertMessage]);
  }
  return __jacJsx("div", {
    "style": wrapperStyle
  }, [alertBox, __jacJsx("div", {
    "style": {
      "width": "100%",
      "height": "100%",
      "display": "flex",
      "justifyContent": "center",
      "alignItems": "center"
    }
  }, [__jacJsx("div", {
    "style": leftPanelInnerStyle
  }, [stepsList])]), __jacJsx("div", {
    "style": {
      "width": "100%",
      "height": "95%",
      "marginBlock": "auto",
      "display": "flex",
      "justifyContent": "center",
      "alignItems": "center"
    }
  }, [__jacJsx("div", {
    "style": rightInnerStyle
  }, [__jacJsx("div", {
    "style": {
      "color": "grey",
      "textTransform": "uppercase"
    }
  }, ["Step ", currentStep, " of 4"]), __jacJsx("div", {
    "style": {
      "width": "80%",
      "height": "11px",
      "borderRadius": "20px",
      "backgroundColor": "#0b0b0b",
      "overflow": "hidden",
      "marginBlock": "20px"
    }
  }, [__jacJsx("div", {
    "style": {
      "height": "100%",
      "width": progress,
      "backgroundColor": "#6e11b0",
      "transition": "0.3s ease",
      "borderRadius": "20px"
    }
  }, [])]), step1Content, step2Content, step3Content, step4Content, __jacJsx("div", {
    "style": {
      "display": "flex",
      "flexDirection": "row",
      "gap": "25px",
      "alignItems": "center",
      "marginTop": "20px"
    }
  }, [backNav, nextBtn, manualSkipDisplay])])])]);
}
function Dashboard() {
  return __jacJsx("div", {}, []);
}
function app() {
  document.body.style.margin = "0";
  document.body.style.padding = "0";
  document.body.style.backgroundColor = "black";
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
  return __jacJsx(Router, {}, [__jacJsx("div", {}, [__jacJsx(Routes, {}, [__jacJsx(Route, {
    "path": "/",
    "element": __jacJsx(Website, {}, [])
  }, []), __jacJsx(Route, {
    "path": "/auth",
    "element": __jacJsx(Auth, {}, [])
  }, []), __jacJsx(Route, {
    "path": "/onboarding",
    "element": __jacJsx(Onboarding, {}, [])
  }, []), __jacJsx(Route, {
    "path": "/dashboard",
    "element": __jacJsx(Dashboard, {}, [])
  }, [])])])]);
}
export { Auth, Dashboard, LoadingDots, Onboarding, Website, app };