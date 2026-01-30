import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/employee_performance_screen.dart';

void main() {
  runApp(const InternalTrainingTrackerApp());
}

/// Main application widget for Internal Training Tracker
class InternalTrainingTrackerApp extends StatefulWidget {
  const InternalTrainingTrackerApp({super.key});

  @override
  State<InternalTrainingTrackerApp> createState() =>
      _InternalTrainingTrackerAppState();
}

class _InternalTrainingTrackerAppState
    extends State<InternalTrainingTrackerApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internal Training Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: Scaffold(
        body: const EmployeePerformanceScreen(),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleTheme,
          tooltip: 'Toggle Theme',
          child: Icon(
            _themeMode == ThemeMode.dark
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
          ),
        ),
      ),
    );
  }
}
