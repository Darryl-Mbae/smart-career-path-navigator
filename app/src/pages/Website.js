import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { useState } from "react";
import { useNavigate } from "@jac-client/utils";
function Website() {
  let [sideBarActive, setSideBarActivate] = useState(false);
  function NavBar(props) {
    let links = ["CHANGELOG", "PRICING", "FAQs", "RESOURCES"];
    let navigate = useNavigate();
    function MobileNav() {
      return __jacJsx("div", {"className": "flex md:hidden items-center justify-between text-white"}, [__jacJsx("a", {"href": "/app", "className": "text-[1.125rem] font-semibold cursor-pointer text-white no-underline"}, ["Arise"]), __jacJsx("button", {"onClick": e => {
        props.setSideBarActivate(props.sideBarActive ? false : true);
      }, "type": "button"}, [])]);
    }
    function DesktopNav() {
      return __jacJsx("div", {"className": "hidden md:flex  items-center justify-between text-white "}, [__jacJsx("a", {"href": "/app", "className": "text-[1.125rem] font-semibold cursor-pointer text-white no-underline"}, ["Arise"]), __jacJsx("div", {"className": "flex items-center gap-[2rem]"}, [__jacJsx("ul", {"className": "relative z-10 flex items-center gap-[10px] list-none"}, [links.map(link => {
        return __jacJsx("li", {"key": link, "className": "relative text-[14px] cursor-pointer px-2 py-1 rounded-[4px]"}, [link]);
      })]), __jacJsx("button", {"onClick": e => {
        navigate("/auth");
      }, "className": "w-auto bg-primary text-white border-none cursor-pointer text-[16px] px-10 py-4 rounded-[5px] transition-transform duration-200 ease-in-out hover:translate-y-1"}, ["Get Started"])])]);
    }
    return __jacJsx("div", {"className": "sticky top-4 z-[99999] w-[calc(92%-6px)] mx-auto py-4 px-6 rounded-md transition-all duration-200 bg-[rgba(0,0,0,.5)] backdrop-blur-[12px] border border-transparent"}, [__jacJsx(MobileNav, {}, []), __jacJsx(DesktopNav, {}, [])]);
  }
  function Sidebar(props) {
    return __jacJsx("div", {}, []);
  }
  function Homepage() {
    let [btn1Hover, setBtn1Hover] = useState(false);
    let [btn2Hover, setBtn2Hover] = useState(false);
    return __jacJsx("div", {"className": "h-[75vh] w-[80%] mx-auto flex flex-col text-white mt-[5vh] grid grid-cols-[100%] md:grid-cols-[60%_40%]"}, [__jacJsx("div", {"className": "flex flex-col"}, [__jacJsx("div", {"className": "px-5 py-2 rounded-2xl bg-primary w-max mb-2 "}, ["Find Your Future"]), __jacJsx("h1", {"className": "font-zalando text-5xl md:text-6xl leading-none font-bold my-2"}, ["AI-Powered Career Mapping for the Modern Workforce "]), __jacJsx("p", {"className": "w-[95%]"}, ["Your skills tell a story. We analyze them, match them to emerging roles, and create a personalized growth roadmap — turning uncertainty into clarity and ambition into direction."]), __jacJsx("div", {"className": "w-[90%] mt-[2rem] flex flex-col md:flex-row gap-3 md:items-center"}, [__jacJsx("button", {"type": "button", "className": "w-auto bg-primary text-white border-none cursor-pointer text-base px-10 py-4 rounded-md transition-transform duration-200 ease-in-out hover:translate-y-1"}, ["Get Started"]), __jacJsx("button", {"type": "button", "onClick": e => {
      let section = document.getElementById("demo");
      section.scrollIntoView({behavior: "smooth"});
    }, "class": "w-auto border border-white bg-transparent text-white cursor-pointer text-base px-10 py-4 rounded-md transition-transform duration-200 ease-in-out hover:translate-y-1"}, ["View Demo"])])])]);
  }
  function Demo() {
    return __jacJsx("div", {"className": "w-full h-[102vh] mt-1 rounded-[50px] bg-primary"}, []);
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
  return __jacJsx("div", {"className": "w-full min-h-screen m-0 p-0 bg-black relative font-sans overflow-hidden"}, [__jacJsx(NavBar, {"sideBarActive": sideBarActive, "setSideBarActivate": setSideBarActivate}, []), __jacJsx(Sidebar, {"sideBarActive": sideBarActive, "setSideBarActivate": setSideBarActivate}, []), "   ", __jacJsx(Homepage, {}, []), __jacJsx(Demo, {}, []), __jacJsx(Features, {}, []), __jacJsx(Pricing, {}, []), __jacJsx(NewsletterSubscribe, {}, []), __jacJsx(FAQs, {}, []), __jacJsx(Footer, {}, [])]);
}
export { Website };
