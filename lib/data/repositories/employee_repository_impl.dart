import '../../domain/entities/entities.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasources/dummy_data_factory.dart';

/// Implementation of EmployeeRepository using dummy data
class EmployeeRepositoryImpl implements EmployeeRepository {
  late final List<Employee> _employees;
  late final Employee _sampleEmployee;

  EmployeeRepositoryImpl() {
    _sampleEmployee = DummyDataFactory.generateSampleEmployee();
    _employees = [_sampleEmployee, ...DummyDataFactory.generateEmployees(9)];
  }

  @override
  Future<Employee?> getEmployeeById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network
    try {
      return _employees.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Employee>> getAllEmployees() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _employees;
  }

  @override
  Future<List<Employee>> getEmployeesByDepartment(String department) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _employees.where((e) => e.department == department).toList();
  }

  @override
  Future<List<Employee>> searchEmployees(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final lowerQuery = query.toLowerCase();
    return _employees
        .where(
          (e) =>
              e.name.toLowerCase().contains(lowerQuery) ||
              e.email.toLowerCase().contains(lowerQuery) ||
              e.department.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  /// Get the sample employee for demo
  Future<Employee> getSampleEmployee() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _sampleEmployee;
  }
}
