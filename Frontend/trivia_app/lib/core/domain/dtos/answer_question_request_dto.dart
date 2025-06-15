import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer_question_request_dto.g.dart';

@JsonSerializable()
class AnswerQuestionRequestDto extends Equatable {
  final String answer;

  const AnswerQuestionRequestDto({
    required this.answer,
  });

  factory AnswerQuestionRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AnswerQuestionRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerQuestionRequestDtoToJson(this);

  @override
  List<Object?> get props => [answer];
}
