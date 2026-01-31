/// App constants for the entire application
class AppConstants {
  // API
  static const int requestTimeout = 30;
  static const int maxRetries = 3;
  static const int cacheExpireDuration = 5; // minutes

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 100;

  // Assessment
  static const int minPassingScore = 70;
  static const int maxQuestionTime = 5; // minutes per question
  static const int minTestDuration = 15; // minutes

  // Course
  static const int minCourseRating = 1;
  static const int maxCourseRating = 5;
  static const int minEnrollmentForPopular = 100;
  static const double minRatingForWellRated = 4.5;

  // User
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // Skills
  static const double expertLevel = 90.0;
  static const double advancedLevel = 75.0;
  static const double intermediateLevel = 50.0;
  static const double beginnerLevel = 0.0;

  // Enrollment Status
  static const String statusActive = 'active';
  static const String statusCompleted = 'completed';
  static const String statusDropped = 'dropped';

  // Question Types
  static const String typeMultipleChoice = 'multiple_choice';
  static const String typeTrueFalse = 'true_false';
  static const String typeShortAnswer = 'short_answer';

  // Difficulty Levels
  static const String difficultyBeginner = 'Beginner';
  static const String difficultyIntermediate = 'Intermediate';
  static const String difficultyAdvanced = 'Advanced';
  static const String difficultyExpert = 'Expert';

  // Date formats
  static const String dateFormatPattern = 'MMM dd, yyyy';
  static const String dateTimeFormatPattern = 'MMM dd, yyyy - hh:mm a';
  static const String timeFormatPattern = 'hh:mm a';

  // Asset paths
  static const String imagesPath = 'assets/images/';
  static const String iconsPath = 'assets/icons/';

  // Network
  static const String contentTypeJson = 'application/json';
  static const String headerAuthorization = 'Authorization';
  static const String bearerPrefix = 'Bearer ';
}
