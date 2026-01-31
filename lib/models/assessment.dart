import 'package:equatable/equatable.dart';

class Assessment extends Equatable {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final int totalQuestions;
  final double passingScore;
  final int timeMinutes;
  final List<Question> questions;
  final DateTime createdDate;

  const Assessment({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.totalQuestions,
    required this.passingScore,
    required this.timeMinutes,
    this.questions = const [],
    required this.createdDate,
  });

  @override
  List<Object?> get props => [
    id,
    courseId,
    title,
    description,
    totalQuestions,
    passingScore,
    timeMinutes,
    questions,
    createdDate,
  ];
}

class Question extends Equatable {
  final String id;
  final String assessmentId;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final double points;
  final String questionType; // multiple_choice, true_false, short_answer

  const Question({
    required this.id,
    required this.assessmentId,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.points,
    this.questionType = 'multiple_choice',
  });

  @override
  List<Object?> get props => [
    id,
    assessmentId,
    questionText,
    options,
    correctAnswerIndex,
    points,
    questionType,
  ];
}

class TestResult extends Equatable {
  final String id;
  final String userId;
  final String assessmentId;
  final DateTime attemptDate;
  final double scorePercentage;
  final int correctAnswers;
  final int totalQuestions;
  final int timeSpentSeconds;
  final bool isPassed;
  final List<String> userAnswers;

  const TestResult({
    required this.id,
    required this.userId,
    required this.assessmentId,
    required this.attemptDate,
    required this.scorePercentage,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeSpentSeconds,
    required this.isPassed,
    required this.userAnswers,
  });

  double get accuracy => (correctAnswers / totalQuestions) * 100;

  @override
  List<Object?> get props => [
    id,
    userId,
    assessmentId,
    attemptDate,
    scorePercentage,
    correctAnswers,
    totalQuestions,
    timeSpentSeconds,
    isPassed,
    userAnswers,
  ];
}
