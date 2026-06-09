# API Documentation

## Base URL

```
Development: http://localhost:8080
Production: https://nexus-dashboard.vercel.app/api
```

## Authentication

All protected endpoints require a valid JWT token in the Authorization header:

```
Authorization: Bearer <token>
```

## Endpoints

### Health Check

#### GET /

Check if the API is running.

**Response**
```json
{
  "status": "healthy",
  "service": "Nexus Dashboard API"
}
```

---

### Authentication

#### POST /auth/login

Authenticate a user and receive a JWT token.

**Request Body**
```json
{
  "email": "admin@nexus.com",
  "password": "admin123"
}
```

**Success Response (200)**
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "name": "Admin User",
    "email": "admin@nexus.com",
    "role": "admin",
    "avatar": "👨‍💼"
  }
}
```

**Error Response (401)**
```json
{
  "success": false,
  "message": "Invalid credentials"
}
```

---

### Users

#### GET /users

Get all users (requires authentication).

**Headers**
```
Authorization: Bearer <token>
```

**Response (200)**
```json
{
  "users": [
    {
      "id": 1,
      "name": "Admin User",
      "email": "admin@nexus.com",
      "role": "admin",
      "avatar": "👨‍💼",
      "status": "active",
      "joined": "2024-01-15"
    },
    {
      "id": 2,
      "name": "John Developer",
      "email": "john@nexus.com",
      "role": "developer",
      "avatar": "👨‍💻",
      "status": "active",
      "joined": "2024-02-20"
    }
  ]
}
```

#### GET /users/:id

Get a specific user by ID (requires authentication).

**Headers**
```
Authorization: Bearer <token>
```

**Response (200)**
```json
{
  "id": 1,
  "name": "Admin User",
  "email": "admin@nexus.com",
  "role": "admin",
  "avatar": "👨‍💼",
  "status": "active",
  "joined": "2024-01-15"
}
```

**Error Response (404)**
```json
{
  "message": "User not found"
}
```

---

### Projects

#### GET /projects

Get all projects (requires authentication).

**Headers**
```
Authorization: Bearer <token>
```

**Response (200)**
```json
{
  "projects": [
    {
      "id": 1,
      "name": "Website Redesign",
      "status": "in-progress",
      "progress": 65,
      "team": [1, 2, 3],
      "deadline": "2024-07-15",
      "priority": "high"
    },
    {
      "id": 2,
      "name": "Mobile App Development",
      "status": "in-progress",
      "progress": 40,
      "team": [2, 3],
      "deadline": "2024-08-20",
      "priority": "high"
    }
  ]
}
```

#### GET /projects/:id

Get a specific project by ID (requires authentication).

**Headers**
```
Authorization: Bearer <token>
```

**Response (200)**
```json
{
  "id": 1,
  "name": "Website Redesign",
  "status": "in-progress",
  "progress": 65,
  "team": [1, 2, 3],
  "deadline": "2024-07-15",
  "priority": "high"
}
```

**Error Response (404)**
```json
{
  "message": "Project not found"
}
```

---

### Tasks

#### GET /tasks

Get all tasks (requires authentication).

**Headers**
```
Authorization: Bearer <token>
```

**Response (200)**
```json
{
  "tasks": [
    {
      "id": 1,
      "projectId": 1,
      "title": "Design homepage mockup",
      "status": "done",
      "assignee": 3,
      "priority": "high"
    },
    {
      "id": 2,
      "projectId": 1,
      "title": "Implement responsive layout",
      "status": "in-progress",
      "assignee": 2,
      "priority": "high"
    }
  ]
}
```

#### GET /tasks/project/:projectId

Get tasks for a specific project (requires authentication).

**Headers**
```
Authorization: Bearer <token>
```

**Response (200)**
```json
{
  "tasks": [
    {
      "id": 1,
      "projectId": 1,
      "title": "Design homepage mockup",
      "status": "done",
      "assignee": 3,
      "priority": "high"
    },
    {
      "id": 2,
      "projectId": 1,
      "title": "Implement responsive layout",
      "status": "in-progress",
      "assignee": 2,
      "priority": "high"
    }
  ]
}
```

---

### Statistics

#### GET /stats

Get application statistics (requires authentication).

**Headers**
```
Authorization: Bearer <token>
```

**Response (200)**
```json
{
  "totalUsers": 4,
  "activeUsers": 3,
  "totalProjects": 4,
  "completedProjects": 1,
  "totalTasks": 6,
  "completedTasks": 2,
  "productivity": 78
}
```

---

### Dashboard

#### GET /dashboard

Get comprehensive dashboard data (requires authentication).

**Headers**
```
Authorization: Bearer <token>
```

**Response (200)**
```json
{
  "stats": {
    "totalUsers": 4,
    "activeUsers": 3,
    "totalProjects": 4,
    "completedProjects": 1,
    "totalTasks": 6,
    "completedTasks": 2,
    "productivity": 78
  },
  "recentProjects": [
    {
      "id": 1,
      "name": "Website Redesign",
      "status": "in-progress",
      "progress": 65,
      "team": [1, 2, 3],
      "deadline": "2024-07-15",
      "priority": "high"
    }
  ],
  "recentTasks": [
    {
      "id": 1,
      "projectId": 1,
      "title": "Design homepage mockup",
      "status": "done",
      "assignee": 3,
      "priority": "high"
    }
  ],
  "users": [
    {
      "id": 1,
      "name": "Admin User",
      "email": "admin@nexus.com",
      "role": "admin",
      "avatar": "👨‍💼",
      "status": "active",
      "joined": "2024-01-15"
    }
  ]
}
```

---

## Error Responses

### 401 Unauthorized

```json
{
  "message": "Unauthorized"
}
```

### 404 Not Found

```json
{
  "message": "Resource not found"
}
```

### 500 Internal Server Error

```json
{
  "message": "Internal server error"
}
```

---

## Status Codes

| Code | Description |
|------|-------------|
| 200  | Success |
| 401  | Unauthorized - Invalid or missing token |
| 404  | Not Found - Resource doesn't exist |
| 500  | Internal Server Error |

---

## Rate Limiting

Currently not implemented. Future versions will include rate limiting to prevent abuse.

---

## CORS

The API supports CORS for cross-origin requests. The following headers are set:

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS
Access-Control-Allow-Headers: Content-Type, Authorization
```

---

## Testing the API

### Using cURL

```bash
# Health check
curl http://localhost:8080/

# Login
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@nexus.com","password":"admin123"}'

# Get users (with token)
curl http://localhost:8080/users \
  -H "Authorization: Bearer <your-token>"
```

### Using Postman

1. Import the API endpoints
2. Set base URL to `http://localhost:8080`
3. Use the login endpoint to get a token
4. Add the token to the Authorization header for protected routes

---

## Data Models

### User Model

| Field | Type | Description |
|-------|------|-------------|
| id | integer | Unique identifier |
| name | string | Full name |
| email | string | Email address |
| role | string | User role (admin, developer, designer, manager) |
| avatar | string | Emoji avatar |
| status | string | Account status (active, inactive) |
| joined | string | Join date (ISO format) |

### Project Model

| Field | Type | Description |
|-------|------|-------------|
| id | integer | Unique identifier |
| name | string | Project name |
| status | string | Project status (in-progress, completed, pending) |
| progress | integer | Progress percentage (0-100) |
| team | array | Array of user IDs |
| deadline | string | Deadline date (ISO format) |
| priority | string | Priority level (high, medium, low) |

### Task Model

| Field | Type | Description |
|-------|------|-------------|
| id | integer | Unique identifier |
| projectId | integer | Associated project ID |
| title | string | Task title |
| status | string | Task status (todo, in-progress, done) |
| assignee | integer | Assigned user ID |
| priority | string | Priority level (high, medium, low) |
