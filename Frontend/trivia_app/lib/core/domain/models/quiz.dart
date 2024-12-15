import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trivia_app/core/domain/models/category.dart';
import 'package:trivia_app/core/domain/models/limited_time_event.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz extends Equatable {
  final String id;
  final String categoryId;
  final Category? category;
  final int xpPerQuestion;
  final LimitedTimeEvent event;

  const Quiz({
    required this.id,
    required this.categoryId,
    required this.category,
    required this.xpPerQuestion,
    required this.event,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  Map<String, dynamic> toJson() => _$QuizToJson(this);

  @override
  List<Object?> get props => [id];
}
