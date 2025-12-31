import from .pages.Website { Website }
import from react { useEffect }
import from .pages.Auth { Auth }
import from .pages.Dashboard { Dashboard }
import from .pages.Onboarding { Onboarding }
import from "@jac-client/utils" {
    Router,
    Routes,
    Route,
}
import ".global.css";

def app() -> any {
    
    let viewport = document.createElement('meta');
    viewport.name = 'viewport';
    viewport.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
    document.head.appendChild(viewport);

    return <Router>
        <div>
            <Routes>
                <Route
                    path="/"
                    element={<Website />}
                />
                <Route
                    path="/auth"
                    element={<Auth />}
                />
                    <Route
                    path="/onboarding"
                    element={<Onboarding />}
                />
                    <Route
                    path="/dashboard"
                    element={<Dashboard />}
                />
            </Routes>
        </div>
    </Router>;
}
