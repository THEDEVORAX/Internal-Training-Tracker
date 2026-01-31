import 'package:equatable/equatable.dart';

class Certificate extends Equatable {
  final String id;
  final String userId;
  final String courseId;
  final String title;
  final String certificateNumber;
  final DateTime issuedDate;
  final DateTime? expiryDate;
  final String issuer;
  final String? certificateUrl;
  final bool isVerified;
  final List<String> skills;

  const Certificate({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.title,
    required this.certificateNumber,
    required this.issuedDate,
    this.expiryDate,
    required this.issuer,
    this.certificateUrl,
    this.isVerified = true,
    this.skills = const [],
  });

  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }

  bool get isValid => isVerified && !isExpired;

  @override
  List<Object?> get props => [
    id,
    userId,
    courseId,
    title,
    certificateNumber,
    issuedDate,
    expiryDate,
    issuer,
    certificateUrl,
    isVerified,
    skills,
  ];
}

class DigitalBadge extends Equatable {
  final String id;
  final String userId;
  final String badgeType;
  final String title;
  final String description;
  final String? badgeIcon;
  final DateTime earnedDate;
  final String criteria;

  const DigitalBadge({
    required this.id,
    required this.userId,
    required this.badgeType,
    required this.title,
    required this.description,
    this.badgeIcon,
    required this.earnedDate,
    required this.criteria,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    badgeType,
    title,
    description,
    badgeIcon,
    earnedDate,
    criteria,
  ];
}
