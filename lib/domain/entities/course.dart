import 'package:equatable/equatable.dart';
import 'module.dart';

/// Course entity representing a training course
final class Course extends Equatable {
  final String id;
  final String title;
  final String description;
  final CourseCategory category;
  final String imageUrl;
  final List<Module> modules;
  final DateTime startDate;
  final DateTime? completionDate;
  final String instructor;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.modules,
    required this.startDate,
    this.completionDate,
    required this.instructor,
  });

  /// Overall course progress (0.0 - 1.0)
  double get progress {
    if (modules.isEmpty) return 0;
    final completed = modules.where((m) => m.isCompleted).length;
    return completed / modules.length;
  }

  /// Total duration of all modules
  Duration get totalDuration {
    return modules.fold(Duration.zero, (sum, m) => sum + m.duration);
  }

  /// Completed duration
  Duration get completedDuration {
    return modules
        .where((m) => m.isCompleted)
        .fold(Duration.zero, (sum, m) => sum + m.duration);
  }

  /// Average score across all modules
  double get averageScore {
    final completedModules = modules.where((m) => m.isCompleted).toList();
    if (completedModules.isEmpty) return 0;
    return completedModules.fold(0.0, (sum, m) => sum + m.averageScore) /
        completedModules.length;
  }

  /// Weighted average score
  double get weightedAverageScore {
    final completedModules = modules.where((m) => m.isCompleted).toList();
    if (completedModules.isEmpty) return 0;
    final totalWeight = completedModules.fold(
      0.0,
      (sum, m) => sum + m.difficultyLevel.weight,
    );
    final weightedSum = completedModules.fold(
      0.0,
      (sum, m) => sum + m.weightedScore,
    );
    return totalWeight > 0 ? weightedSum / totalWeight : 0;
  }

  /// Check if course is completed
  bool get isCompleted => completionDate != null;

  /// Check if course is in progress
  bool get isInProgress =>
      !isCompleted && modules.any((m) => m.status != ModuleStatus.notStarted);

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    imageUrl,
    modules,
    startDate,
    completionDate,
    instructor,
  ];
}

/// Course category classification
enum CourseCategory {
  technical('Technical', '💻'),
  leadership('Leadership', '👔'),
  softSkills('Soft Skills', '🤝'),
  compliance('Compliance', '📋'),
  productKnowledge('Product Knowledge', '📦'),
  safety('Safety', '🛡️'),
  customerService('Customer Service', '🎯');

  final String displayName;
  final String emoji;
  const CourseCategory(this.displayName, this.emoji);
}
