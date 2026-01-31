import '../models/course.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';
import '../utils/exceptions.dart';

/// Abstract repository interface for courses
abstract class CourseRepository {
  Future<List<Course>> getCourses({int page = 1, int limit = 10});
  Future<Course> getCourseById(String id);
  Future<void> enrollCourse(String userId, String courseId);
  Future<List<Enrollment>> getUserEnrollments(String userId);
}

/// Implementation of CourseRepository

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
      final response = await _apiService.getCourses(page: page, limit: limit);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final courseList =
            List<Map<String, dynamic>>.from(data['data'] as List);
        return courseList.map((json) => Course.fromJson(json)).toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch courses',
          statusCode: response.statusCode,
        );
      }
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
      final response = await _apiService.getCourseDetails(id);

      if (response.statusCode == 200) {
        return Course.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          message: 'Course not found',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw NetworkException(
        message: 'Error fetching course details: $e',
        originalException: e,
      );
    }
  }

  @override
  Future<void> enrollCourse(String userId, String courseId) async {
    try {
      final response = await _apiService.enrollCourse(userId, courseId);

      if (response.statusCode == 201) {
        final enrollmentData = response.data as Map<String, dynamic>;
        final enrollment = Enrollment.fromJson(enrollmentData);
        await _databaseService.insertEnrollment(enrollment);
      } else {
        throw ServerException(
          message: 'Failed to enroll in course',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw NetworkException(
        message: 'Error enrolling in course: $e',
        originalException: e,
      );
    }
  }

  @override
  Future<List<Enrollment>> getUserEnrollments(String userId) async {
    try {
      final response = await _apiService.getEnrollments(userId);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final enrollmentList =
            List<Map<String, dynamic>>.from(data['data'] as List);
        return enrollmentList.map((json) => Enrollment.fromJson(json)).toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch enrollments',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw NetworkException(
        message: 'Error fetching enrollments: $e',
        originalException: e,
      );
    }
  }
}
