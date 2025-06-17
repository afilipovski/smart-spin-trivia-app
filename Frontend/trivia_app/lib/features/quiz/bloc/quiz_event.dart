import 'package:equatable/equatable.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';

sealed class QuizEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuizSelected extends QuizEvent {
  QuizSelected(this.quiz, this.gradientColor);
  final Quiz quiz;
  final GradientColor gradientColor;

  @override
  List<Object?> get props => [quiz.id];
}

class QuizInitialLoad extends QuizEvent {
  QuizInitialLoad();
}
