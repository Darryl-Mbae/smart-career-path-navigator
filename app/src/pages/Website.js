import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { useState, useRef, useEffect } from "react";
import { useNavigate } from "@jac-client/utils";
import { Mail, User, ChevronUp, ChevronRight, ChevronLeft, Github, Linkedin, AudioLines } from "lucide-react";
import { Accordion } from "radix-ui";
import { ChevronDownIcon } from "@radix-ui/react-icons";
import Darryl from "@jac-client/assets/team/Darryl.png";
import Dennis from "@jac-client/assets/team/Dennis.png";
import Moha from "@jac-client/assets/team/Moha.png";
import skills from "@jac-client/assets/images/mac-skills.png";
import { Swiper, SwiperSlide } from "swiper/react";
import { Navigation, Pagination } from "swiper/modules";
function Website() {
  useEffect(() => {
    let cssLink = document.createElement("link");
    cssLink.rel = "stylesheet";
    cssLink.href = "https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css";
    document.head.appendChild(cssLink);
  }, []);
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
    return __jacJsx("div", {"className": "w-[90%] my-[15vh] mx-auto grid grid-cols-1 lg:grid-cols-[50%_50%] mb-[10vh] lg:mb-[20vh]"}, [__jacJsx("div", {"className": "w-full overflow-hidden relative mb-4 lg:mb-0 lg:w-[90%] bg-primary rounded-4xl aspect-square"}, [__jacJsx("img", {"src": skills, "alt": "skills illustration", "className": "absolute top-10 -right-50 lg:top-20 lg:-right-80 h-[80%] w-auto max-w-none"}, [])]), __jacJsx("div", {"className": "w-full lg:w-[90%] ml-[5%] flex flex-col justify-center"}, [__jacJsx(AudioLines, {"className": "w-10 h-10 mb-4 text-purple-300"}, []), __jacJsx("h2", {"className": "font-bold text-4xl text-white mb-7 w-full font-sans"}, ["AI-Powered Career Mapping,", __jacJsx("br", {}, []), " Made for Learners"]), __jacJsx("p", {"className": "text-base text-gray-100 mb-8 w-[95%]"}, ["Arise is an intelligent career platform that analyzes your skills, identifies career opportunities, ", "and", " creates personalized learning roadmaps to help you reach your professional goals."]), __jacJsx("div", {"className": "w-[90%] bg-[#0b0b0b] text-white placeholder-gray-400 lg:w-[85%] flex items-center gap-3 py-4 px-4 mt-6 rounded-lg"}, [__jacJsx("div", {"className": "w-1.5 h-1.5 rounded-full bg-primary"}, []), __jacJsx("div", {"className": ""}, ["Analyzing your CV and skill profile"])]), __jacJsx("div", {"className": "w-[90%] bg-[#0b0b0b] text-white placeholder-gray-400 lg:w-[85%] flex items-center gap-3 py-4 px-4 mt-2 rounded-lg"}, [__jacJsx("div", {"className": "w-1.5 h-1.5 rounded-full bg-primary"}, []), __jacJsx("div", {"className": ""}, ["Identifying career opportunities that fit you"])]), __jacJsx("div", {"className": "w-[90%] bg-[#0b0b0b] text-white placeholder-gray-400 lg:w-[85%] flex items-center gap-3  py-4 px-4 mt-2 rounded-lg"}, [__jacJsx("div", {"className": "w-1.5 h-1.5 rounded-full bg-primary"}, []), __jacJsx("div", {"className": ""}, ["Highlighting skill gaps and growth areas"])]), __jacJsx("div", {"className": "w-[90%] bg-[#0b0b0b] text-white placeholder-gray-400 lg:w-[85%] flex items-center gap-3  py-4 px-4 mt-2 rounded-lg"}, [__jacJsx("div", {"className": "w-1.5 h-1.5 rounded-full bg-primary"}, []), __jacJsx("div", {"className": ""}, ["Building personalized learning roadmaps"])])])]);
  }
  function Team() {
    let swiperRef = useRef(null);
    let [activeSlide, setActiveIndex] = useState(0);
    let paragraph = "Arise is led by passionate students with diverse experiences. Our team brings together different perspectives to create an AI-powered career mapping platform that empowers learners to achieve their professional goals.";
    let startIndex = Math.floor(Math.random() * 3);
    let teamMembers = [{id: 1, name: "Darryl Mbae", image: Darryl}, {id: 2, name: "Kiptanui Denis", image: Dennis}, {id: 3, name: "Mohamed Ibrahim", image: Moha}, {id: 4, name: "Darryl Mbae", image: Darryl}, {id: 5, name: "Kiptanui Denis", image: Dennis}, {id: 6, name: "Mohammed", image: Moha}];
    return __jacJsx("div", {"className": "w-[80%] mx-auto py-20 grid grid-cols-1 lg:grid-cols-[40%_60%] gap-10 items-center"}, [__jacJsx("div", {}, [__jacJsx(User, {"className": "w-10 h-10 mb-4 text-purple-300"}, []), __jacJsx("h2", {"className": "font-bold text-4xl text-white mb-7 w-full font-sans"}, ["Built by Students,", __jacJsx("br", {}, []), " For Students"]), __jacJsx("p", {"className": "text-base text-gray-100  mb-8 w-[95%]"}, [paragraph])]), __jacJsx("div", {"className": "relative"}, [__jacJsx("div", {"className": "absolute left-0 bottom-0 w-full lg:w-[calc(33.333%-20px)] z-20 pointer-events-none"}, [__jacJsx("div", {"className": "w-full bg-primary backdrop-blur-sm rounded-xl px-5 py-3 border border-gray-700/50 shadow-xl"}, [__jacJsx("h3", {"className": "text-white font-bold text-lg mb-3"}, [teamMembers[activeSlide].name]), __jacJsx("div", {"className": "flex gap-2"}, [__jacJsx("button", {"className": "w-8 h-8 rounded-full border border-white cursor-pointer flex items-center justify-center transition-colors pointer-events-auto"}, [__jacJsx("span", {"className": "text-white text-xs flex items-center justify-center"}, [__jacJsx(Linkedin, {"className": "h-3 w-3 m-auto"}, [])])]), __jacJsx("button", {"className": "w-8 h-8 rounded-full border border-white cursor-pointer flex items-center justify-center transition-colors pointer-events-auto"}, [__jacJsx("span", {"className": "text-white text-xs flex items-center justify-center"}, [__jacJsx(Github, {"className": "h-3 w-3 m-auto"}, [])])]), __jacJsx("button", {"className": "w-8 h-8 rounded-full border border-white cursor-pointer flex items-center justify-center transition-colors pointer-events-auto"}, [__jacJsx("span", {"className": "text-white text-xs flex items-center justify-center"}, [__jacJsx(Mail, {"className": "h-3 w-3 m-auto"}, [])])])])])]), __jacJsx(Swiper, {"initialSlide": startIndex, "onSwiper": swiper => {
      swiperRef.current = swiper;
    }, "onSlideChange": swiper => {
      setActiveIndex(swiper.realIndex);
    }, "slidesPerView": 3, "modules": [Navigation, Pagination], "spaceBetween": 20, "loop": true, "breakpoints": {0: {slidesPerView: 1, spaceBetween: 15}, 640: {slidesPerView: 1, spaceBetween: 20}, 768: {slidesPerView: 2, spaceBetween: 20}, 1024: {slidesPerView: 3, spaceBetween: 30}, 1280: {slidesPerView: 3, spaceBetween: 30}}, "pagination": {clickable: true}, "className": "pb-12"}, [teamMembers.map(member => {
      return __jacJsx(SwiperSlide, {"key": member.id}, [__jacJsx("div", {"className": "h-64 rounded-2xl overflow-hidden transition-all duration-500 grayscale hover:grayscale-0 swiper-slide-active:grayscale-0"}, [__jacJsx("img", {"src": member.image, "className": "w-full h-full object-cover"}, [])])]);
    })])])]);
  }
  function NewsletterSubscribe() {
    let [email, setEmail] = useState("");
    let [isSubmitting, setIsSubmitting] = useState(false);
    let [btnHover, setBtnHover] = useState(false);
    return __jacJsx("div", {"className": "w-11/12 mx-auto rounded-3xl text-white py-16 flex flex-col items-center justify-center shadow-[0_25px_50px_-12px_rgba(0,0,0,0.25)] my-16"}, [__jacJsx(Mail, {"className": "w-10 h-10 mb-4 text-purple-300"}, []), __jacJsx("h2", {"className": "font-bold text-4xl text-center mb-7 w-3/5 font-sans"}, ["Stay Ahead of the Curve"]), __jacJsx("p", {"className": "text-base text-gray-100 text-center mb-8 max-w-3xl"}, ["Get exclusive insights, product updates, and early access delivered straight to your inbox."]), __jacJsx("form", {"className": "w-1/2 flex flex-row gap-4 mx-auto"}, [__jacJsx("input", {"type": "email", "placeholder": "Enter your email", "value": email, "disabled": isSubmitting, "required": true, "onChange": e => {
      setEmail(e.target.value);
    }, "className": "grow py-4 px-5 rounded-lg border- border-purple-600 bg-[#0b0b0b] text-white placeholder-gray-400 focus:outline-none focus:border-purple-400 transition duration-200"}, []), __jacJsx("button", {"type": "submit", "disabled": isSubmitting, "onMouseEnter": e => {
      setBtnHover(true);
    }, "onMouseLeave": e => {
      setBtnHover(false);
    }, "className": `px-6 py-4 rounded-md bg-purple-800 text-white font-semibold uppercase text-sm cursor-pointer transition-transform duration-200 ease-in-out transform ${btnHover ? "translate-y-1" : "translate-y-0"} ${isSubmitting ? "opacity-50" : "opacity-100"}`}, [isSubmitting ? "Subscribing..." : "Subscribe"])])]);
  }
  function FAQs() {
    let faqData = [{value: "arise", question: "What is Arise and how does it work?", answer: "Arise is an AI-powered career mapping platform that analyzes your CV, identifies career opportunities, and generates personalized learning roadmaps."}, {value: "formats", question: "Which file formats are supported for CV upload?", answer: "You can upload PDF, DOC, and DOCX files. Arise automatically extracts skills, experience, and certifications."}, {value: "roles", question: "How does Arise recommend career roles?", answer: "Arise uses AI and real-time job market data to match your skills with roles that align with your career goals."}, {value: "roadmap", question: "Can I customize my learning roadmap?", answer: "Yes. You can add or remove skills, update career goals, and Arise will regenerate your roadmap."}, {value: "security", question: "Is my data safe on Arise?", answer: "Absolutely. Your data is securely stored in Jaseci\u2019s graph database and never shared without your consent."}, {value: "pricing", question: "Do I need a subscription to use Arise?", answer: "Arise offers both free and premium plans. Premium users access advanced skill gap analysis and learning paths."}, {value: "updates", question: "How often are recommendations updated?", answer: "Career suggestions and learning paths are updated in real time using live market data."}, {value: "tracking", question: "Can I track my progress?", answer: "Yes. Arise\u2019s dashboard lets you track skills, certifications, and learning milestones."}];
    let [openItem, setOpenItem] = useState("");
    return __jacJsx("div", {"id": "FAQs", "className": "w-[88%] max-w-4xl mx-auto py-20"}, [__jacJsx("h2", {"className": "text-4xl font-bold text-center mb-10 text-white"}, ["Frequently Asked Questions"]), __jacJsx(Accordion.Root, {"type": "single", "collapsible": true, "value": openItem, "onValueChange": val => {
      setOpenItem(val);
    }, "className": "flex flex-col gap-3"}, [faqData.map(faq => {
      let chevronBase = "transition-transform duration-300";
      let chevronRotate = openItem === faq.value ? "rotate-180" : "";
      return __jacJsx(Accordion.Item, {"key": faq.value, "value": faq.value, "className": "bg-violet-800 rounded-lg border border-white/10 px-5 py-6"}, [__jacJsx(Accordion.Trigger, {"className": "w-full flex items-center justify-between text-left text-white text-base cursor-pointer bg-transparent border-none outline-none"}, [faq.question, __jacJsx(ChevronUp, {"className": chevronBase + " " + chevronRotate}, [])]), __jacJsx(Accordion.Content, {"className": "pt-3 text-gray-300 text-sm leading-relaxed"}, [faq.answer])]);
    })])]);
  }
  function Footer() {
    let currentYear = "2025";
    let socialLinks = [{name: "Twitter", href: "https://twitter.com/AriseAI", path: "M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"}, {name: "Instagram", href: "https://instagram.com/AriseAI", path: "M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"}, {name: "GitHub", href: "https://github.com/AriseAI", path: "M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"}, {name: "LinkedIn", href: "https://linkedin.com/company/AriseAI", path: "M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"}];
    let footerSections = [{title: "Company", links: [{label: "About Arise", href: "/about"}, {label: "Contact", href: "/contact"}, {label: "Careers", href: "/careers"}, {label: "Partnerships", href: "/partners"}]}, {title: "Resources", links: [{label: "Documentation", href: "/documentation"}, {label: "FAQs", href: "/faqs"}, {label: "Changelog", href: "/changelog"}, {label: "Support", href: "/support"}]}, {title: "Legal", links: [{label: "Privacy Policy", href: "/privacy"}, {label: "Terms of Service", href: "/terms"}, {label: "Voice Data Policy", href: "/voice-data-policy"}]}];
    return __jacJsx("footer", {"className": "py-12 w-full bg-black"}, [__jacJsx("div", {"className": "max-w-7xl mx-auto px-8"}, [__jacJsx("div", {"className": "bg-[#0b0b0b] rounded-3xl p-12 shadow-md"}, [__jacJsx("div", {"className": "grid grid-cols-5 gap-8 border-b border-gray-800 pb-10"}, [__jacJsx("div", {"className": "col-span-2 flex flex-col gap-6"}, [__jacJsx("div", {"className": "flex items-center gap-2"}, [__jacJsx("span", {"className": "text-white font-bold text-xl"}, ["Arise"])]), __jacJsx("p", {"className": "text-gray-400 max-w-xs leading-relaxed"}, ["Arise is an AI-powered career mapping platform that analyzes your skills, identifies career opportunities, and creates personalized learning roadmaps to help you achieve your professional goals."]), __jacJsx("div", {"className": "flex gap-4 pt-2"}, [socialLinks.map(social => {
      return __jacJsx("a", {"key": social.name, "href": social.href, "target": "_blank", "rel": "noopener noreferrer", "className": "text-gray-400 hover:text-white transition-colors"}, [__jacJsx("svg", {"className": "w-5 h-5 fill-current", "viewBox": "0 0 24 24"}, [__jacJsx("path", {"d": social.path}, [])])]);
    })])]), __jacJsx("div", {"className": "col-span-3 grid grid-cols-4 gap-6"}, [footerSections.map(section => {
      return __jacJsx("div", {"key": section.title, "className": "flex flex-col gap-2"}, [__jacJsx("h3", {"className": "text-white font-semibold text-sm"}, [section.title]), section.links.map(link => {
        return __jacJsx("a", {"key": link.href, "href": link.href, "className": "text-gray-400 text-sm hover:text-white"}, [link.label]);
      })]);
    })])]), __jacJsx("div", {"className": "flex flex-wrap justify-between items-center pt-6 gap-4"}, [__jacJsx("p", {"className": "text-gray-500 text-sm"}, ["© ", currentYear, " Arise. All rights reserved."]), __jacJsx("div", {"className": "flex gap-6 text-sm"}, [footerSections[2].links.map(link => {
      return __jacJsx("a", {"key": link.href, "href": link.href, "className": "text-gray-500 hover:text-white whitespace-nowrap"}, [link.label]);
    })])])])])]);
  }
  return __jacJsx("div", {"className": "w-full min-h-screen m-0 p-0 bg-black relative font-sans overflow-hidden"}, [__jacJsx(NavBar, {"sideBarActive": sideBarActive, "setSideBarActivate": setSideBarActivate}, []), __jacJsx(Sidebar, {"sideBarActive": sideBarActive, "setSideBarActivate": setSideBarActivate}, []), "   ", __jacJsx(Homepage, {}, []), __jacJsx(Demo, {}, []), __jacJsx(Features, {}, []), __jacJsx(Team, {}, []), __jacJsx(NewsletterSubscribe, {}, []), __jacJsx(FAQs, {}, []), __jacJsx(Footer, {}, [])]);
}
export { Website };
