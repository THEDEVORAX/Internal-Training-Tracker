import '../entities/entities.dart';

/// Repository interface for Employee data access
abstract interface class EmployeeRepository {
  /// Get employee by ID
  Future<Employee?> getEmployeeById(String id);

  /// Get all employees
  Future<List<Employee>> getAllEmployees();

  /// Get employees by department
  Future<List<Employee>> getEmployeesByDepartment(String department);

  /// Search employees by name
  Future<List<Employee>> searchEmployees(String query);
}
