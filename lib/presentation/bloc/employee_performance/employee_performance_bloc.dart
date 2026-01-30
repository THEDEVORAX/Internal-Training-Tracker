import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/employee_repository_impl.dart';
import '../../../domain/services/training_analytics_service.dart';
import 'employee_performance_event.dart';
import 'employee_performance_state.dart';

/// BLoC for managing employee performance analytics
class EmployeePerformanceBloc
    extends Bloc<EmployeePerformanceEvent, EmployeePerformanceState> {
  final EmployeeRepositoryImpl _repository;
  final TrainingAnalyticsService _analyticsService;

  EmployeePerformanceBloc({
    EmployeeRepositoryImpl? repository,
    TrainingAnalyticsService? analyticsService,
  }) : _repository = repository ?? EmployeeRepositoryImpl(),
       _analyticsService = analyticsService ?? TrainingAnalyticsService(),
       super(const EmployeePerformanceLoading()) {
    on<LoadEmployeePerformance>(_onLoadPerformance);
    on<RefreshEmployeePerformance>(_onRefreshPerformance);
    on<SelectSkill>(_onSelectSkill);
  }

  Future<void> _onLoadPerformance(
    LoadEmployeePerformance event,
    Emitter<EmployeePerformanceState> emit,
  ) async {
    emit(const EmployeePerformanceLoading());

    try {
      final employee = event.employeeId != null
          ? await _repository.getEmployeeById(event.employeeId!)
          : await _repository.getSampleEmployee();

      if (employee == null) {
        emit(const EmployeePerformanceEmpty());
        return;
      }

      final analytics = _analyticsService.generateEmployeeAnalytics(employee);

      emit(
        EmployeePerformanceSuccess(employee: employee, analytics: analytics),
      );
    } catch (e) {
      emit(
        EmployeePerformanceError(
          message: 'Failed to load employee performance data',
          code: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefreshPerformance(
    RefreshEmployeePerformance event,
    Emitter<EmployeePerformanceState> emit,
  ) async {
    final currentState = state;
    if (currentState is EmployeePerformanceSuccess) {
      add(LoadEmployeePerformance(employeeId: currentState.employee.id));
    } else {
      add(const LoadEmployeePerformance());
    }
  }

  void _onSelectSkill(
    SelectSkill event,
    Emitter<EmployeePerformanceState> emit,
  ) {
    final currentState = state;
    if (currentState is EmployeePerformanceSuccess) {
      emit(currentState.copyWith(selectedSkillIndex: event.skillIndex));
    }
  }
}
