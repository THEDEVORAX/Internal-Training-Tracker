// Localization strings for the Nexus Training Tracker
// This file contains all user-facing strings for the application

const Map<String, Map<String, String>> translations = {
  'en': {
    // App Name & General
    'app_name': 'Nexus Training Tracker',
    'app_tagline': 'Elevating Human Capital Through Data-Driven Learning',

    // Navigation
    'home': 'Home',
    'courses': 'Courses',
    'assessments': 'Assessments',
    'analytics': 'Analytics',
    'certificates': 'Certificates',
    'profile': 'Profile',
    'settings': 'Settings',

    // Dashboard
    'welcome_back': 'Welcome Back!',
    'your_progress': 'Your Progress',
    'courses_completed': 'Courses Completed',
    'certificates_earned': 'Certificates Earned',
    'overall_score': 'Overall Score',
    'skills_mastered': 'Skills Mastered',
    'recent_activities': 'Recent Activities',

    // Courses
    'available_courses': 'Available Courses',
    'search_courses': 'Search courses...',
    'course_details': 'Course Details',
    'enroll': 'Enroll',
    'enrolled': 'Enrolled',
    'start_learning': 'Start Learning',
    'instructor': 'Instructor',
    'duration': 'Duration',
    'difficulty': 'Difficulty',

    // Assessments
    'take_assessment': 'Take Assessment',
    'your_score': 'Your Score',
    'time_remaining': 'Time Remaining',
    'submit_assessment': 'Submit Assessment',
    'assessment_result': 'Assessment Result',
    'passed': 'Passed',
    'failed': 'Failed',

    // Analytics
    'performance_metrics': 'Performance Metrics',
    'completion_rate': 'Completion Rate',
    'avg_score': 'Avg Assessment Score',
    'learning_hours': 'Learning Hours',
    'skill_level': 'Skill Level',
    'skill_dna': 'Skill DNA Profile',
    'personalized_insights': 'Personalized Insights',

    // Certificates
    'digital_certificates': 'Digital Certificates',
    'digital_badges': 'Digital Badges',
    'certificate_number': 'Certificate Number',
    'issue_date': 'Issue Date',
    'expiry_date': 'Expiry Date',
    'active': 'Active',
    'expired': 'Expired',
    'verify_certificate': 'Verify Certificate',

    // Common
    'loading': 'Loading...',
    'error': 'Error',
    'success': 'Success',
    'cancel': 'Cancel',
    'confirm': 'Confirm',
    'save': 'Save',
    'delete': 'Delete',
    'edit': 'Edit',
    'back': 'Back',
    'close': 'Close',
  },
  'ar': {
    // اسم التطبيق والعام
    'app_name': 'متتبع التدريب نيكسس',
    'app_tagline': 'رفع رأس المال البشري من خلال التعلم المبني على البيانات',

    // التنقل
    'home': 'الصفحة الرئيسية',
    'courses': 'الدورات',
    'assessments': 'التقييمات',
    'analytics': 'التحليلات',
    'certificates': 'الشهادات',
    'profile': 'الملف الشخصي',
    'settings': 'الإعدادات',

    // لوحة التحكم
    'welcome_back': 'مرحبا بك!',
    'your_progress': 'تقدمك',
    'courses_completed': 'الدورات المكتملة',
    'certificates_earned': 'الشهادات المكتسبة',
    'overall_score': 'النقاط الإجمالية',
    'skills_mastered': 'المهارات المتقنة',
    'recent_activities': 'الأنشطة الأخيرة',

    // الدورات
    'available_courses': 'الدورات المتاحة',
    'search_courses': 'بحث في الدورات...',
    'course_details': 'تفاصيل الدورة',
    'enroll': 'التحاق',
    'enrolled': 'ملتحق',
    'start_learning': 'ابدأ التعلم',
    'instructor': 'المدرب',
    'duration': 'المدة الزمنية',
    'difficulty': 'مستوى الصعوبة',

    // التقييمات
    'take_assessment': 'خذ التقييم',
    'your_score': 'نقاطك',
    'time_remaining': 'الوقت المتبقي',
    'submit_assessment': 'إرسال التقييم',
    'assessment_result': 'نتيجة التقييم',
    'passed': 'نجح',
    'failed': 'فشل',

    // التحليلات
    'performance_metrics': 'مقاييس الأداء',
    'completion_rate': 'معدل الإنجاز',
    'avg_score': 'متوسط درجة التقييم',
    'learning_hours': 'ساعات التعلم',
    'skill_level': 'مستوى المهارة',
    'skill_dna': 'ملف الحمض النووي للمهارات',
    'personalized_insights': 'رؤى مخصصة',

    // الشهادات
    'digital_certificates': 'الشهادات الرقمية',
    'digital_badges': 'الشارات الرقمية',
    'certificate_number': 'رقم الشهادة',
    'issue_date': 'تاريخ الإصدار',
    'expiry_date': 'تاريخ انتهاء الصلاحية',
    'active': 'نشط',
    'expired': 'انتهت صلاحيته',
    'verify_certificate': 'التحقق من الشهادة',

    // عام
    'loading': 'جاري التحميل...',
    'error': 'خطأ',
    'success': 'نجح',
    'cancel': 'إلغاء',
    'confirm': 'تأكيد',
    'save': 'حفظ',
    'delete': 'حذف',
    'edit': 'تحرير',
    'back': 'رجوع',
    'close': 'إغلاق',
  },
};

class Strings {
  static String of(String key, {String language = 'en'}) {
    return translations[language]?[key] ?? key;
  }
}
