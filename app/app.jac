cl {

    def Website() -> any {
        return <div>
            <h1>Hello World</h1>
        </div>;
    }

    def Auth() -> any {
        return <div>
        </div>;
    }

    def Onboarding() -> any {
         return <div>
        </div>;
    }

    def Dashboard() -> any {
         return <div>
        </div>;
    }

    def app() -> any {

        # Styling
        document.body.style.margin = '0';
        document.body.style.padding = '0';
        document.body.style.backgroundColor = 'black';

        # 1. Preconnect to Google Fonts
        preconnect1 = document.createElement('link');
        preconnect1.rel = 'preconnect';
        preconnect1.href = 'https://fonts.googleapis.com';
        document.head.appendChild(preconnect1);

        # 2. Preconnect to fonts static content (with crossorigin)
        preconnect2 = document.createElement('link');
        preconnect2.rel = 'preconnect';
        preconnect2.href = 'https://fonts.gstatic.com';
        preconnect2.crossOrigin = 'anonymous';
        document.head.appendChild(preconnect2);

        # 3. Load the actual font
        fontLink = document.createElement('link');
        fontLink.href = 'https://fonts.googleapis.com/css2?family=Zalando+Sans+SemiExpanded:ital,wght@0,200..900;1,200..900&display=swap';
        fontLink.rel = 'stylesheet';
        document.head.appendChild(fontLink);


        return <Website />;
    }


}