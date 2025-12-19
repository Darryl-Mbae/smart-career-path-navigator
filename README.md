## Arise - AI-Powered Career Mapping Platform

Arise is an intelligent career development platform built with Jac/Jaseci that analyzes your skills, identifies career opportunities, and creates personalized learning roadmaps to help you achieve your professional goals.

## 🚀 Features

*   **CV Analysis**: Upload your resume and let AI extract your skills, certifications, and experience
*   **Skill Gap Analysis**: Compare your current skills against target roles to identify learning opportunities
*   **Career Role Suggestions**: Get AI-powered recommendations for roles that match your profile
*   **Personalized Learning Paths**: Receive custom roadmaps with resources to bridge skill gaps
*   **Interactive Dashboard**: Track your progress and manage your career development journey

## 🏗️ Project Structure

```plaintext
├── app/                          # Main Jac application directory
│   ├── pages/                    # UI pages (Jac client components)
│   │   ├── Website.jac          # Landing page
│   │   ├── Auth.jac             # Authentication (login/signup)
│   │   ├── Onboarding.jac       # User onboarding flow
│   │   └── Dashboard.jac        # Main dashboard
│   ├── backend/                  # Backend logic modules
│   │   ├── models/              # Data models (Skills, Roles, etc.)
│   │   ├── relationships/       # Graph relationships
│   │   ├── tools/               # Utility functions
│   │   └── helpers/             # Helper functions
│   ├── app.jac                  # Main application entry point
│   ├── app.impl.jac            # Walker implementations
│   ├── package.json            # Node.js dependencies for client
│   ├── requirements.txt        # Python dependencies
│   └── .env                    # Environment variables
└── README.md                   # This file
```

## 🛠️ Technology Stack

*   **Framework**: Jac/Jaseci (Full-stack graph-native framework)
*   **AI/ML**: Mistral AI via BYLLM
*   **APIs**: Firecrawl (web scraping), Serper (search)
*   **File Processing**: PyPDF2, python-docx
*   **Client**: React-like Jac client components

## ⚙️ Setup Instructions

### Prerequisites

*   Python 3.8+
*   Jaseci framework

### 1\. Clone the Repository

```plaintext
git clone <repository-url>
```

### 2\. Create Jac Environment

```plaintext
# Create a new Jac environment
python -m venv jacenv

# Activate the environment
# On Linux/Mac:
source jacenv/bin/activate
# On Windows:
# jacenv\Scripts\activate
```

### 3\. Install Jaseci

```plaintext
# Install Jaseci and Jac
pip install jaseci
```

### 4\. Install Dependencies

```plaintext
cd app

# Install Python dependencies
pip install -r requirements.txt

# Install Node.js dependencies for client components
npm install
```

### 5\. Configure Environment Variables

Create a `.env` file in the `app/` directory with the following API keys:

```plaintext
# Required API Keys
MISTRAL_API_KEY=your_mistral_api_key_here
SERPER_API_KEY=your_serper_search_api_key_here  
FIRECRAWL_API_KEY=your_firecrawl_api_key_here
```

**Where to get API keys:**

*   **Mistral AI**: Sign up at [mistral.ai](https://mistral.ai) for AI model access
*   **Serper**: Get your key at [serper.dev](https://serper.dev) for web search functionality
*   **Firecrawl**: Register at [firecrawl.dev](https://firecrawl.dev) for web scraping capabilities

### 6\. Start the Application

```plaintext
# Start the Jac application
jac serve app.jac
```

The application will be available at `http://localhost:8000`

## 📋 User Workflow

### 1\. **Registration & Authentication**

*   Visit the landing page at `/`
*   Click "Get Started" to access the authentication page
*   Sign up with email and password or log in to existing account

### 2\. **Onboarding Process** (4 Steps)

#### Step 1: Upload CV

*   Upload your resume (PDF, DOC, DOCX formats supported)
*   AI analyzes and extracts your skills, experience, and certifications

#### Step 2: Review & Update Skills

*   Review AI-detected skills from your CV
*   Add any missing skills manually
*   Remove irrelevant skills

#### Step 3: Set Career Goals

*   View AI-suggested roles based on your profile
*   Select target roles you're interested in
*   Add custom roles if needed

#### Step 4: Get Your Roadmap

*   System generates personalized learning paths
*   Skill gap analysis completed
*   Ready to access dashboard

### 3\. **Dashboard Features**

#### Main Dashboard

*   Overview of your profile and progress
*   Quick access to all features
*   Notifications and updates

#### Skills Management

*   View and edit your skill profile
*   Add new skills as you learn
*   Track skill development over time

#### Roles & Career Goals

*   Manage target roles
*   View role requirements
*   Track progress toward career goals

#### Learning Roadmap

*   Access personalized learning paths
*   View recommended resources and courses
*   Track completion of learning milestones

#### Certifications

*   Manage your certifications
*   View recommended certifications for target roles
*   Track certification progress

## 🔧 Development Commands

```plaintext
# Start the Jac application
jac serve app.jac

# Build client components (if needed)
npm run build

# Install new Python dependencies
pip install <package_name>

# Install new client dependencies  
npm install <package_name>
```

## 🎯 Key Features Explained

### AI-Powered CV Analysis

The system uses Mistral AI to extract:

*   Technical and soft skills from resume text
*   Work experience and roles
*   Certifications and education
*   Career interests and goals

### Skill Gap Analysis

*   Compares your current skills with target role requirements
*   Identifies missing skills and certifications using graph traversal
*   Prioritizes learning based on career goals

### Dynamic Learning Paths

*   Generates custom roadmaps for each target role
*   Uses web scraping to find current learning resources
*   Updates based on real-time job market data

### Real-time Job Market Data

*   Fetches current job requirements using Serper API
*   Analyzes trending skills in your target roles
*   Provides market-relevant recommendations via Firecrawl

## 🔐 API Keys Required

The application requires the following API keys in your `.env` file:

```plaintext
# Mistral AI - for CV analysis and role suggestions
MISTRAL_API_KEY=your_mistral_api_key_here

# Serper - for job market search functionality  
SERPER_API_KEY=your_serper_search_api_key_here

# Firecrawl - for web scraping learning resources
FIRECRAWL_API_KEY=your_firecrawl_api_key_here
```

## 📁 Data Storage

*   User profiles and skills are stored in Jaseci's native graph database
*   CVs are saved locally in the `app/resumes/` directory
*   Learning paths are generated as markdown files
*   All data relationships are managed through Jac's graph architecture

## 🚀 Deployment

1.  Set up Jac environment: `python -m venv jacenv &amp;&amp; source jacenv/bin/activate`
2.  Install Jaseci: `pip install jaseci jac-lang`
3.  Install dependencies: `pip install -r requirements.txt &amp;&amp; npm install`
4.  Configure environment variables in `.env`
5.  Start the application: `jac serve app.jac`

## 🤝 Contributing

1.  Fork the repository
2.  Create a feature branch
3.  Make your changes
4.  Test thoroughly
5.  Submit a pull request

## 📄 License

This project is licensed under the ISC License.

## 🔍 Application Architecture

### Jac Walkers (Backend Logic)

*   **User Management**: `initialize_memory`, `create_resume_node`, `upload_resume`
*   **CV Analysis**: `analyze_cv`, `extract_user_skills_from_cv`
*   **Profile Management**: `get_user_profile`, `update_user_profile`
*   **Role Analysis**: `generate_role_suggestions`, `collect_role_requirements`
*   **Skill Gap Analysis**: `find_skill_and_certification_gaps`, `retrieve_skill_gaps`
*   **Learning Paths**: `recommend_learning_paths`, `get_road_map`

### Jac Client Components

*   **Website.jac**: Landing page with hero section and navigation
*   **Auth.jac**: User authentication (login/signup) with form validation
*   **Onboarding.jac**: 4-step user onboarding flow
*   **Dashboard.jac**: Main application interface with sidebar navigation

### Graph Data Models

*   **Memory**: User session and profile data
*   **Resume**: CV storage and metadata
*   **Skill**: Individual skills with descriptions
*   **Role**: Career roles with requirements
*   **Certification**: Professional certifications
*   **Interest**: User interests and preferences
*   **RequirementsGap**: Skill gaps for target roles
*   **LearningPath**: Personalized learning roadmaps

## 🆘 Support

For issues and questions:

1.  Check the Jac documentation at [jac-lang.org](https://jac-lang.org)
2.  Review the walker implementations in `app.impl.jac`
3.  Examine the graph models in `backend/models/`
4.  Create an issue in the repository

## 📚 Additional Resources

*   [Jaseci Documentation](https://jaseci.org)
*   [Jac Language Guide](https://jac-lang.org)
*   [Graph-Native Programming Concepts](https://jaseci.org/docs)

**Happy Career Mapping with Arise! 🚀**
