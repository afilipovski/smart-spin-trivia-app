import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';

enum QuizStatus { initial, loading, success, failure }

@immutable
sealed class QuizState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class QuizInitial extends QuizState {}

final class QuizLoadFailed extends QuizState {}

final class QuizLoadInProgress extends QuizState {}

final class QuizLoadSuccess extends QuizState {
  QuizLoadSuccess(this.quizzes);

  final List<Quiz> quizzes;

  @override
  List<Object?> get props => [quizzes];
}

final class QuizCardSelected extends QuizState {
  QuizCardSelected(this.quiz, this.color);

  final Quiz quiz;
  final GradientColor color;

  @override
  List<Object?> get props => [quiz.id, color];
}
