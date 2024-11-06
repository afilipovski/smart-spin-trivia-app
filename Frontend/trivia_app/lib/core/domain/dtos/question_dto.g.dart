// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => QuestionDto(
      id: json['id'] as String,
      content: json['content'] as String,
      categoryId: json['categoryId'] as String,
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => Choice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionDtoToJson(QuestionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'choices': instance.choices,
      'categoryId': instance.categoryId,
    };
