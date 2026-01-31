/// Localization helper for managing app languages
class LocalizationHelper {
  static const String defaultLanguage = 'en';
  static const List<String> supportedLanguages = ['en', 'ar'];

  static final Map<String, Map<String, String>> _translations = {
    'en': {
      // Navigation
      'nav_home': 'Home',
      'nav_courses': 'Courses',
      'nav_assessments': 'Assessments',
      'nav_analytics': 'Analytics',
      'nav_certificates': 'Certificates',
      'nav_profile': 'Profile',

      // Common
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'retry': 'Retry',
      'ok': 'OK',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',

      // Status
      'status_active': 'Active',
      'status_completed': 'Completed',
      'status_dropped': 'Dropped',
      'status_pending': 'Pending',

      // Difficulty
      'difficulty_beginner': 'Beginner',
      'difficulty_intermediate': 'Intermediate',
      'difficulty_advanced': 'Advanced',
      'difficulty_expert': 'Expert',

      // Messages
      'msg_no_data': 'No data available',
      'msg_network_error': 'Network error. Please check your connection',
      'msg_server_error': 'Server error. Please try again later',
      'msg_loading_data': 'Loading data...',
    },
    'ar': {
      // Navigation
      'nav_home': 'الصفحة الرئيسية',
      'nav_courses': 'الدورات',
      'nav_assessments': 'التقييمات',
      'nav_analytics': 'التحليلات',
      'nav_certificates': 'الشهادات',
      'nav_profile': 'الملف الشخصي',

      // Common
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'success': 'نجح',
      'retry': 'إعادة محاولة',
      'ok': 'حسناً',
      'cancel': 'إلغاء',
      'save': 'حفظ',
      'delete': 'حذف',
      'edit': 'تحرير',

      // Status
      'status_active': 'نشط',
      'status_completed': 'مكتمل',
      'status_dropped': 'متوقف',
      'status_pending': 'قيد الانتظار',

      // Difficulty
      'difficulty_beginner': 'مبتدئ',
      'difficulty_intermediate': 'متوسط',
      'difficulty_advanced': 'متقدم',
      'difficulty_expert': 'خبير',

      // Messages
      'msg_no_data': 'لا توجد بيانات',
      'msg_network_error': 'خطأ في الشبكة. يرجى التحقق من الاتصال',
      'msg_server_error': 'خطأ في الخادم. يرجى المحاولة لاحقاً',
      'msg_loading_data': 'جاري تحميل البيانات...',
    },
  };

  /// Get translated string by key
  static String get(String key, {String language = defaultLanguage}) {
    return _translations[language]?[key] ?? key;
  }

  /// Check if language is supported
  static bool isSupported(String language) {
    return supportedLanguages.contains(language);
  }

  /// Get all supported languages
  static List<String> getSupportedLanguages() => supportedLanguages;
}
