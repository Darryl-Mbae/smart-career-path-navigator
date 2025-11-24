import { __jacJsx, __jacSpawn } from "@jac-client/utils";
function Website() {
  return __jacJsx("div", {}, [__jacJsx("h1", {}, ["Hello World"])]);
}
function Auth() {
  return __jacJsx("div", {}, []);
}
function Onboarding() {
  return __jacJsx("div", {}, []);
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
  return __jacJsx(Website, {}, []);
}
export { Auth, Dashboard, Onboarding, Website, app };