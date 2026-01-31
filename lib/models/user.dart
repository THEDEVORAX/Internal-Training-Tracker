import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? profileImage;
  final String department;
  final String jobTitle;
  final DateTime joinDate;
  final String? phone;
  final List<String> skills;
  final double overallScore;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profileImage,
    required this.department,
    required this.jobTitle,
    required this.joinDate,
    this.phone,
    this.skills = const [],
    this.overallScore = 0.0,
  });

  String get fullName => '$firstName $lastName';

  /// Calculate years since joining
  int get yearsAtCompany {
    return DateTime.now().year - joinDate.year;
  }

  /// Check if user has completed profile
  bool get isProfileComplete {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        phone != null &&
        phone!.isNotEmpty;
  }

  /// Get initials from name
  String get initials =>
      '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}';

  /// Get proficiency level based on score
  String get proficiencyLevel {
    if (overallScore >= 90) return 'Expert';
    if (overallScore >= 75) return 'Advanced';
    if (overallScore >= 60) return 'Intermediate';
    if (overallScore >= 45) return 'Beginner';
    return 'Novice';
  }

  /// Create a copy with modified fields
  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? profileImage,
    String? department,
    String? jobTitle,
    DateTime? joinDate,
    String? phone,
    List<String>? skills,
    double? overallScore,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      department: department ?? this.department,
      jobTitle: jobTitle ?? this.jobTitle,
      joinDate: joinDate ?? this.joinDate,
      phone: phone ?? this.phone,
      skills: skills ?? this.skills,
      overallScore: overallScore ?? this.overallScore,
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'profileImage': profileImage,
    'department': department,
    'jobTitle': jobTitle,
    'joinDate': joinDate.toIso8601String(),
    'phone': phone,
    'skills': skills,
    'overallScore': overallScore,
  };

  /// Create from JSON map
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    profileImage: json['profileImage'] as String?,
    department: json['department'] as String,
    jobTitle: json['jobTitle'] as String,
    joinDate: DateTime.parse(json['joinDate'] as String),
    phone: json['phone'] as String?,
    skills: List<String>.from(json['skills'] as List? ?? []),
    overallScore: (json['overallScore'] as num?)?.toDouble() ?? 0.0,
  );

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    profileImage,
    department,
    jobTitle,
    joinDate,
    phone,
    skills,
    overallScore,
  ];
}
