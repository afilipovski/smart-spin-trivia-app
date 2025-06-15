// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_question_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerQuestionResponseDto _$AnswerQuestionResponseDtoFromJson(
        Map<String, dynamic> json) =>
    AnswerQuestionResponseDto(
      xpGain: (json['xpGain'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$AnswerQuestionResponseDtoToJson(
        AnswerQuestionResponseDto instance) =>
    <String, dynamic>{
      'xpGain': instance.xpGain,
      'status': instance.status,
    };
