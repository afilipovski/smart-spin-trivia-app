import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trivia_app/core/domain/models/choice.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  final String id;
  final String content;
  final List<Choice>? choices;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  const Question({
    required this.id,
    required this.content,
    required this.choices,
  });

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  List<Object?> get props => [id];
}
