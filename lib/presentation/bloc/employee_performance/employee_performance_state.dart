import 'package:equatable/equatable.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/services/training_analytics_service.dart';

/// Sealed class representing employee performance states using Dart 3.0+ features
sealed class EmployeePerformanceState extends Equatable {
  const EmployeePerformanceState();

  @override
  List<Object?> get props => [];
}

/// Initial/loading state
final class EmployeePerformanceLoading extends EmployeePerformanceState {
  const EmployeePerformanceLoading();
}

/// Success state with employee data and analytics
final class EmployeePerformanceSuccess extends EmployeePerformanceState {
  final Employee employee;
  final EmployeeAnalytics analytics;
  final int? selectedSkillIndex;

  const EmployeePerformanceSuccess({
    required this.employee,
    required this.analytics,
    this.selectedSkillIndex,
  });

  EmployeePerformanceSuccess copyWith({
    Employee? employee,
    EmployeeAnalytics? analytics,
    int? selectedSkillIndex,
  }) {
    return EmployeePerformanceSuccess(
      employee: employee ?? this.employee,
      analytics: analytics ?? this.analytics,
      selectedSkillIndex: selectedSkillIndex ?? this.selectedSkillIndex,
    );
  }

  @override
  List<Object?> get props => [employee, analytics, selectedSkillIndex];
}

/// Empty state when no employee data
final class EmployeePerformanceEmpty extends EmployeePerformanceState {
  const EmployeePerformanceEmpty();
}

/// Error state with message
final class EmployeePerformanceError extends EmployeePerformanceState {
  final String message;
  final String? code;

  const EmployeePerformanceError({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}
