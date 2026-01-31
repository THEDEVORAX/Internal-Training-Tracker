# Development Guidelines for Nexus Training Tracker

## Code Style & Standards

### Dart/Flutter Conventions
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Keep functions small and focused
- Add documentation comments for public APIs

### File Organization
```
lib/
├── models/           # Data models and entities
├── providers/        # State management (Provider, Riverpod)
├── services/         # Business logic and API calls
├── screens/          # Full-screen widgets
├── widgets/          # Reusable component widgets
├── theme/            # App theming and styling
├── routes/           # Navigation definitions
├── config/           # App configuration
└── utils/            # Utility functions and constants
```

## Project Structure

### Models
- Keep models immutable using `@immutable` or `freezed`
- Use `Equatable` for value comparison
- Implement `copyWith()` for easy modifications

### Services
- `ApiService` - Handles all HTTP requests
- `DatabaseService` - Local database operations
- Create specialized services for each major feature
- Keep services testable with dependency injection

### Providers (State Management)
- Use Provider for global app state
- Use ChangeNotifier for screen-level state
- Avoid deep provider nesting

### Screens & Widgets
- Screens should contain navigation logic
- Widgets should be reusable and composable
- Use const constructors when possible
- Keep widget build() methods focused

## Testing Strategy

### Unit Tests
Test business logic in services and providers:
```dart
test('ApiService should fetch courses', () async {
  final service = ApiService();
  final courses = await service.getCourses();
  expect(courses, isNotEmpty);
});
```

### Widget Tests
Test UI components:
```dart
testWidgets('CourseCard should display course info', (tester) async {
  await tester.pumpWidget(
    const CourseCard(
      courseTitle: 'Test Course',
      instructor: 'Test Instructor',
      rating: 4.5,
      enrollmentCount: 100,
      onTap: () {},
    ),
  );
  expect(find.text('Test Course'), findsOneWidget);
});
```

### Integration Tests
Test complete user flows:
```dart
testWidgets('User can enroll in course', (tester) async {
  await tester.pumpWidget(const MyApp());
  // Navigate and interact with course enrollment flow
});
```

## Performance Optimization

### Build Optimization
- Use `const` constructors to prevent unnecessary rebuilds
- Implement `RepaintBoundary` for expensive widgets
- Use `ListView.builder` for long lists
- Lazy load data with pagination

### State Management
- Don't rebuild unnecessarily with excessive listeners
- Use `Selector` to listen to specific state changes
- Implement proper disposal of resources

### Memory Management
- Close database connections properly
- Cancel API requests when screen is disposed
- Use `FutureBuilder` and `StreamBuilder` correctly

## Database

### SQLite Best Practices
- Create indexes for frequently queried columns
- Use transactions for multiple operations
- Implement data migrations carefully
- Clean up old data regularly

## API Integration

### Error Handling
```dart
try {
  final response = await _dio.get('/endpoint');
  return response.data;
} on DioException catch (e) {
  if (e.response?.statusCode == 404) {
    throw NotFoundException('Resource not found');
  }
  throw ApiException('API Error: ${e.message}');
}
```

### Request/Response Format
- Use JSON serialization with json_serializable
- Implement proper error response models
- Add request/response logging in development

## Security Best Practices

1. **Never commit sensitive data**
   - Use environment variables
   - Store secrets in secure storage

2. **Encrypt sensitive data**
   - Use flutter_secure_storage for tokens
   - Encrypt local database for sensitive fields

3. **API Security**
   - Always use HTTPS
   - Implement certificate pinning
   - Validate SSL certificates

4. **User Data Protection**
   - Follow GDPR/privacy regulations
   - Implement proper access control
   - Log user actions for audit trail

## Git Workflow

### Branch Naming
- `feature/feature-name` - New features
- `bugfix/bug-name` - Bug fixes
- `hotfix/issue-name` - Critical fixes
- `docs/documentation-name` - Documentation

### Commit Messages
```
[TYPE] Description of change

Detailed explanation if needed.
- Bullet points for multiple changes
- References to issues: Closes #123

Types: feat, fix, docs, style, refactor, test, chore
```

## Documentation

### Code Documentation
```dart
/// Fetches a list of courses filtered by category.
///
/// Takes an optional [category] parameter to filter results.
/// Returns a list of [Course] objects.
///
/// Throws [ApiException] if the request fails.
Future<List<Course>> getCourses({String? category}) async {
  // implementation
}
```

### README Updates
Keep README.md updated with:
- Installation instructions
- Configuration steps
- Available features
- Known issues

## Deployment

### Build Variants
- **Debug**: For development with hot reload
- **Release**: Optimized for production
- **Profile**: For performance profiling

### Version Management
Follow semantic versioning: `MAJOR.MINOR.PATCH`
- MAJOR: Breaking changes
- MINOR: New features
- PATCH: Bug fixes

---

For more information, see the main [README.md](README.md)
