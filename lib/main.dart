import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/index.dart';

/// The entry point of the Nexus Training Tracker application.
void main() {
  // Ensure Flutter bindings are initialized before any plugin usage
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const NexusApp());
}

/// [NexusApp] is the root widget of the application.
/// It configures the global theme, routing, and localization.
class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus Training Tracker',

      // Global Theme Configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          ThemeMode.system, // Automatically switches based on OS settings

      // Entry Point Screen
      home: const MainScreen(),

      // Hide the debug banner for a cleaner look
      debugShowCheckedModeBanner: false,
    );
  }
}
