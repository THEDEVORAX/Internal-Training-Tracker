import 'package:equatable/equatable.dart';
import 'assessment.dart';

/// Module entity representing a training module within a course
final class Module extends Equatable {
  final String id;
  final String title;
  final String description;
  final DifficultyLevel difficultyLevel;
  final Duration duration;
  final List<Assessment> assessments;
  final ModuleStatus status;

  const Module({
    required this.id,
    required this.title,
    required this.description,
    required this.difficultyLevel,
    required this.duration,
    required this.assessments,
    required this.status,
  });

  /// Weighted score based on difficulty
  double get weightedScore {
    if (assessments.isEmpty) return 0;
    final totalScore = assessments.fold(0.0, (sum, a) => sum + a.percentage);
    return (totalScore / assessments.length) * difficultyLevel.weight;
  }

  /// Average assessment score
  double get averageScore {
    if (assessments.isEmpty) return 0;
    return assessments.fold(0.0, (sum, a) => sum + a.percentage) /
        assessments.length;
  }

  /// Check if module is completed
  bool get isCompleted => status == ModuleStatus.completed;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    difficultyLevel,
    duration,
    assessments,
    status,
  ];
}

/// Difficulty levels with weight multipliers for analytics
enum DifficultyLevel {
  beginner(1.0, 'Beginner'),
  intermediate(1.5, 'Intermediate'),
  advanced(2.0, 'Advanced'),
  expert(2.5, 'Expert');

  final double weight;
  final String displayName;
  const DifficultyLevel(this.weight, this.displayName);
}

/// Module completion status
enum ModuleStatus {
  notStarted('Not Started'),
  inProgress('In Progress'),
  completed('Completed'),
  failed('Failed');

  final String displayName;
  const ModuleStatus(this.displayName);
}
