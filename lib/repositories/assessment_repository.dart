import '../models/assessment.dart';
import '../services/api_service.dart';
import '../utils/exceptions.dart';

/// Abstract repository for assessments and test results
abstract class AssessmentRepository {
  Future<List<Assessment>> getAssessments(String courseId);
  Future<Assessment> getAssessmentById(String id);
  Future<TestResult> submitTestResult(TestResult result);
  Future<List<TestResult>> getUserTestResults(String userId);
}

/// Implementation of AssessmentRepository

class AssessmentRepositoryImpl implements AssessmentRepository {
  final ApiService _apiService;

  AssessmentRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<Assessment>> getAssessments(String courseId) async {
    try {
      final response = await _apiService.getAssessments(courseId);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final assessmentList =
            List<Map<String, dynamic>>.from(data['data'] as List);
        return assessmentList.map((json) {
          return Assessment(
            id: json['id'] as String,
            courseId: json['courseId'] as String,
            title: json['title'] as String,
            description: json['description'] as String,
            totalQuestions: json['totalQuestions'] as int,
            passingScore: (json['passingScore'] as num).toDouble(),
            timeMinutes: json['timeMinutes'] as int,
            createdDate: DateTime.parse(json['createdDate'] as String),
            questions: [],
          );
        }).toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch assessments',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw NetworkException(
        message: 'Error fetching assessments: $e',
        originalException: e,
      );
    }
  }

  @override
  Future<Assessment> getAssessmentById(String id) async {
    try {
      final response = await _apiService.getAssessmentById(id);

      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;
        return Assessment(
          id: json['id'] as String,
          courseId: json['courseId'] as String,
          title: json['title'] as String,
          description: json['description'] as String,
          totalQuestions: json['totalQuestions'] as int,
          passingScore: (json['passingScore'] as num).toDouble(),
          timeMinutes: json['timeMinutes'] as int,
          createdDate: DateTime.parse(json['createdDate'] as String),
          questions: [],
        );
      } else {
        throw ServerException(
          message: 'Assessment not found',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw NetworkException(
        message: 'Error fetching assessment: $e',
        originalException: e,
      );
    }
  }

  @override
  Future<TestResult> submitTestResult(TestResult result) async {
    try {
      final response = await _apiService.submitAssessment({
        'userId': result.userId,
        'assessmentId': result.assessmentId,
        'userAnswers': result.userAnswers,
        'timeSpentSeconds': result.timeSpentSeconds,
      });

      if (response.statusCode == 201) {
        final json = response.data as Map<String, dynamic>;
        return TestResult(
          id: json['id'] as String,
          userId: json['userId'] as String,
          assessmentId: json['assessmentId'] as String,
          attemptDate: DateTime.parse(json['attemptDate'] as String),
          scorePercentage: (json['scorePercentage'] as num).toDouble(),
          correctAnswers: json['correctAnswers'] as int,
          totalQuestions: json['totalQuestions'] as int,
          timeSpentSeconds: json['timeSpentSeconds'] as int,
          isPassed: json['isPassed'] as bool,
          userAnswers: List<String>.from(json['userAnswers'] as List),
        );
      } else {
        throw ServerException(
          message: 'Failed to submit test result',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw NetworkException(
        message: 'Error submitting test result: $e',
        originalException: e,
      );
    }
  }

  @override
  Future<List<TestResult>> getUserTestResults(String userId) async {
    try {
      final response = await _apiService.getTestResults(userId);

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = List<Map<String, dynamic>>.from(data['data'] as List);
        return results.map((json) {
          return TestResult(
            id: json['id'] as String,
            userId: json['userId'] as String,
            assessmentId: json['assessmentId'] as String,
            attemptDate: DateTime.parse(json['attemptDate'] as String),
            scorePercentage: (json['scorePercentage'] as num).toDouble(),
            correctAnswers: json['correctAnswers'] as int,
            totalQuestions: json['totalQuestions'] as int,
            timeSpentSeconds: json['timeSpentSeconds'] as int,
            isPassed: json['isPassed'] as bool,
            userAnswers: List<String>.from(json['userAnswers'] as List? ?? []),
          );
        }).toList();
      } else {
        throw ServerException(
          message: 'Failed to fetch test results',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw NetworkException(
        message: 'Error fetching test results: $e',
        originalException: e,
      );
    }
  }
}
