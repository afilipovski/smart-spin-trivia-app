import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer_question_response_dto.g.dart';

@JsonSerializable()
class AnswerQuestionResponseDto extends Equatable {
  final int xpGain;
  final String status;

  const AnswerQuestionResponseDto({
    required this.xpGain,
    required this.status,
  });

  factory AnswerQuestionResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AnswerQuestionResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerQuestionResponseDtoToJson(this);

  @override
  List<Object?> get props => [xpGain, status];
}
