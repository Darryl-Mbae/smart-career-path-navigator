import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { Website } from "./pages/Website.js";
import { Auth } from "./pages/Auth.js";
import { Dashboard } from "./pages/Dashboard.js";
import { Onboarding } from "./pages/Onboarding.js";
import { Router, Routes, Route } from "@jac-client/utils";
import "./global.css";
function app() {
  let meta = document.createElement("meta");
  meta.name = "viewport";
  meta.content = "width=device-width, initial-scale=1.0";
  document.getElementsByTagName("head")[0].appendChild(meta);
  let preconnect1 = document.createElement("link");
  preconnect1.rel = "preconnect";
  preconnect1.href = "https://fonts.googleapis.com";
  document.head.appendChild(preconnect1);
  let preconnect2 = document.createElement("link");
  preconnect2.rel = "preconnect";
  preconnect2.href = "https://fonts.gstatic.com";
  preconnect2.crossOrigin = "anonymous";
  document.head.appendChild(preconnect2);
  let fontLink = document.createElement("link");
  fontLink.href = "https://fonts.googleapis.com/css2?family=Zalando+Sans+SemiExpanded:ital,wght@0,200..900;1,200..900&display=swap";
  fontLink.rel = "stylesheet";
  document.head.appendChild(fontLink);
  return __jacJsx(Router, {}, [__jacJsx("div", {}, [__jacJsx(Routes, {}, [__jacJsx(Route, {"path": "/", "element": __jacJsx(Website, {}, [])}, []), __jacJsx(Route, {"path": "/auth", "element": __jacJsx(Auth, {}, [])}, []), __jacJsx(Route, {"path": "/onboarding", "element": __jacJsx(Onboarding, {}, [])}, []), __jacJsx(Route, {"path": "/dashboard", "element": __jacJsx(Dashboard, {}, [])}, [])])])]);
}
export { app };
