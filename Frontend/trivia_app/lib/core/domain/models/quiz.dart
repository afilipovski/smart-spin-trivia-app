import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trivia_app/core/domain/models/category.dart';
import 'package:trivia_app/core/domain/models/limited_time_event.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz extends Equatable {
  final String id;
  final Category? category;
  final int xpPerQuestion;
  final LimitedTimeEvent? event;
  final int numQuestions;

  const Quiz({
    required this.id,
    required this.xpPerQuestion,
    required this.numQuestions,
    this.event,
    this.category,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  Map<String, dynamic> toJson() => _$QuizToJson(this);

  @override
  List<Object?> get props => [id];
}
