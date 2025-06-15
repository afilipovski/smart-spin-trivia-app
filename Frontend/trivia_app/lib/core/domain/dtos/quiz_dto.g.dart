// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizDto _$QuizDtoFromJson(Map<String, dynamic> json) => QuizDto(
      (json['xpPerQuestion'] as num).toInt(),
      json['event'] == null
          ? null
          : LimitedTimeEvent.fromJson(json['event'] as Map<String, dynamic>),
      json['quizCategory'] == null
          ? null
          : Category.fromJson(json['quizCategory'] as Map<String, dynamic>),
      id: json['id'] as String,
    );

Map<String, dynamic> _$QuizDtoToJson(QuizDto instance) => <String, dynamic>{
      'id': instance.id,
      'xpPerQuestion': instance.xpPerQuestion,
      'quizCategory': instance.quizCategory,
      'event': instance.event,
    };
