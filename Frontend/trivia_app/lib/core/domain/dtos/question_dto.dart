import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trivia_app/core/domain/models/choice.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto extends Equatable {
  final String id;
  final String content;
  final List<Choice>? choices;
  final String categoryId;

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);

  const QuestionDto({
    required this.id,
    required this.content,
    required this.categoryId,
    required this.choices,
  });

  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);

  @override
  List<Object?> get props => [id];
}
