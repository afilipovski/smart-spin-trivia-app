part of 'question_bloc.dart';

sealed class QuestionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionNextTapped extends QuestionEvent {
  QuestionNextTapped({required this.choice});

  final Choice? choice;

  @override
  List<Object?> get props => [choice?.id];
}

class QuestionChoiceTapped extends QuestionEvent {
  QuestionChoiceTapped({required this.choice});
  final Choice choice;

  @override
  List<Object?> get props => [choice.id];
}

class QuestionsScreenInitialized extends QuestionEvent {
  QuestionsScreenInitialized({required this.quizId});
  final String quizId;
}
