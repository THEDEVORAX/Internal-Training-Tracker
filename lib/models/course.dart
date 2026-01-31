import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String category;
  final int durationMinutes;
  final double rating;
  final int enrollmentCount;
  final String? thumbnail;
  final DateTime createdDate;
  final List<String> skills;
  final String difficulty;
  final bool isActive;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.category,
    required this.durationMinutes,
    this.rating = 0.0,
    this.enrollmentCount = 0,
    this.thumbnail,
    required this.createdDate,
    this.skills = const [],
    this.difficulty = 'Intermediate',
    this.isActive = true,
  });

  /// Get display rating (0-5 with 1 decimal)
  String get displayRating => '${rating.toStringAsFixed(1)}/5';

  /// Get duration in hours and minutes
  String get displayDuration {
    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;
    if (hours > 0) {
      return '$hours${minutes > 0 ? ' hr $minutes' : ' hr'}';
    }
    return '$minutes min';
  }

  /// Check if course is popular (100+ enrollments)
  bool get isPopular => enrollmentCount >= 100;

  /// Check if course is well-rated (4.5+)
  bool get isWellRated => rating >= 4.5;

  /// Get difficulty emoji
  String get difficultyEmoji {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return '🟢';
      case 'intermediate':
        return '🟡';
      case 'advanced':
        return '🔴';
      default:
        return '⚪';
    }
  }

  /// Create a copy with modified fields
  Course copyWith({
    String? id,
    String? title,
    String? description,
    String? instructor,
    String? category,
    int? durationMinutes,
    double? rating,
    int? enrollmentCount,
    String? thumbnail,
    DateTime? createdDate,
    List<String>? skills,
    String? difficulty,
    bool? isActive,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      category: category ?? this.category,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      rating: rating ?? this.rating,
      enrollmentCount: enrollmentCount ?? this.enrollmentCount,
      thumbnail: thumbnail ?? this.thumbnail,
      createdDate: createdDate ?? this.createdDate,
      skills: skills ?? this.skills,
      difficulty: difficulty ?? this.difficulty,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'instructor': instructor,
    'category': category,
    'durationMinutes': durationMinutes,
    'rating': rating,
    'enrollmentCount': enrollmentCount,
    'thumbnail': thumbnail,
    'createdDate': createdDate.toIso8601String(),
    'skills': skills,
    'difficulty': difficulty,
    'isActive': isActive,
  };

  /// Create from JSON
  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    instructor: json['instructor'] as String,
    category: json['category'] as String,
    durationMinutes: json['durationMinutes'] as int,
    rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    enrollmentCount: json['enrollmentCount'] as int? ?? 0,
    thumbnail: json['thumbnail'] as String?,
    createdDate: DateTime.parse(json['createdDate'] as String),
    skills: List<String>.from(json['skills'] as List? ?? []),
    difficulty: json['difficulty'] as String? ?? 'Intermediate',
    isActive: json['isActive'] as bool? ?? true,
  );

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    instructor,
    category,
    durationMinutes,
    rating,
    enrollmentCount,
    thumbnail,
    createdDate,
    skills,
    difficulty,
    isActive,
  ];
}

class Enrollment extends Equatable {
  final String id;
  final String userId;
  final String courseId;
  final DateTime enrollDate;
  final DateTime? completionDate;
  final double progressPercentage;
  final String status; // active, completed, dropped
  final double score;

  const Enrollment({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.enrollDate,
    this.completionDate,
    this.progressPercentage = 0.0,
    this.status = 'active',
    this.score = 0.0,
  });

  bool get isCompleted => status == 'completed';
  bool get isActive => status == 'active';
  bool get isDropped => status == 'dropped';

  /// Get completion status emoji
  String get statusEmoji {
    switch (status) {
      case 'completed':
        return '✅';
      case 'active':
        return '🔄';
      case 'dropped':
        return '❌';
      default:
        return '⏳';
    }
  }

  /// Get estimated completion date
  DateTime? get estimatedCompletionDate {
    if (isCompleted || progressPercentage >= 100) return completionDate;
    if (progressPercentage == 0) return null;

    final daysSinceEnroll = DateTime.now().difference(enrollDate).inDays;
    final daysPerPercent = daysSinceEnroll / progressPercentage;
    final daysRemaining = daysPerPercent * (100 - progressPercentage);

    return DateTime.now().add(Duration(days: daysRemaining.toInt()));
  }

  /// Create a copy with modified fields
  Enrollment copyWith({
    String? id,
    String? userId,
    String? courseId,
    DateTime? enrollDate,
    DateTime? completionDate,
    double? progressPercentage,
    String? status,
    double? score,
  }) {
    return Enrollment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      enrollDate: enrollDate ?? this.enrollDate,
      completionDate: completionDate ?? this.completionDate,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      status: status ?? this.status,
      score: score ?? this.score,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'courseId': courseId,
    'enrollDate': enrollDate.toIso8601String(),
    'completionDate': completionDate?.toIso8601String(),
    'progressPercentage': progressPercentage,
    'status': status,
    'score': score,
  };

  /// Create from JSON
  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
    id: json['id'] as String,
    userId: json['userId'] as String,
    courseId: json['courseId'] as String,
    enrollDate: DateTime.parse(json['enrollDate'] as String),
    completionDate: json['completionDate'] != null
        ? DateTime.parse(json['completionDate'] as String)
        : null,
    progressPercentage: (json['progressPercentage'] as num?)?.toDouble() ?? 0.0,
    status: json['status'] as String? ?? 'active',
    score: (json['score'] as num?)?.toDouble() ?? 0.0,
  );

  @override
  List<Object?> get props => [
    id,
    userId,
    courseId,
    enrollDate,
    completionDate,
    progressPercentage,
    status,
    score,
  ];
}
