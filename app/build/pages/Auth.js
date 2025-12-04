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
import { useState } from "react";
import { ChevronLeft } from "lucide-react";
import { useNavigate, jacSignup, jacLogin } from "@jac-client/utils";
function Auth() {
  var navigate = useNavigate();
  var _useState = useState(""),
    _useState2 = _slicedToArray(_useState, 2),
    loginEmail = _useState2[0],
    setLoginEmail = _useState2[1];
  var _useState3 = useState(""),
    _useState4 = _slicedToArray(_useState3, 2),
    loginPassword = _useState4[0],
    setLoginPassword = _useState4[1];
  var _useState5 = useState(""),
    _useState6 = _slicedToArray(_useState5, 2),
    signupName = _useState6[0],
    setSignupName = _useState6[1];
  var _useState7 = useState(""),
    _useState8 = _slicedToArray(_useState7, 2),
    signupEmail = _useState8[0],
    setSignupEmail = _useState8[1];
  var _useState9 = useState(""),
    _useState0 = _slicedToArray(_useState9, 2),
    signupPassword = _useState0[0],
    setSignupPassword = _useState0[1];
  var _useState1 = useState(true),
    _useState10 = _slicedToArray(_useState1, 2),
    isSignIn = _useState10[0],
    setIsSignIn = _useState10[1];
  var _useState11 = useState(""),
    _useState12 = _slicedToArray(_useState11, 2),
    error = _useState12[0],
    setError = _useState12[1];
  var baseClasses = "hidden md:flex w-1/2 h-full absolute top-0 justify-center items-center pointer-events-none transition-all duration-300 ease-in";
  var positionClass = isSignIn ? "left-1/2" : "left-0";
  var signInClass = isSignIn ? "block md:flex" : "hidden md:flex";
  var signUpClass = isSignIn ? "hidden md:flex" : "block md:flex";
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
            navigate("/dashboard");
          case 6:
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
  function Header() {
    return __jacJsx("div", {
      "className": "w-[90%] md:w-[calc(70%+1.25rem)] text-left mb-4"
    }, [__jacJsx("div", {
      "onClick": function onClick(e) {
        navigate("/");
      },
      "className": "flex flex-row items-center text-gray-400 cursor-pointer mb-2"
    }, [__jacJsx("span", {}, [__jacJsx(ChevronLeft, {}, [])]), __jacJsx("span", {
      "className": "ml-1"
    }, ["Back"])])]);
  }
  return __jacJsx("div", {
    "className": "w-full h-screen bg-black grid overflow-hidden grid-cols-[100%] md:grid-cols-[50%_50%] relative text-white"
  }, [__jacJsx("div", {
    "className": signInClass + " w-full h-screen flex items-center justify-center"
  }, [__jacJsx("div", {
    "className": "w-full flex flex-col items-center p-6"
  }, [__jacJsx(Header, {}, []), __jacJsx("h2", {
    "className": "w-[90%] md:w-[calc(70%+1.25rem)] text-xl font-bold my-[20px] md:pl-[10px]"
  }, ["Create your account"]), __jacJsx("form", {
    "onSubmit": handleLogin,
    "className": "w-full flex flex-col items-center w-[90%] md:w-[70%]"
  }, [__jacJsx("input", {
    "type": "email",
    "placeholder": "Email",
    "value": loginEmail,
    "onChange": function onChange(e) {
      setLoginEmail(e.target.value);
    },
    "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"
  }, []), __jacJsx("input", {}, []), __jacJsx("input", {
    "type": "password",
    "placeholder": "Password",
    "value": loginPassword,
    "onChange": function onChange(e) {
      setLoginPassword(e.target.value);
    },
    "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"
  }, []), __jacJsx("input", {}, []), error && __jacJsx("p", {
    "className": "text-[#dc2626] mb-4 text-sm"
  }, [error]), __jacJsx("button", {
    "type": "submit",
    "className": "w-full p-5 rounded-[8px] border-none bg-primary text-white font-semibold cursor-pointer"
  }, ["Sign In"])]), __jacJsx("p", {
    "className": "mt-[19px] text-[14px] text-[#bbbbbb] items-center"
  }, ["Don't have an account?", __jacJsx("span", {
    "onClick": function onClick(e) {
      setIsSignIn(false);
      setError("");
    },
    "className": "text-primary cursor-pointer ml-[5px] font-semibold"
  }, ["Sign Up"])])])]), __jacJsx("div", {
    "className": signUpClass + " w-full h-screen flex items-center justify-center"
  }, [__jacJsx("div", {
    "className": "w-full flex flex-col items-center p-6"
  }, [__jacJsx(Header, {}, []), __jacJsx("h2", {
    "className": "w-[90%] md:w-[calc(70%+1.25rem)] my-[20px] text-xl font-bold md:pl-[10px]"
  }, ["Create your account"]), __jacJsx("form", {
    "onSubmit": handleSignup,
    "className": "w-[90%] md:w-[70%] flex flex-col items-center"
  }, [__jacJsx("input", {
    "type": "text",
    "placeholder": "Full Name",
    "value": signupName,
    "onChange": function onChange(e) {
      setSignupName(e.target.value);
    },
    "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"
  }, []), __jacJsx("input", {
    "type": "email",
    "placeholder": "Email",
    "value": signupEmail,
    "onChange": function onChange(e) {
      setSignupEmail(e.target.value);
    },
    "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"
  }, []), __jacJsx("input", {
    "type": "password",
    "placeholder": "Password",
    "value": signupPassword,
    "onChange": function onChange(e) {
      setSignupPassword(e.target.value);
    },
    "className": "p-[1.25rem] rounded-[0.5rem] border-none bg-[#0b0b0b] text-white text-[16px] w-full mb-[16px]"
  }, []), __jacJsx("input", {}, []), error && __jacJsx("p", {
    "className": "text-[#dc2626] mb-4 text-sm"
  }, [error]), __jacJsx("button", {
    "type": "submit",
    "className": "w-full p-5 rounded-[8px] border-none bg-primary text-white font-semibold cursor-pointer"
  }, ["Sign Up"])]), __jacJsx("p", {
    "className": "mt-[19px] text-[14px] text-[#bbbbbb] items-center"
  }, ["Already have an account?", __jacJsx("span", {
    "onClick": function onClick(e) {
      setIsSignIn(true);
      setError();
    },
    "className": "text-primary cursor-pointer ml-[5px] font-semibold"
  }, ["Sign In"])])])]), __jacJsx("div", {
    "className": baseClasses + " " + positionClass
  }, [__jacJsx("div", {
    "className": "m-auto bg-primary w-[97%] h-[97%] z-[9999] rounded-[10px] flex justify-center items-center overflow-hidden"
  }, [])])]);
}
export { Auth };