import '../models/assessment.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';
import '../utils/exceptions.dart';

/// Abstract repository for assessments and test results.
abstract class AssessmentRepository {
  Future<List<Assessment>> getAssessments(String courseId);
  Future<Assessment> getAssessmentById(String id);
  Future<TestResult> submitTestResult(TestResult result);
  Future<List<TestResult>> getUserTestResults(String userId);
}

/// [AssessmentRepositoryImpl] handles assessment data and analytics.
class AssessmentRepositoryImpl implements AssessmentRepository {
  final ApiService _apiService;
  // ignore: unused_field
  final DatabaseService _databaseService;

  AssessmentRepositoryImpl({
    required ApiService apiService,
    required DatabaseService databaseService,
  })  : _apiService = apiService,
        _databaseService = databaseService;

  @override
  Future<List<Assessment>> getAssessments(String courseId) async {
    // In a real app, we would fetch from API or Local DB
    return [];
  }

  @override
  Future<Assessment> getAssessmentById(String id) async {
    throw ServerException(message: 'Assessment not found');
  }

  @override
  Future<TestResult> submitTestResult(TestResult result) async {
    return result;
  }

  @override
  Future<List<TestResult>> getUserTestResults(String userId) async {
    // Providing mock analytics data to represent user performance
    return [
      TestResult(
        id: 'tr1',
        userId: userId,
        assessmentId: 'a1',
        attemptDate: DateTime.now().subtract(const Duration(days: 5)),
        scorePercentage: 88.0,
        correctAnswers: 18,
        totalQuestions: 20,
        timeSpentSeconds: 1200,
        isPassed: true,
      ),
      TestResult(
        id: 'tr2',
        userId: userId,
        assessmentId: 'a2',
        attemptDate: DateTime.now().subtract(const Duration(days: 2)),
        scorePercentage: 95.0,
        correctAnswers: 19,
        totalQuestions: 20,
        timeSpentSeconds: 900,
        isPassed: true,
      ),
    ];
  }
}
