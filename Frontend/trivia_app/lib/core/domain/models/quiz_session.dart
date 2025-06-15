import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trivia_app/core/domain/models/question.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/domain/models/user_profile.dart';

part 'quiz_session.g.dart';

@JsonSerializable()
class QuizSession extends Equatable {
  final String id;
  final Quiz quiz;
  final UserProfile? userProfile;
  final List<Question>? questions;
  final int xpCollected;
  final String? joinCode;
  final Question? activeQuestion;
  final DateTime? timeActiveQuestionServed;
  final int numQuestions;

  const QuizSession(
    this.userProfile,
    this.activeQuestion, {
    required this.id,
    required this.quiz,
    required this.questions,
    required this.xpCollected,
    required this.joinCode,
    required this.timeActiveQuestionServed,
    required this.numQuestions,
  });

  factory QuizSession.fromJson(Map<String, dynamic> json) =>
      _$QuizSessionFromJson(json);

  Map<String, dynamic> toJson() => _$QuizSessionToJson(this);

  @override
  List<Object?> get props => [id];
}
