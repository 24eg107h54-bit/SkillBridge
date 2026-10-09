# SkillBridge – AI-Powered Skill & Internship Matching Platform

> A full-stack, enterprise-grade talent discovery and career acceleration platform featuring **Spring Boot 3 (Java 21)** on the backend and **React (JavaScript) + Vite + Tailwind CSS** on the frontend.

---

## 🌟 Overview

**SkillBridge** solves the fundamental gap between engineering students and high-growth tech companies. Traditional job boards operate on rudimentary keyword matching, resulting in high rejection rates and opaque hiring cycles. SkillBridge introduces:

1. **AI Semantic Compatibility Engine**: Calculates multidimensional match percentages between student technical profiles and internship requirements (accounting for mandatory requirements, proficiency depths, and resume project keywords).
2. **AI Skill Gap Analyzer**: Highlights missing competencies categorized by priority (Mandatory vs Nice-to-have).
3. **Personalized 3-Week Accelerated Roadmaps**: Automatically curates phase-by-phase learning plans with curated open-source resources to close identified gaps.
4. **AI Technical Mock Interview Preparation**: Generates tailored interview questions targeting role architecture, detailing why recruiters ask them and key concepts to mention.
5. **Recruiter Applicant Tracking System (ATS)**: Automatically indexes incoming candidates by AI Match Score, enabling recruiters to review resumes, update statuses, and leave structured feedback.

---

## 🏗️ Architecture & Tech Stack

```
                          ┌─────────────────────────────────────┐
                          │         React Frontend (Vite)       │
                          │   Tailwind CSS / Lucide / Axios     │
                          └──────────────────┬──────────────────┘
                                             │ HTTP / REST / JWT
                                             ▼
                          ┌─────────────────────────────────────┐
                          │      Spring Boot 3.3.4 (Java 21)    │
                          │  Spring Security 6 (Stateless JWT)  │
                          ├──────────────────┬──────────────────┤
                          │ AI Matching      │ REST Controllers │
                          │ Service          │ & Services Layer │
                          ├──────────────────┴──────────────────┤
                          │    Spring Data JPA & Hibernate      │
                          └──────────────────┬──────────────────┘
                                             │
                                             ▼
                          ┌─────────────────────────────────────┐
                          │   In-Memory / File H2 Database      │
                          │  (Zero External Setup Required!)    │
                          └─────────────────────────────────────┘
```

### Backend (Spring Boot & Java 21)
- **Framework**: Spring Boot 3.3.4
- **Language**: Java 21 LTS
- **Security**: Spring Security 6 with stateless **JSON Web Tokens (JWT)** and BCrypt password encryption
- **Data Persistence**: Spring Data JPA with Hibernate ORM
- **Database**: H2 Database (with H2 Web Console at `/h2-console`)
- **Build Tool**: Apache Maven 3.9+
- **Key Modules**:
  - `SkillMatchingService`: Algorithmic skill vectoring, fuzzy alias mapping, proficiency level multipliers, and semantic resume analysis.
  - `AuthService`: Role-based access control (`ROLE_STUDENT`, `ROLE_EMPLOYER`).
  - `InternshipService`: Multi-criteria search, dynamic student compatibility scoring.
  - `ApplicationService`: Applicant pipeline tracking with candidate status workflow (`APPLIED`, `UNDER_REVIEW`, `SHORTLISTED`, `INTERVIEW_SCHEDULED`, `OFFERED`, `REJECTED`).
  - `DataSeeder`: Automatically populates realistic mock students, recruiters, internships, skills, and applications upon application launch.

### Frontend (JavaScript, React & Tailwind CSS)
- **Framework**: React 18 with Vite
- **Styling**: Tailwind CSS with custom dark mode palette and glassmorphism
- **Icons**: Lucide React
- **HTTP Client**: Axios with Bearer token request interceptor
- **Animations & Effects**: Canvas Confetti for celebratory application submissions
- **Pages**:
  - `HomePage`: Dynamic hero, platform metrics, featured internships, and 3-step AI workflow showcase.
  - `ExplorePage`: Search, multi-category filters, work mode toggles, stipend range slider, and AI match threshold.
  - `InternshipDetailPage`: In-depth job specifications, perks, required tech stack, and AI fit evaluation gauge.
  - `AiSkillAdvisorPage`: Interactive AI sandbox to test custom roles or real postings, generating 3-week study roadmaps and interview questions.
  - `StudentDashboard`: Application tracking, status indicators, and interactive Skill Inventory manager.
  - `RecruiterDashboard`: ATS candidate pool ranked by AI Match Score, status update pipeline, and new internship publisher.
  - `LoginPage` & `RegisterPage`: Dual role onboarding with instant one-click demo login buttons.

---

## ⚡ Quick Start & Running the Project

### Prerequisites
- **Java 21** or later (`java -version`)
- **Maven 3.8+** (`mvn -version`)
- **Node.js 18+** & **npm** (`node -v`, `npm -v`)

---

### Option A: One-Click Windows Launch (Recommended)
Double-click `start-all.bat` in the project root directory, or run from PowerShell:
```powershell
.\start-all.bat
```
This automatically launches both the backend and frontend in separate command windows.

---

### Option B: Manual Step-by-Step

#### 1. Start the Spring Boot Backend
Open a terminal in the `backend/` folder:
```powershell
cd backend
mvn spring-boot:run
```
- Backend starts at: **`http://localhost:8080`**
- H2 Console: **`http://localhost:8080/h2-console`**
  - JDBC URL: `jdbc:h2:mem:skillbridgedb`
  - Username: `sa`
  - Password: *(leave blank)*

#### 2. Start the React Frontend
Open another terminal in the `frontend/` folder:
```powershell
cd frontend
npm run dev
```
- Frontend starts at: **`http://localhost:5173`**

---

## 🔑 Pre-Seeded Demo Accounts (One-Click Testing)

The application automatically seeds realistic data on first startup. You can test both roles using the **"Demo Logins"** button in the navigation bar or using the credentials below:

| Role | Email | Password | Details |
| :--- | :--- | :--- | :--- |
| **Student** | `alex.student@skillbridge.io` | `password123` | CS Student at UC Berkeley (Skills: React, Java, Spring Boot, Docker, SQL) |
| **Student** | `priya.student@skillbridge.io` | `password123` | AI Researcher at CMU (Skills: Python, PyTorch, Machine Learning, NLP) |
| **Recruiter** | `recruiter@skillbridge.io` | `password123` | Nexus Technologies (Enterprise Cloud & AI Solutions) |
| **Recruiter** | `sarah.recruiter@skillbridge.io` | `password123` | CloudScale AI Labs (Applied Artificial Intelligence & LLMs) |

---

## 📡 REST API Reference

### Authentication (`/api/auth`)
- `POST /api/auth/register` - Register a new student or employer
- `POST /api/auth/login` - Authenticate and receive JWT Bearer token
- `POST /api/auth/demo-login/{type}` - Quick demo login (`student` or `recruiter`)
- `GET /api/auth/me` - Inspect current authenticated user details

### Internships (`/api/internships`)
- `GET /api/internships` - Query active internships (filters: `search`, `category`, `workMode`). Dynamically calculates candidate match score for authenticated students.
- `GET /api/internships/{id}` - Fetch internship details and required skill matrix
- `GET /api/internships/my-postings` - Fetch postings created by current recruiter *(ROLE_EMPLOYER)*
- `POST /api/internships` - Publish a new internship *(ROLE_EMPLOYER)*
- `PUT /api/internships/{id}` - Update existing posting *(ROLE_EMPLOYER)*
- `DELETE /api/internships/{id}` - Remove an internship posting *(ROLE_EMPLOYER)*

### AI Skill Matching & Gap Engine (`/api/ai`)
- `GET /api/ai/analyze-internship/{internshipId}` - Computes AI match percentage, matched skills, missing skills, 3-week learning roadmap, and tailored interview prep questions.
- `POST /api/ai/analyze-gap/public` - Public playground endpoint accepting custom user skills and job requirements.

### Applications (`/api/applications`)
- `POST /api/applications` - Student submits application with cover letter *(ROLE_STUDENT)*
- `GET /api/applications/student` - List student's submitted applications with live status *(ROLE_STUDENT)*
- `GET /api/applications/recruiter` - List applicants ranked by AI Match Score *(ROLE_EMPLOYER)*
- `PATCH /api/applications/{id}/status` - Recruiter updates applicant status and leaves feedback notes *(ROLE_EMPLOYER)*

### Profiles & Analytics (`/api/profile` & `/api/analytics`)
- `GET /api/profile/student` & `PUT /api/profile/student` - Manage skills inventory and resume text
- `GET /api/profile/recruiter` & `PUT /api/profile/recruiter` - Manage company profile
- `GET /api/analytics/dashboard` - Metric KPIs for student or recruiter dashboards

---

## 🧠 How the AI Matching Engine Works

The matching algorithm (`SkillMatchingService.java`) computes a composite score ($0\% - 100\%$):

1. **Skill Vector Intersection**: Normalizes skill synonyms (e.g. `"reactjs"` $\to$ `"react"`, `"springboot"` $\to$ `"spring boot"`, `"k8s"` $\to$ `"kubernetes"`).
2. **Proficiency Depth Factor**:
   - Equal or exceeds required seniority: **$100\%$ point weight**
   - 1 level below (e.g., Intermediate vs Advanced): **$70\%$ point weight**
   - 2+ levels below: **$40\%$ point weight**
3. **Requirement Weighting**: Mandatory skills marked by employers carry double ($2\times$) weight.
4. **Contextual Resume TF-IDF Analysis**: Scans candidate project narrative and headline for domain concepts (e.g., CI/CD, microservices, distributed systems, REST APIs) providing up to a **$+15\%$ relevance boost**.
5. **Dynamic Remediation**: Identifies exact skill deficiencies and structures a 3-week study roadmap with free high-yield resources.
