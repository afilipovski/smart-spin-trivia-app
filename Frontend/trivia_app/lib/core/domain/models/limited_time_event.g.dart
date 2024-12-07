// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'limited_time_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LimitedTimeEvent _$LimitedTimeEventFromJson(Map<String, dynamic> json) =>
    LimitedTimeEvent(
      id: json['id'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$LimitedTimeEventToJson(LimitedTimeEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
    };
