import 'package:equatable/equatable.dart';

/// Assessment entity representing a completed assessment within a module
final class Assessment extends Equatable {
  final String id;
  final String title;
  final double score;
  final double maxScore;
  final DateTime completionDate;
  final AssessmentType type;

  const Assessment({
    required this.id,
    required this.title,
    required this.score,
    required this.maxScore,
    required this.completionDate,
    required this.type,
  });

  double get percentage => maxScore > 0 ? (score / maxScore) * 100 : 0;

  bool get isPassed => percentage >= 70;

  @override
  List<Object?> get props => [id, title, score, maxScore, completionDate, type];
}

/// Assessment type classification
enum AssessmentType {
  quiz('Quiz'),
  practicalExam('Practical Exam'),
  project('Project'),
  peerReview('Peer Review'),
  certification('Certification');

  final String displayName;
  const AssessmentType(this.displayName);
}
