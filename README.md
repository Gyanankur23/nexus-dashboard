# Nexus Dashboard

<div align="center">

![Nexus Dashboard](https://img.shields.io/badge/Nexus-Dashboard-6366f1?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJ3aGl0ZSIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiPjxyZWN0IHg9IjMiIHk9IjMiIHdpZHRoPSI3IiBoZWlnaHQ9IjciLz48cmVjdCB4PSIxNCIgeT0iMyIgd2lkdGg9IjciIGhlaWdodD0iNyIvPHJlY3QgeD0iMTQiIHk9IjE0IiB3aWR0aD0iNyIgaGVpZ2h0PSI3Ii8+PHJlY3QgeD0iMyIgeT0iMTQiIHdpZHRoPSI3IiBoZWlnaHQ9IjciLz48L3N2Zz4=)

**A Premium Admin & Project Management Dashboard**

[![Vue.js](https://img.shields.io/badge/Vue.js-35495E?style=flat-square&logo=vue.js&logoColor=4FC08D)](https://vuejs.org/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind-06B6D4?style=flat-square&logo=tailwind-css&logoColor=white)](https://tailwindcss.com/)
[![Vite](https://img.shields.io/badge/Vite-646CFF?style=flat-square&logo=vite&logoColor=white)](https://vitejs.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-brightgreen.svg?style=flat-square)](https://github.com/Gyanankur23/nexus-dashboard)
[![Version](https://img.shields.io/badge/Version-1.0.0-blue.svg?style=flat-square)](https://github.com/Gyanankur23/nexus-dashboard/releases)
[![PRs Welcome](https://img.shields.io/badge/PRs-Welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Code Style](https://img.shields.io/badge/Code%20Style-Standard-brightgreen.svg?style=flat-square)](https://standardjs.com)
[![Deployment](https://img.shields.io/badge/Deploy-Vercel-black?style=flat-square&logo=vercel)](https://vercel.com)
[![Contributors](https://img.shields.io/badge/Contributors-Welcome-orange.svg?style=flat-square)](CONTRIBUTING.md)
[![Documentation](https://img.shields.io/badge/Docs-Latest-blue.svg?style=flat-square)](ARCHITECTURE.md)

[Live Demo]([https://nexus-dashboard.vercel.app](https://nexus-dashboard-hazel-kappa.vercel.app)) • [Documentation](#documentation) • [Report Bug](https://github.com/Gyanankur23/nexus-dashboard/issues) • [Request Feature](https://github.com/Gyanankur23/nexus-dashboard/issues)

</div>

---

## 🚀 Overview

Nexus Dashboard is a premium, full-stack admin and project management dashboard built with modern technologies. It features a dark high-contrast UI, smooth animations, and comprehensive project management capabilities including Kanban boards, user management, and real-time statistics.

## ✨ Features

### Admin Panel
- **User Management**: View, add, edit, and remove team members
- **Role-based Access Control**: Admin, Developer, Designer, Manager roles
- **User Statistics**: Track active users, join dates, and activity
- **Profile Settings**: Customizable user profiles and preferences
- **Advanced Filtering**: Filter users by role, status, and search functionality
- **Data Sorting**: Sortable table columns with ascending/descending order
- **Export Capabilities**: Export user data to CSV format

### Project Management
- **Project Dashboard**: Overview of all projects with progress tracking
- **Kanban Board**: Drag-and-drop task management (To Do, In Progress, Done)
- **Task Management**: Create, assign, and track tasks with priorities
- **Progress Tracking**: Visual progress bars for projects and tasks
- **Team Collaboration**: Assign team members to projects and tasks
- **Project Filtering**: Filter by status, priority, and search
- **Export Functionality**: Export project data to CSV

### Analytics & Insights
- **Real-time Statistics**: Live dashboard metrics
- **Productivity Tracking**: Monitor team productivity scores
- **Task Distribution**: Visual breakdown of task statuses
- **Project Health**: Track project deadlines and completion rates
- **Performance Trends**: Compare metrics across time periods
- **Team Performance**: Individual team member efficiency tracking
- **Achievement System**: Track team accomplishments and milestones
- **Comprehensive Charts**: Visual data representation with progress bars and metrics

### Activity & Audit
- **Activity Feed**: Real-time activity tracking across the system
- **Audit Log**: Complete history of user actions and system events
- **Searchable History**: Filter activities by type and search
- **Timestamp Tracking**: Precise timing of all activities

### Enterprise Features
- **Notification System**: Real-time alerts and notifications
- **Error Boundaries**: Comprehensive error handling and recovery
- **Loading States**: Smooth loading indicators for better UX
- **Data Export**: CSV export for users, projects, and tasks
- **Search Functionality**: Global search across all data
- **Responsive Design**: Optimized for desktop, tablet, and mobile

### Security
- **JWT Authentication**: Secure token-based authentication
- **Password Hashing**: SHA-256 encryption for passwords
- **Protected Routes**: Route guards for authenticated pages
- **CORS Enabled**: Secure cross-origin resource sharing

## 🛠️ Tech Stack

### Frontend
- **Vue.js 3**: Progressive JavaScript framework
- **Vue Router**: Client-side routing
- **Pinia**: State management
- **Tailwind CSS**: Utility-first CSS framework
- **Vite**: Build tool and dev server
- **Lucide Icons**: Beautiful icon library
- **Axios**: HTTP client

### Backend
- **Dart**: Backend programming language
- **Shelf**: HTTP server framework
- **JWT**: Token-based authentication
- **Crypto**: Cryptographic operations

## 📦 Installation

### Prerequisites
- Node.js 18+ and npm
- Dart SDK 3.0+

### Backend Setup

```bash
cd backend
dart pub get
dart run bin/server.dart
```

The backend will run on `http://localhost:8080`

### Frontend Setup

```bash
cd frontend
npm install
npm run dev
```

The frontend will run on `http://localhost:3000`

## 🔐 Demo Credentials

```
Email: admin@nexus.com
Password: admin123
```

## 📁 Project Structure

```
nexus-dashboard/
├── backend/
│   ├── bin/
│   │   └── server.dart          # Main server file
│   └── pubspec.yaml             # Dart dependencies
├── frontend/
│   ├── src/
│   │   ├── components/         # Reusable Vue components
│   │   │   ├── Layout.vue      # Main layout with sidebar
│   │   │   ├── NotificationSystem.vue  # Global notifications
│   │   │   ├── LoadingSpinner.vue      # Loading indicator
│   │   │   ├── ErrorBoundary.vue       # Error handling
│   │   │   └── SearchBar.vue          # Search component
│   │   ├── views/              # Page views
│   │   │   ├── Login.vue       # Authentication page
│   │   │   ├── Dashboard.vue   # Main dashboard
│   │   │   ├── Projects.vue    # Project management
│   │   │   ├── Tasks.vue       # Kanban board
│   │   │   ├── Users.vue       # User management
│   │   │   ├── Activity.vue    # Activity feed
│   │   │   ├── Analytics.vue   # Analytics dashboard
│   │   │   └── Settings.vue    # User settings
│   │   ├── stores/             # Pinia stores
│   │   │   ├── auth.js         # Authentication state
│   │   │   └── data.js         # Application data state
│   │   ├── router/             # Vue Router config
│   │   │   └── index.js        # Route definitions
│   │   ├── App.vue             # Root component
│   │   ├── main.js             # Entry point
│   │   └── style.css           # Global styles
│   ├── index.html
│   ├── package.json
│   ├── vite.config.js
│   └── tailwind.config.js
├── README.md
├── ARCHITECTURE.md
├── API.md
├── DEPLOYMENT.md
├── QUICKSTART.md
├── CHANGELOG.md
└── CONTRIBUTING.md
```

## 🎨 Design System

### Color Palette
- **Primary**: `#0a0a0a` (Darkest background)
- **Secondary**: `#111111` (Cards and panels)
- **Tertiary**: `#1a1a1a` (Inputs and hover states)
- **Border**: `#2a2a2a` (Borders and dividers)
- **Accent Primary**: `#6366f1` (Primary actions)
- **Accent Secondary**: `#8b5cf6` (Secondary actions)
- **Success**: `#10b981` (Success states)
- **Warning**: `#f59e0b` (Warning states)
- **Danger**: `#ef4444` (Error states)

### Typography
- **Font Family**: Inter
- **Weights**: 300, 400, 500, 600, 700, 800

## 📊 API Endpoints

### Authentication
- `POST /auth/login` - User login
- `GET /` - Health check

### Users
- `GET /users` - Get all users
- `GET /users/:id` - Get user by ID

### Projects
- `GET /projects` - Get all projects
- `GET /projects/:id` - Get project by ID

### Tasks
- `GET /tasks` - Get all tasks
- `GET /tasks/project/:projectId` - Get tasks by project

### Dashboard
- `GET /dashboard` - Get dashboard data
- `GET /stats` - Get statistics

## 🎯 Enterprise-Ready Features

This dashboard is designed for enterprise use with the following production-ready capabilities:

### Data Management
- **Advanced Filtering**: Multi-level filtering on all data views
- **Sorting**: Sortable columns with ascending/descending order
- **Search**: Real-time search across all data entities
- **Export**: CSV export for reporting and analysis
- **Pagination**: Efficient data loading for large datasets

### User Experience
- **Error Handling**: Comprehensive error boundaries with graceful degradation
- **Loading States**: Smooth loading indicators for all async operations
- **Notifications**: Real-time feedback for user actions
- **Responsive Design**: Optimized for all screen sizes
- **Accessibility**: WCAG compliant color contrast and navigation

### Security
- **Authentication**: JWT-based secure authentication
- **Authorization**: Role-based access control
- **Data Protection**: Client-side data validation
- **Secure Storage**: Safe localStorage handling

### Performance
- **Optimized Rendering**: Vue 3 Composition API for efficient reactivity
- **Code Splitting**: Lazy-loaded routes for faster initial load
- **State Management**: Pinia for efficient state handling
- **Mock Data**: Instant loading without backend dependency

## 🚀 Deployment

### Vercel Deployment (Free)

1. Fork this repository
2. Connect your GitHub account to Vercel
3. Import the repository
4. Configure build settings:
   - **Framework Preset**: Vite
   - **Root Directory**: `frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
5. Deploy!

For detailed deployment instructions, see [DEPLOYMENT.md](DEPLOYMENT.md)

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## 🎓 Interview Talking Points

When presenting this project in an interview, highlight:

### Architecture
- **Full-Stack Design**: Separation of frontend (Vue.js) and backend (Dart)
- **State Management**: Pinia for centralized state management
- **Component Architecture**: Reusable components with proper separation of concerns
- **Routing**: Protected routes with authentication guards

### Enterprise Features
- **Data Management**: Advanced filtering, sorting, and search capabilities
- **Export Functionality**: CSV export for reporting and data analysis
- **Activity Tracking**: Comprehensive audit log for compliance
- **Analytics Dashboard**: Real-time metrics and performance tracking

### Best Practices
- **Error Handling**: Error boundaries for graceful error recovery
- **Loading States**: Smooth UX with proper loading indicators
- **Type Safety**: Consistent data structures and validation
- **Code Organization**: Clean file structure and modular design

### Performance
- **Optimized Rendering**: Vue 3 Composition API for efficiency
- **Lazy Loading**: Route-level code splitting
- **Mock Data Strategy**: Instant loading without backend dependency
- **Responsive Design**: Mobile-first approach with Tailwind CSS

### Security
- **JWT Authentication**: Secure token-based auth
- **Route Guards**: Protected routes with proper authorization
- **Input Validation**: Client-side data validation
- **Secure Storage**: Safe localStorage handling

## 📝 Documentation

- [Quick Start Guide](QUICKSTART.md) - Get started in 5 minutes
- [Architecture Overview](ARCHITECTURE.md) - System architecture and design
- [API Documentation](API.md) - Complete API reference
- [Deployment Guide](DEPLOYMENT.md) - Vercel deployment instructions
- [Contributing Guidelines](CONTRIBUTING.md) - How to contribute
- [Changelog](CHANGELOG.md) - Version history and changes

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Gyanankur Baruah** - *Initial work* - [Gyanankur23](https://github.com/Gyanankur23)

## 🙏 Acknowledgments

- Vue.js team for the amazing framework
- Dart team for the excellent language
- Tailwind CSS for the utility-first approach
- Lucide for the beautiful icons

---

<div align="center">

**Built with ❤️ using Vue.js and Dart**

[⬆ Back to Top](#nexus-dashboard)

</div>
