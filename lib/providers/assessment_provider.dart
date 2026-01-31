import 'package:flutter/material.dart';
import '../models/assessment.dart';
import '../repositories/assessment_repository.dart';
import '../utils/result.dart';

/// Provider for managing assessment-related state
class AssessmentProvider extends ChangeNotifier {
  final AssessmentRepository _repository;

  AssessmentProvider({required AssessmentRepository repository})
    : _repository = repository;

  Result<List<Assessment>> _assessmentResult = const LoadingResult();
  Result<List<TestResult>> _testResultResult = const LoadingResult();

  Result<List<Assessment>> get assessmentResult => _assessmentResult;
  Result<List<TestResult>> get testResultResult => _testResultResult;

  /// Load assessments for a course
  Future<void> loadAssessments(String courseId) async {
    _assessmentResult = const LoadingResult();
    notifyListeners();

    try {
      final assessments = await _repository.getAssessments(courseId);
      _assessmentResult = SuccessResult(assessments);
    } catch (e) {
      _assessmentResult = ErrorResult(e.toString());
    }
    notifyListeners();
  }

  /// Submit test result
  Future<bool> submitTestResult(TestResult result) async {
    try {
      await _repository.submitTestResult(result);
      return true;
    } catch (e) {
      _testResultResult = ErrorResult(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// Load user test results
  Future<void> loadUserTestResults(String userId) async {
    _testResultResult = const LoadingResult();
    notifyListeners();

    try {
      final results = await _repository.getUserTestResults(userId);
      _testResultResult = SuccessResult(results);
    } catch (e) {
      _testResultResult = ErrorResult(e.toString());
    }
    notifyListeners();
  }

  /// Get passed test results
  List<TestResult> get passedResults {
    return _testResultResult.when(
      success: (results) => results.where((r) => r.isPassed).toList(),
      error: (_) => [],
      loading: () => [],
    );
  }

  /// Get failed test results
  List<TestResult> get failedResults {
    return _testResultResult.when(
      success: (results) => results.where((r) => !r.isPassed).toList(),
      error: (_) => [],
      loading: () => [],
    );
  }

  /// Get average score
  double get averageScore {
    return _testResultResult.when(
      success: (results) {
        if (results.isEmpty) return 0.0;
        final total = results.fold<double>(
          0,
          (sum, r) => sum + r.scorePercentage,
        );
        return total / results.length;
      },
      error: (_) => 0.0,
      loading: () => 0.0,
    );
  }

  /// Get pass rate
  double get passRate {
    return _testResultResult.when(
      success: (results) {
        if (results.isEmpty) return 0.0;
        final passed = results.where((r) => r.isPassed).length;
        return (passed / results.length) * 100;
      },
      error: (_) => 0.0,
      loading: () => 0.0,
    );
  }
}
