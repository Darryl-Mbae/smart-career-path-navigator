import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { Website } from "./pages/Website.js";
import { Auth } from "./pages/Auth.js";
import { Dashboard } from "./pages/Dashboard.js";
import { Onboarding } from "./pages/Onboarding.js";
import { Router, Routes, Route } from "@jac-client/utils";
import "./global.css";
function app() {
  return __jacJsx(Router, {}, [__jacJsx("div", {}, [__jacJsx(Routes, {}, [__jacJsx(Route, {"path": "/", "element": __jacJsx(Website, {}, [])}, []), __jacJsx(Route, {"path": "/auth", "element": __jacJsx(Auth, {}, [])}, []), __jacJsx(Route, {"path": "/onboarding", "element": __jacJsx(Onboarding, {}, [])}, []), __jacJsx(Route, {"path": "/dashboard", "element": __jacJsx(Dashboard, {}, [])}, [])])])]);
}
export { app };
