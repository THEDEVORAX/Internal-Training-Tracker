import '../models/course.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';
import '../utils/exceptions.dart';

/// Abstract repository interface for courses.
abstract class CourseRepository {
  Future<List<Course>> getCourses({int page = 1, int limit = 10});
  Future<Course> getCourseById(String id);
  Future<void> enrollCourse(String userId, String courseId);
  Future<List<Enrollment>> getUserEnrollments(String userId);
}

/// [CourseRepositoryImpl] handles data fetching for courses.
/// It implements a "local-first" or "cache-first" strategy with mock fallback.
class CourseRepositoryImpl implements CourseRepository {
  final ApiService _apiService;
  final DatabaseService _databaseService;

  CourseRepositoryImpl({
    required ApiService apiService,
    required DatabaseService databaseService,
  })  : _apiService = apiService,
        _databaseService = databaseService;

  @override
  Future<List<Course>> getCourses({int page = 1, int limit = 10}) async {
    try {
      // First, try to get from local database for fast load
      final localCourses = await _databaseService.getAllCourses();
      if (localCourses.isNotEmpty) return localCourses;

      // In a real app, we'd hit the API here
      // final response = await _apiService.getCourses(page: page, limit: limit);

      // Since no real API exists yet, we provide premium mock data to unblock development
      final mockCourses = _getMockCourses();

      // Cache the mock data locally
      for (var course in mockCourses) {
        await _databaseService.insertCourse(course);
      }

      return mockCourses;
    } catch (e) {
      throw NetworkException(
        message: 'Error fetching courses: $e',
        originalException: e,
      );
    }
  }

  @override
  Future<Course> getCourseById(String id) async {
    try {
      final courses = await getCourses();
      return courses.firstWhere((c) => c.id == id);
    } catch (e) {
      throw ServerException(message: 'Course not found: $id');
    }
  }

  @override
  Future<void> enrollCourse(String userId, String courseId) async {
    try {
      final enrollment = Enrollment(
        id: 'enroll_${DateTime.now().millisecondsSinceEpoch}',
        userId: userId,
        courseId: courseId,
        enrollDate: DateTime.now(),
        status: 'active',
        progressPercentage: 0.0,
      );

      await _databaseService.insertEnrollment(enrollment);
    } catch (e) {
      throw NetworkException(
        message: 'Error enrolling in course: $e',
        originalException: e,
      );
    }
  }

  @override
  Future<List<Enrollment>> getUserEnrollments(String userId) async {
    // For now, return empty or mock if needed
    return [];
  }

  // --- Helper: Mock Data ---

  List<Course> _getMockCourses() {
    return [
      Course(
        id: 'c1',
        title: 'Advanced Flutter Architecture',
        description:
            'Master clean architecture and state management in large scale Flutter apps.',
        instructor: 'Dr. Sarah Connor',
        category: 'Development',
        durationMinutes: 480,
        rating: 4.9,
        enrollmentCount: 1250,
        createdDate: DateTime.now().subtract(const Duration(days: 30)),
        skills: const ['Dart', 'Clean Architecture', 'Bloc'],
        difficulty: 'Advanced',
      ),
      Course(
        id: 'c2',
        title: 'Modern UI/UX Principles',
        description:
            'Design digital experiences that wow your users using Material 3 and beyond.',
        instructor: 'Julian Rivers',
        category: 'Design',
        durationMinutes: 320,
        rating: 4.8,
        enrollmentCount: 3400,
        createdDate: DateTime.now().subtract(const Duration(days: 15)),
        skills: const ['Figma', 'UI Design', 'Case Study'],
        difficulty: 'Intermediate',
      ),
      Course(
        id: 'c3',
        title: 'Cloud Infrastructure with AWS',
        description:
            'Scalable cloud computing for enterprise-level applications.',
        instructor: 'Mike Ross',
        category: 'Cloud',
        durationMinutes: 900,
        rating: 4.7,
        enrollmentCount: 890,
        createdDate: DateTime.now().subtract(const Duration(days: 60)),
        skills: const ['AWS', 'Docker', 'Kubernetes'],
        difficulty: 'Expert',
      ),
    ];
  }
}
