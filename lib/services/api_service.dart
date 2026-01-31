import 'package:dio/dio.dart';
import '../config/app_config.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: AppConfig.apiTimeout,
        receiveTimeout: AppConfig.apiTimeout,
        contentType: 'application/json',
      ),
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add authorization token if available
          // final token = await _getAuthToken();
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          return handler.next(options);
        },
        onError: (error, handler) {
          // Handle errors
          return handler.next(error);
        },
      ),
    );
  }

  // User endpoints
  Future<Response> login(String email, String password) async {
    return _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
  }

  Future<Response> register(Map<String, dynamic> userData) async {
    return _dio.post('/auth/register', data: userData);
  }

  Future<Response> getUserProfile(String userId) async {
    return _dio.get('/users/$userId');
  }

  // Course endpoints
  Future<Response> getCourses({int page = 1, int limit = 10}) async {
    return _dio.get(
      '/courses',
      queryParameters: {'page': page, 'limit': limit},
    );
  }

  Future<Response> getCourseDetails(String courseId) async {
    return _dio.get('/courses/$courseId');
  }

  Future<Response> enrollCourse(String userId, String courseId) async {
    return _dio.post(
      '/enrollments',
      data: {'userId': userId, 'courseId': courseId},
    );
  }

  // Assessment endpoints
  Future<Response> getAssessments(String courseId) async {
    return _dio.get('/assessments', queryParameters: {'courseId': courseId});
  }

  Future<Response> getAssessmentById(String assessmentId) async {
    return _dio.get('/assessments/$assessmentId');
  }

  Future<Response> submitAssessment(Map<String, dynamic> resultData) async {
    return _dio.post('/test-results', data: resultData);
  }

  Future<Response> getTestResults(String userId) async {
    return _dio.get('/test-results/$userId');
  }

  // Enrollment endpoints
  Future<Response> getEnrollments(String userId) async {
    return _dio.get('/enrollments', queryParameters: {'userId': userId});
  }

  Future<Response> updateEnrollment(
    String enrollmentId,
    Map<String, dynamic> data,
  ) async {
    return _dio.put('/enrollments/$enrollmentId', data: data);
  }

  // Certificate endpoints
  Future<Response> getCertificates(String userId) async {
    return _dio.get('/certificates/$userId');
  }

  Future<Response> verifyCertificate(String certificateId) async {
    return _dio.get('/certificates/verify/$certificateId');
  }

  Future<Response> issueCertificate(
    Map<String, dynamic> certificateData,
  ) async {
    return _dio.post('/certificates', data: certificateData);
  }

  // Analytics endpoints
  Future<Response> getUserAnalytics(String userId) async {
    return _dio.get('/analytics/$userId');
  }

  Future<Response> getSkillDNA(String userId) async {
    return _dio.get('/skills/$userId');
  }

  Future<Response> getCompletionReport(String userId) async {
    return _dio.get('/reports/completion/$userId');
  }

  // Logout endpoint
  Future<Response> logout() async {
    return _dio.post('/auth/logout');
  }
}
