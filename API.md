# API Documentation

## Base URL
```
https://api.nexustraining.example.com/v1
```

## Authentication
All endpoints (except `/auth/*`) require an `Authorization` header:
```
Authorization: Bearer <access_token>
```

---

## Endpoints

### Authentication

#### POST /auth/login
Login with email and password.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response (200):**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIs...",
  "refreshToken": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": "user_123",
    "email": "user@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "department": "Engineering",
    "jobTitle": "Senior Developer"
  }
}
```

#### POST /auth/register
Register a new user account.

**Request:**
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john@example.com",
  "password": "securePassword123",
  "department": "Engineering",
  "jobTitle": "Senior Developer"
}
```

**Response (201):**
Same as login response.

#### POST /auth/refresh
Refresh access token.

**Request:**
```json
{
  "refreshToken": "eyJhbGciOiJIUzI1NiIs..."
}
```

**Response (200):**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIs..."
}
```

---

### Courses

#### GET /courses
List all available courses with pagination.

**Query Parameters:**
- `page` (int, default=1): Page number
- `limit` (int, default=10): Items per page
- `category` (string, optional): Filter by category
- `difficulty` (string, optional): Filter by difficulty level
- `search` (string, optional): Search in title/description

**Response (200):**
```json
{
  "data": [
    {
      "id": "course_123",
      "title": "Flutter Development Fundamentals",
      "description": "Learn Flutter from scratch",
      "instructor": "Sarah Johnson",
      "category": "Mobile Development",
      "durationMinutes": 360,
      "rating": 4.8,
      "enrollmentCount": 2540,
      "skills": ["Flutter", "Dart", "Mobile Development"],
      "difficulty": "Intermediate",
      "isActive": true,
      "createdDate": "2024-01-15T10:00:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 45,
    "pages": 5
  }
}
```

#### GET /courses/:id
Get detailed information about a specific course.

**Response (200):**
```json
{
  "id": "course_123",
  "title": "Flutter Development Fundamentals",
  "description": "Complete guide to Flutter development",
  "fullDescription": "...",
  "instructor": "Sarah Johnson",
  "category": "Mobile Development",
  "durationMinutes": 360,
  "rating": 4.8,
  "enrollmentCount": 2540,
  "skills": ["Flutter", "Dart", "Mobile Development"],
  "difficulty": "Intermediate",
  "isActive": true,
  "modules": [
    {
      "id": "module_1",
      "title": "Getting Started",
      "lessons": []
    }
  ],
  "assessments": [
    {
      "id": "assessment_1",
      "title": "Final Assessment",
      "totalQuestions": 50
    }
  ]
}
```

#### POST /enrollments
Enroll a user in a course.

**Request:**
```json
{
  "userId": "user_123",
  "courseId": "course_123"
}
```

**Response (201):**
```json
{
  "id": "enrollment_123",
  "userId": "user_123",
  "courseId": "course_123",
  "enrollDate": "2024-01-30T15:30:00Z",
  "progressPercentage": 0,
  "status": "active",
  "score": 0
}
```

#### GET /enrollments/:userId
Get user's course enrollments.

**Response (200):**
```json
{
  "data": [
    {
      "id": "enrollment_123",
      "course": {
        "id": "course_123",
        "title": "Flutter Development Fundamentals"
      },
      "enrollDate": "2024-01-30T15:30:00Z",
      "completionDate": null,
      "progressPercentage": 35,
      "status": "active",
      "score": 0
    }
  ]
}
```

---

### Assessments

#### GET /assessments
Get all assessments for a course.

**Query Parameters:**
- `courseId` (string, required): Filter by course ID

**Response (200):**
```json
{
  "data": [
    {
      "id": "assessment_1",
      "courseId": "course_123",
      "title": "Module 1 Quiz",
      "description": "Test your knowledge",
      "totalQuestions": 20,
      "passingScore": 70,
      "timeMinutes": 30,
      "createdDate": "2024-01-15T10:00:00Z"
    }
  ]
}
```

#### POST /test-results
Submit assessment results.

**Request:**
```json
{
  "userId": "user_123",
  "assessmentId": "assessment_1",
  "userAnswers": ["A", "B", "C"],
  "timeSpentSeconds": 1200
}
```

**Response (201):**
```json
{
  "id": "result_123",
  "userId": "user_123",
  "assessmentId": "assessment_1",
  "attemptDate": "2024-01-30T16:00:00Z",
  "scorePercentage": 85,
  "correctAnswers": 17,
  "totalQuestions": 20,
  "timeSpentSeconds": 1200,
  "isPassed": true
}
```

#### GET /test-results/:userId
Get user's test results.

**Response (200):**
```json
{
  "data": [
    {
      "id": "result_123",
      "assessment": {
        "id": "assessment_1",
        "title": "Module 1 Quiz"
      },
      "attemptDate": "2024-01-30T16:00:00Z",
      "scorePercentage": 85,
      "isPassed": true
    }
  ]
}
```

---

### Certificates

#### GET /certificates/:userId
Get user's certificates.

**Response (200):**
```json
{
  "data": [
    {
      "id": "cert_123",
      "userId": "user_123",
      "courseId": "course_123",
      "title": "Flutter Development Professional",
      "certificateNumber": "NTT-2024-001234",
      "issuedDate": "2024-01-30T00:00:00Z",
      "expiryDate": "2025-01-30T00:00:00Z",
      "issuer": "Nexus Academy",
      "isVerified": true,
      "skills": ["Flutter", "Dart"]
    }
  ]
}
```

#### POST /certificates
Issue a certificate to a user.

**Request:**
```json
{
  "userId": "user_123",
  "courseId": "course_123",
  "title": "Flutter Development Professional",
  "certificateNumber": "NTT-2024-001234",
  "issuer": "Nexus Academy",
  "skills": ["Flutter", "Dart"],
  "expiryDays": 365
}
```

**Response (201):**
Certificate object (same as GET response).

#### GET /certificates/verify/:certificateId
Verify a certificate.

**Response (200):**
```json
{
  "id": "cert_123",
  "isValid": true,
  "isExpired": false,
  "user": {
    "id": "user_123",
    "fullName": "John Doe"
  },
  "certificate": {
    "title": "Flutter Development Professional",
    "certificateNumber": "NTT-2024-001234"
  }
}
```

---

### Analytics

#### GET /analytics/:userId
Get user's comprehensive analytics.

**Response (200):**
```json
{
  "userId": "user_123",
  "totalCoursesEnrolled": 15,
  "completedCourses": 12,
  "completionRate": 80,
  "averageAssessmentScore": 82.5,
  "certificatesEarned": 8,
  "topSkills": [
    {
      "skillId": "skill_1",
      "skillName": "Flutter",
      "proficiencyScore": 92,
      "level": "Advanced"
    }
  ],
  "generatedDate": "2024-01-30T16:00:00Z",
  "insights": "You're progressing well. Consider exploring Cloud Architecture courses."
}
```

#### GET /skills/:userId
Get user's skill DNA profile.

**Response (200):**
```json
{
  "userId": "user_123",
  "skills": [
    {
      "skillId": "skill_1",
      "skillName": "Flutter",
      "category": "Mobile Development",
      "proficiencyScore": 92,
      "level": "Advanced",
      "coursesCompleted": 3,
      "averageScore": 88.5,
      "lastAssessmentDate": "2024-01-25T10:00:00Z",
      "relatedCertificates": ["cert_123"]
    }
  ],
  "overallProficiency": 85,
  "lastUpdated": "2024-01-30T16:00:00Z"
}
```

---

## Error Responses

### 400 Bad Request
```json
{
  "error": "INVALID_REQUEST",
  "message": "Invalid request parameters",
  "details": ["email is required"]
}
```

### 401 Unauthorized
```json
{
  "error": "UNAUTHORIZED",
  "message": "Invalid or expired token"
}
```

### 403 Forbidden
```json
{
  "error": "FORBIDDEN",
  "message": "You don't have permission to access this resource"
}
```

### 404 Not Found
```json
{
  "error": "NOT_FOUND",
  "message": "Resource not found"
}
```

### 500 Internal Server Error
```json
{
  "error": "INTERNAL_ERROR",
  "message": "An internal server error occurred",
  "requestId": "req_xyz123"
}
```

---

## Rate Limiting

- **Limit**: 1000 requests per hour per API key
- **Headers**: 
  - `X-RateLimit-Limit`: 1000
  - `X-RateLimit-Remaining`: 999
  - `X-RateLimit-Reset`: 1635789600

---

## Pagination

All list endpoints support pagination with these parameters:
- `page` (int, default=1)
- `limit` (int, default=10, max=100)

Response includes:
```json
{
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 250,
    "pages": 25
  }
}
```

---

## Timestamps

All timestamps are in ISO 8601 format (UTC):
```
2024-01-30T16:00:00Z
```

---

Last Updated: January 30, 2026
