// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoiceDto _$ChoiceDtoFromJson(Map<String, dynamic> json) => ChoiceDto(
      id: json['id'] as String,
      content: json['content'] as String,
      isCorrect: json['isCorrect'] as bool,
    );

Map<String, dynamic> _$ChoiceDtoToJson(ChoiceDto instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isCorrect': instance.isCorrect,
    };
