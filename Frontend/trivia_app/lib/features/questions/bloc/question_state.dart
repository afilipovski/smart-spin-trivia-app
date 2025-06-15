part of 'question_bloc.dart';

sealed class QuestionState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class QuestionInitial extends QuestionState {}

final class QuestionAnswering extends QuestionState {
  QuestionAnswering({
    required this.question,
    required this.choicesMap,
  });

  final Question question;
  final Map<Question, Choice> choicesMap;

  @override
  List<Object?> get props =>
      [question.id, choicesMap];
}

class QuestionAnswersFinished extends QuestionState {
  QuestionAnswersFinished({required this.hasPassed});

  final bool hasPassed;

  @override
  List<Object?> get props => [hasPassed];
}

final class QuestionLoadFailed extends QuestionState {}

final class QuestionLoadInProgress extends QuestionState {}
