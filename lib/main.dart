import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/index.dart';
import 'injection_container.dart' as di;
import 'providers/app_provider.dart';
import 'providers/course_provider.dart';
import 'providers/assessment_provider.dart';

/// The entry point of the Nexus Training Tracker application.
void main() async {
  // Ensure Flutter bindings are initialized before any plugin usage
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dependency Injection
  await di.init();

  runApp(const NexusApp());
}

/// [NexusApp] is the root widget of the application.
/// It configures global state, theme, and routing.
class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<AppProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<CourseProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<AssessmentProvider>()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
