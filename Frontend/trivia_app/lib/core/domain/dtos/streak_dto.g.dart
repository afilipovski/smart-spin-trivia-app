// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreakDto _$StreakDtoFromJson(Map<String, dynamic> json) => StreakDto(
      json['streakLastExtended'] == null
          ? null
          : DateTime.parse(json['streakLastExtended'] as String),
      streak: (json['streak'] as num).toInt(),
      shouldReset: json['shouldReset'] as bool,
    );

Map<String, dynamic> _$StreakDtoToJson(StreakDto instance) => <String, dynamic>{
      'streak': instance.streak,
      'streakLastExtended': instance.streakLastExtended?.toIso8601String(),
      'shouldReset': instance.shouldReset,
    };
