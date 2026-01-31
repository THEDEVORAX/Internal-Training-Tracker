import 'package:equatable/equatable.dart';

class SkillDNA extends Equatable {
  final String userId;
  final List<SkillProfile> skills;
  final double overallProficiency;
  final DateTime lastUpdated;

  const SkillDNA({
    required this.userId,
    required this.skills,
    required this.overallProficiency,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [userId, skills, overallProficiency, lastUpdated];
}

class SkillProfile extends Equatable {
  final String skillId;
  final String skillName;
  final String category;
  final double proficiencyScore; // 0-100
  final String level; // Beginner, Intermediate, Advanced, Expert
  final int coursesCompleted;
  final double averageScore;
  final DateTime lastAssessmentDate;
  final List<String> relatedCertificates;

  const SkillProfile({
    required this.skillId,
    required this.skillName,
    required this.category,
    required this.proficiencyScore,
    this.level = 'Beginner',
    this.coursesCompleted = 0,
    this.averageScore = 0.0,
    required this.lastAssessmentDate,
    this.relatedCertificates = const [],
  });

  String get getLevel {
    if (proficiencyScore >= 90) return 'Expert';
    if (proficiencyScore >= 75) return 'Advanced';
    if (proficiencyScore >= 50) return 'Intermediate';
    return 'Beginner';
  }

  @override
  List<Object?> get props => [
    skillId,
    skillName,
    category,
    proficiencyScore,
    level,
    coursesCompleted,
    averageScore,
    lastAssessmentDate,
    relatedCertificates,
  ];
}

class AnalyticsReport extends Equatable {
  final String userId;
  final int totalCoursesEnrolled;
  final int completedCourses;
  final double completionRate;
  final double averageAssessmentScore;
  final int certificatesEarned;
  final List<SkillProfile> topSkills;
  final DateTime generatedDate;
  final String insights;

  const AnalyticsReport({
    required this.userId,
    required this.totalCoursesEnrolled,
    required this.completedCourses,
    required this.completionRate,
    required this.averageAssessmentScore,
    required this.certificatesEarned,
    required this.topSkills,
    required this.generatedDate,
    required this.insights,
  });

  @override
  List<Object?> get props => [
    userId,
    totalCoursesEnrolled,
    completedCourses,
    completionRate,
    averageAssessmentScore,
    certificatesEarned,
    topSkills,
    generatedDate,
    insights,
  ];
}
