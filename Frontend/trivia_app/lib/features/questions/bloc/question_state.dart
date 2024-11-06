part of 'question_bloc.dart';

sealed class QuestionState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class QuestionInitial extends QuestionState {}

final class QuestionAnswering extends QuestionState {
  QuestionAnswering({
    required this.questions,
    required this.currentQuestion,
    required this.choicesMap,
  });

  final List<Question> questions;
  final Question currentQuestion;
  final Map<Question, Choice> choicesMap;

  @override
  List<Object?> get props =>
      [...questions.map((q) => q.id), currentQuestion.id, choicesMap];
}

class QuestionAnswersFinished extends QuestionState {
  QuestionAnswersFinished({required this.hasPassed});

  final bool hasPassed;

  @override
  List<Object?> get props => [hasPassed];
}

final class QuestionLoadFailed extends QuestionState {}

final class QuestionLoadInProgress extends QuestionState {}
