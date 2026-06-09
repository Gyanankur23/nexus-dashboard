# Architecture Overview

## System Architecture

Nexus Dashboard follows a modern full-stack architecture with clear separation of concerns between frontend and backend.

```
┌─────────────────────────────────────────────────────────────┐
│                         Client Layer                         │
│                    (Vue.js + Tailwind CSS)                  │
└────────────────────────┬────────────────────────────────────┘
                         │ HTTP/REST API
                         │ JWT Authentication
┌────────────────────────▼────────────────────────────────────┐
│                      Server Layer                           │
│                    (Dart + Shelf Framework)                 │
└────────────────────────┬────────────────────────────────────┘
                         │
                         │ Mock Data (In-Memory)
┌────────────────────────▼────────────────────────────────────┐
│                      Data Layer                             │
│              (JSON-based Mock Storage)                      │
└─────────────────────────────────────────────────────────────┘
```

## Frontend Architecture

### Component Structure

```
src/
├── components/
│   └── Layout.vue              # Main layout with sidebar
├── views/
│   ├── Login.vue               # Authentication page
│   ├── Dashboard.vue           # Main dashboard
│   ├── Projects.vue            # Project management
│   ├── Tasks.vue               # Kanban board
│   ├── Users.vue               # User management
│   └── Settings.vue            # User settings
├── stores/
│   ├── auth.js                 # Authentication state
│   └── data.js                 # Application data state
├── router/
│   └── index.js                # Route configuration
├── App.vue                     # Root component
├── main.js                     # Application entry point
└── style.css                   # Global styles
```

### State Management (Pinia)

**Auth Store**
- Manages user authentication state
- Handles login/logout operations
- Stores JWT token and user data
- Persists to localStorage

**Data Store**
- Manages application data (users, projects, tasks)
- Handles API calls to backend
- Provides computed properties for derived data

### Routing Strategy

- **Protected Routes**: Routes requiring authentication are guarded
- **Route Guards**: Check for valid JWT token before navigation
- **Redirect Logic**: Unauthenticated users redirected to login

## Backend Architecture

### Server Structure

```
backend/
├── bin/
│   └── server.dart             # Main server entry point
└── pubspec.yaml                # Dependencies
```

### API Design

**RESTful Endpoints**
- Standard HTTP methods (GET, POST, PUT, DELETE)
- JSON request/response format
- JWT-based authentication
- CORS enabled for cross-origin requests

### Authentication Flow

```
1. User submits credentials
   ↓
2. Server validates credentials
   ↓
3. Server generates JWT token
   ↓
4. Client stores token
   ↓
5. Client includes token in Authorization header
   ↓
6. Server verifies token on protected routes
```

### Middleware Pipeline

```
Request → CORS Middleware → Auth Middleware → Route Handler → Response
```

**CORS Middleware**
- Adds CORS headers to all responses
- Allows cross-origin requests from frontend

**Auth Middleware**
- Verifies JWT token
- Protects authenticated routes
- Returns 401 for unauthorized access

## Data Model

### User
```dart
{
  "id": int,
  "name": String,
  "email": String,
  "role": String,        // admin, developer, designer, manager
  "avatar": String,      // emoji representation
  "status": String,      // active, inactive
  "joined": String       // ISO date
}
```

### Project
```dart
{
  "id": int,
  "name": String,
  "status": String,      // in-progress, completed, pending
  "progress": int,       // 0-100
  "team": List<int>,     // user IDs
  "deadline": String,    // ISO date
  "priority": String     // high, medium, low
}
```

### Task
```dart
{
  "id": int,
  "projectId": int,
  "title": String,
  "status": String,      // todo, in-progress, done
  "assignee": int,       // user ID
  "priority": String     // high, medium, low
}
```

## Security Considerations

### Authentication
- JWT tokens with expiration
- SHA-256 password hashing
- Token verification on protected routes

### Data Protection
- No sensitive data in localStorage (except token)
- CORS configuration to prevent unauthorized access
- Input validation on server side

### Future Enhancements
- HTTPS enforcement
- Rate limiting
- SQL injection prevention (when database added)
- XSS protection

## Performance Optimizations

### Frontend
- Lazy loading of routes
- Component-based code splitting
- Efficient state management with Pinia
- Optimized reactivity with Vue 3

### Backend
- In-memory data storage for fast access
- Efficient middleware pipeline
- Minimal dependencies

## Scalability Considerations

### Current Limitations
- In-memory data storage (data lost on restart)
- Single server instance
- No database persistence

### Future Improvements
- Add database (PostgreSQL, MongoDB)
- Implement caching layer (Redis)
- Add horizontal scaling support
- Implement data persistence
- Add file storage for uploads

## Development Workflow

1. **Backend Development**
   - Start Dart server: `dart run bin/server.dart`
   - Server runs on port 8080
   - API available at `http://localhost:8080`

2. **Frontend Development**
   - Start Vite dev server: `npm run dev`
   - Frontend runs on port 3000
   - Proxy configured to backend

3. **Testing**
   - Test API endpoints with curl or Postman
   - Test frontend in browser
   - Verify authentication flow

## Technology Choices

### Why Vue.js?
- Progressive framework with gentle learning curve
- Excellent reactivity system
- Great ecosystem (Vue Router, Pinia)
- Strong community support

### Why Dart?
- Type-safe language
- Excellent performance
- Modern async/await support
- Growing ecosystem

### Why Tailwind CSS?
- Utility-first approach
- Highly customizable
- Dark mode support built-in
- Small bundle size

### Why Vite?
- Fast development server
- Optimized build process
- Hot module replacement
- Modern tooling
