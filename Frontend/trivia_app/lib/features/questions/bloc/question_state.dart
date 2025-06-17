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
    required this.currentQuestionIndex,
    required this.totalQuestions,
    this.selectedChoice,
    this.selectedIndex,
  });

  final Question question;
  final Map<Question, Choice> choicesMap;
  final int currentQuestionIndex;
  final int totalQuestions;
  final Choice? selectedChoice;
  final int? selectedIndex;

  @override
  List<Object?> get props =>
      [question.id, choicesMap, currentQuestionIndex, totalQuestions];
}

class QuestionAnswersFinished extends QuestionState {
  QuestionAnswersFinished({
    required this.xpCollected,
  });

  final int xpCollected;

  @override
  List<Object?> get props => [];
}

final class QuestionLoadFailed extends QuestionState {}

final class QuestionLoadInProgress extends QuestionState {}
