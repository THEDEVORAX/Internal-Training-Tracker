import 'package:equatable/equatable.dart';
import 'course.dart';

/// Employee entity representing a company employee
final class Employee extends Equatable {
  final String id;
  final String name;
  final String email;
  final EmployeeRole role;
  final String department;
  final String avatarUrl;
  final DateTime hireDate;
  final List<Course> courses;
  final List<String> skills;

  const Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.avatarUrl,
    required this.hireDate,
    required this.courses,
    required this.skills,
  });

  /// Overall training progress across all courses
  double get overallProgress {
    if (courses.isEmpty) return 0;
    return courses.fold(0.0, (sum, c) => sum + c.progress) / courses.length;
  }

  /// Number of completed courses
  int get completedCoursesCount => courses.where((c) => c.isCompleted).length;

  /// Number of in-progress courses
  int get inProgressCoursesCount => courses.where((c) => c.isInProgress).length;

  /// Overall weighted performance score
  double get overallPerformance {
    final completedCourses = courses.where((c) => c.isCompleted).toList();
    if (completedCourses.isEmpty) return 0;
    return completedCourses.fold(
          0.0,
          (sum, c) => sum + c.weightedAverageScore,
        ) /
        completedCourses.length;
  }

  /// Total training hours completed
  Duration get totalTrainingTime {
    return courses.fold(Duration.zero, (sum, c) => sum + c.completedDuration);
  }

  /// Get courses by category
  List<Course> coursesByCategory(CourseCategory category) {
    return courses.where((c) => c.category == category).toList();
  }

  /// Calculate skill score for a specific category
  double skillScoreForCategory(CourseCategory category) {
    final categoryCourses = coursesByCategory(category);
    if (categoryCourses.isEmpty) return 0;
    return categoryCourses.fold(0.0, (sum, c) => sum + c.weightedAverageScore) /
        categoryCourses.length;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    role,
    department,
    avatarUrl,
    hireDate,
    courses,
    skills,
  ];
}

/// Employee role classification
enum EmployeeRole {
  junior('Junior', 1),
  mid('Mid-Level', 2),
  senior('Senior', 3),
  lead('Team Lead', 4),
  manager('Manager', 5),
  director('Director', 6);

  final String displayName;
  final int level;
  const EmployeeRole(this.displayName, this.level);
}
