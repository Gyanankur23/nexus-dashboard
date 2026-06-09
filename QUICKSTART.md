# Quick Start Guide

Get Nexus Dashboard up and running in 5 minutes.

## Prerequisites

- Node.js 18+ and npm
- (Optional) Dart SDK 3.0+ for backend

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/Gyanankur23/nexus-dashboard.git
cd nexus-dashboard
```

### 2. Start the Frontend (Recommended)

The dashboard now works with mock data, so you don't need the backend!

```bash
cd frontend
npm install
npm run dev
```

The frontend will start on `http://localhost:3000` (or 3001 if 3000 is in use)

### 3. Login

Open your browser and navigate to the URL shown in the terminal

Use these demo credentials:
- **Email**: admin@nexus.com
- **Password**: admin123

### 4. (Optional) Start the Backend

If you have Dart installed and want to use the full backend:

```bash
cd backend
dart pub get
dart run bin/server.dart
```

The backend will start on `http://localhost:8080`

Then update `frontend/.env` to use the backend:
```
VITE_API_BASE=http://localhost:8080
```

## What's Next?

- Explore the dashboard features
- Check out the [Analytics](http://localhost:3000/analytics) page
- View the [Activity Feed](http://localhost:3000/activity)
- Try the [CSV Export](http://localhost:3000/users) feature
- Check out the [API Documentation](API.md)
- Read the [Architecture Overview](ARCHITECTURE.md)
- Learn how to [Deploy to Vercel](DEPLOYMENT.md)

## Features to Try

### Dashboard
- View real-time statistics
- Check project progress
- Monitor task distribution

### Projects
- Filter by status and priority
- Search projects
- Export to CSV

### Users
- Sort by any column
- Filter by role and status
- Export user data

### Tasks
- Kanban board view
- Filter by status
- Track task priorities

### Analytics
- Performance trends
- Team productivity metrics
- Project health scores

### Activity
- View system activity log
- Filter by activity type
- Search activities

## Troubleshooting

### Frontend won't start

Make sure Node.js is installed:
```bash
node --version
npm --version
```

### Port already in use

If port 3000 is in use, Vite will automatically try 3001, 3002, etc.

### Can't login

Ensure you're using the correct credentials:
- Email: admin@nexus.com
- Password: admin123

### Features not working

The dashboard uses mock data by default. All features should work without the backend.

## Need Help?

- Open an issue on GitHub
- Check the documentation
- Review the code comments
