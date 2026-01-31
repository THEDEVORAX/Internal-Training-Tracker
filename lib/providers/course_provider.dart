import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repositories/course_repository.dart';
import '../utils/result.dart';

/// Provider for managing course-related state
class CourseProvider extends ChangeNotifier {
  final CourseRepository _repository;

  CourseProvider({required CourseRepository repository})
    : _repository = repository;

  Result<List<Course>> _courseResult = const LoadingResult();
  Result<List<Enrollment>> _enrollmentResult = const LoadingResult();

  Result<List<Course>> get courseResult => _courseResult;
  Result<List<Enrollment>> get enrollmentResult => _enrollmentResult;

  List<Course> _filteredCourses = [];
  List<Course> get filteredCourses => _filteredCourses;

  /// Fetch all courses
  Future<void> loadCourses({int page = 1, int limit = 10}) async {
    _courseResult = const LoadingResult();
    notifyListeners();

    try {
      final courses = await _repository.getCourses(page: page, limit: limit);
      _courseResult = SuccessResult(courses);
      _filteredCourses = courses;
    } catch (e) {
      _courseResult = ErrorResult(e.toString());
    }
    notifyListeners();
  }

  /// Search and filter courses
  void searchCourses(String query) {
    _courseResult.when(
      success: (courses) {
        _filteredCourses = courses
            .where(
              (course) =>
                  course.title.toLowerCase().contains(query.toLowerCase()) ||
                  course.description.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  course.instructor.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
        notifyListeners();
      },
      error: (_) {},
      loading: () {},
    );
  }

  /// Filter courses by category
  void filterByCategory(String category) {
    _courseResult.when(
      success: (courses) {
        _filteredCourses = courses
            .where(
              (course) =>
                  course.category.toLowerCase() == category.toLowerCase(),
            )
            .toList();
        notifyListeners();
      },
      error: (_) {},
      loading: () {},
    );
  }

  /// Filter courses by difficulty
  void filterByDifficulty(String difficulty) {
    _courseResult.when(
      success: (courses) {
        _filteredCourses = courses
            .where(
              (course) =>
                  course.difficulty.toLowerCase() == difficulty.toLowerCase(),
            )
            .toList();
        notifyListeners();
      },
      error: (_) {},
      loading: () {},
    );
  }

  /// Sort courses by rating
  void sortByRating() {
    _filteredCourses.sort((a, b) => b.rating.compareTo(a.rating));
    notifyListeners();
  }

  /// Sort courses by enrollment count
  void sortByPopularity() {
    _filteredCourses.sort(
      (a, b) => b.enrollmentCount.compareTo(a.enrollmentCount),
    );
    notifyListeners();
  }

  /// Enroll in a course
  Future<void> enrollCourse(String userId, String courseId) async {
    try {
      await _repository.enrollCourse(userId, courseId);
      await loadUserEnrollments(userId);
    } catch (e) {
      _enrollmentResult = ErrorResult(e.toString());
      notifyListeners();
    }
  }

  /// Load user enrollments
  Future<void> loadUserEnrollments(String userId) async {
    _enrollmentResult = const LoadingResult();
    notifyListeners();

    try {
      final enrollments = await _repository.getUserEnrollments(userId);
      _enrollmentResult = SuccessResult(enrollments);
    } catch (e) {
      _enrollmentResult = ErrorResult(e.toString());
    }
    notifyListeners();
  }

  /// Get active enrollments
  List<Enrollment> get activeEnrollments {
    return _enrollmentResult.when(
      success: (enrollments) => enrollments.where((e) => e.isActive).toList(),
      error: (_) => [],
      loading: () => [],
    );
  }

  /// Get completed enrollments
  List<Enrollment> get completedEnrollments {
    return _enrollmentResult.when(
      success: (enrollments) =>
          enrollments.where((e) => e.isCompleted).toList(),
      error: (_) => [],
      loading: () => [],
    );
  }
}
