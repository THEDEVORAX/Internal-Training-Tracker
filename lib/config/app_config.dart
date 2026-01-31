class AppConfig {
  static const String appName = 'Nexus Training Tracker';
  static const String appVersion = '1.0.0';
  static const String tagline =
      'Elevating Human Capital Through Data-Driven Learning';

  // API Configuration
  static const String apiBaseUrl = 'https://api.nexustraining.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Firebase Configuration
  static const String firebaseProjectId = 'nexus-training-tracker';

  // Local Storage Keys
  static const String keyAuthToken = 'auth_token';
  static const String keyUser = 'user_data';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';

  // Feature Flags
  static const bool enableAnalytics = true;
  static const bool enableOfflineMode = true;
  static const bool enableBiometricAuth = true;
}
