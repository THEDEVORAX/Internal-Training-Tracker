import 'package:equatable/equatable.dart';

/// Events for the EmployeePerformance BLoC
sealed class EmployeePerformanceEvent extends Equatable {
  const EmployeePerformanceEvent();

  @override
  List<Object?> get props => [];
}

/// Load employee performance data
final class LoadEmployeePerformance extends EmployeePerformanceEvent {
  final String? employeeId;

  const LoadEmployeePerformance({this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}

/// Refresh employee performance data
final class RefreshEmployeePerformance extends EmployeePerformanceEvent {
  const RefreshEmployeePerformance();
}

/// Select a skill on the radar chart
final class SelectSkill extends EmployeePerformanceEvent {
  final int? skillIndex;

  const SelectSkill({this.skillIndex});

  @override
  List<Object?> get props => [skillIndex];
}
