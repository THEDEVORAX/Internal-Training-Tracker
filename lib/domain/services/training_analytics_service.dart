import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

/// Analytics model for radar chart skill visualization
final class SkillRadarData extends Equatable {
  final CourseCategory category;
  final double score;
  final int coursesCompleted;
  final int totalCourses;

  const SkillRadarData({
    required this.category,
    required this.score,
    required this.coursesCompleted,
    required this.totalCourses,
  });

  double get completionRate =>
      totalCourses > 0 ? coursesCompleted / totalCourses : 0;

  @override
  List<Object?> get props => [category, score, coursesCompleted, totalCourses];
}

/// Performance trend data point
final class PerformanceTrend extends Equatable {
  final DateTime date;
  final double score;
  final int coursesCompleted;

  const PerformanceTrend({
    required this.date,
    required this.score,
    required this.coursesCompleted,
  });

  @override
  List<Object?> get props => [date, score, coursesCompleted];
}

/// Comprehensive analytics result for an employee
final class EmployeeAnalytics extends Equatable {
  final Employee employee;
  final double weightedAveragePerformance;
  final List<SkillRadarData> skillRadarData;
  final List<PerformanceTrend> performanceTrends;
  final DateTime? projectedCompletionDate;
  final double learningVelocity; // courses per month
  final Duration averageTimePerCourse;
  final int totalAssessmentsCompleted;
  final double averageAssessmentScore;

  const EmployeeAnalytics({
    required this.employee,
    required this.weightedAveragePerformance,
    required this.skillRadarData,
    required this.performanceTrends,
    this.projectedCompletionDate,
    required this.learningVelocity,
    required this.averageTimePerCourse,
    required this.totalAssessmentsCompleted,
    required this.averageAssessmentScore,
  });

  @override
  List<Object?> get props => [
    employee,
    weightedAveragePerformance,
    skillRadarData,
    performanceTrends,
    projectedCompletionDate,
    learningVelocity,
    averageTimePerCourse,
    totalAssessmentsCompleted,
    averageAssessmentScore,
  ];
}

/// Training Analytics Service - Core business logic for analytics
class TrainingAnalyticsService {
  /// Calculate weighted average performance for an employee
  /// Weight is based on module difficulty
  double calculateWeightedAveragePerformance(Employee employee) {
    final completedCourses = employee.courses
        .where((c) => c.isCompleted)
        .toList();
    if (completedCourses.isEmpty) return 0;

    double totalWeightedScore = 0;
    double totalWeight = 0;

    for (final course in completedCourses) {
      for (final module in course.modules.where((m) => m.isCompleted)) {
        totalWeightedScore +=
            module.averageScore * module.difficultyLevel.weight;
        totalWeight += module.difficultyLevel.weight;
      }
    }

    return totalWeight > 0 ? totalWeightedScore / totalWeight : 0;
  }

  /// Generate skill radar data for visualization
  List<SkillRadarData> generateSkillRadarData(Employee employee) {
    return CourseCategory.values.map((category) {
      final categoryCourses = employee.coursesByCategory(category);
      final completedCourses = categoryCourses
          .where((c) => c.isCompleted)
          .toList();

      final score = categoryCourses.isEmpty
          ? 0.0
          : employee.skillScoreForCategory(category);

      return SkillRadarData(
        category: category,
        score: score,
        coursesCompleted: completedCourses.length,
        totalCourses: categoryCourses.length,
      );
    }).toList();
  }

  /// Calculate learning velocity (courses completed per month)
  double calculateLearningVelocity(Employee employee) {
    final completedCourses = employee.courses
        .where((c) => c.isCompleted)
        .toList();
    if (completedCourses.isEmpty) return 0;

    final firstCompletion = completedCourses
        .map((c) => c.completionDate!)
        .reduce((a, b) => a.isBefore(b) ? a : b);

    final lastCompletion = completedCourses
        .map((c) => c.completionDate!)
        .reduce((a, b) => a.isAfter(b) ? a : b);

    final monthsDiff = lastCompletion.difference(firstCompletion).inDays / 30;

    return monthsDiff > 0
        ? completedCourses.length / monthsDiff
        : completedCourses.length.toDouble();
  }

  /// Estimate projected completion date for remaining courses
  DateTime? estimateProjectedCompletionDate(Employee employee) {
    final inProgressCourses = employee.courses
        .where((c) => c.isInProgress)
        .toList();
    if (inProgressCourses.isEmpty) return null;

    final velocity = calculateLearningVelocity(employee);
    if (velocity <= 0) return null;

    final remainingCourses = inProgressCourses.length;
    final monthsToComplete = remainingCourses / velocity;

    return DateTime.now().add(Duration(days: (monthsToComplete * 30).round()));
  }

  /// Generate performance trends over time
  List<PerformanceTrend> generatePerformanceTrends(Employee employee) {
    final completedCourses =
        employee.courses
            .where((c) => c.isCompleted && c.completionDate != null)
            .toList()
          ..sort((a, b) => a.completionDate!.compareTo(b.completionDate!));

    if (completedCourses.isEmpty) return [];

    final trends = <PerformanceTrend>[];
    double cumulativeScore = 0;

    for (int i = 0; i < completedCourses.length; i++) {
      final course = completedCourses[i];
      cumulativeScore += course.weightedAverageScore;

      trends.add(
        PerformanceTrend(
          date: course.completionDate!,
          score: cumulativeScore / (i + 1),
          coursesCompleted: i + 1,
        ),
      );
    }

    return trends;
  }

  /// Calculate average time per course
  Duration calculateAverageTimePerCourse(Employee employee) {
    final completedCourses = employee.courses
        .where((c) => c.isCompleted)
        .toList();
    if (completedCourses.isEmpty) return Duration.zero;

    final totalDuration = completedCourses.fold(
      Duration.zero,
      (sum, c) => sum + c.totalDuration,
    );

    return Duration(
      minutes: totalDuration.inMinutes ~/ completedCourses.length,
    );
  }

  /// Get total assessments completed
  int getTotalAssessmentsCompleted(Employee employee) {
    return employee.courses.fold(0, (sum, course) {
      return sum +
          course.modules.fold(0, (mSum, module) {
            return mSum + module.assessments.length;
          });
    });
  }

  /// Calculate average assessment score
  double calculateAverageAssessmentScore(Employee employee) {
    int totalAssessments = 0;
    double totalScore = 0;

    for (final course in employee.courses) {
      for (final module in course.modules) {
        for (final assessment in module.assessments) {
          totalScore += assessment.percentage;
          totalAssessments++;
        }
      }
    }

    return totalAssessments > 0 ? totalScore / totalAssessments : 0;
  }

  /// Generate comprehensive analytics for an employee
  EmployeeAnalytics generateEmployeeAnalytics(Employee employee) {
    return EmployeeAnalytics(
      employee: employee,
      weightedAveragePerformance: calculateWeightedAveragePerformance(employee),
      skillRadarData: generateSkillRadarData(employee),
      performanceTrends: generatePerformanceTrends(employee),
      projectedCompletionDate: estimateProjectedCompletionDate(employee),
      learningVelocity: calculateLearningVelocity(employee),
      averageTimePerCourse: calculateAverageTimePerCourse(employee),
      totalAssessmentsCompleted: getTotalAssessmentsCompleted(employee),
      averageAssessmentScore: calculateAverageAssessmentScore(employee),
    );
  }
}
