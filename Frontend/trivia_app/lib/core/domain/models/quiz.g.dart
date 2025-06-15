// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      id: json['id'] as String,
      xpPerQuestion: (json['xpPerQuestion'] as num).toInt(),
      event: json['event'] == null
          ? null
          : LimitedTimeEvent.fromJson(json['event'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'xpPerQuestion': instance.xpPerQuestion,
      'event': instance.event,
    };
