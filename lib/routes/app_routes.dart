class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';

  // Learning Management
  static const String courses = '/courses';
  static const String courseDetails = '/courses/:id';
  static const String enroll = '/courses/:id/enroll';

  // Performance & Assessment
  static const String assessments = '/assessments';
  static const String assessment = '/assessments/:id';
  static const String testResults = '/test-results';

  // Analytics & Reporting
  static const String analytics = '/analytics';
  static const String skills = '/skills';

  // Digital Credentialing
  static const String certificates = '/certificates';
  static const String certificateDetails = '/certificates/:id';

  // Profile
  static const String profile = '/profile';
  static const String settings = '/settings';
}
