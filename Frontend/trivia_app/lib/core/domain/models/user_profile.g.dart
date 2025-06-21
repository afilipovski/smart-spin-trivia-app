// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      (json['friends'] as List<dynamic>?)
          ?.map((e) => UserProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['streakLastExtended'] == null
          ? null
          : DateTime.parse(json['streakLastExtended'] as String),
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      streak: (json['streak'] as num).toInt(),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'birthDate': instance.birthDate.toIso8601String(),
      'friends': instance.friends,
      'streak': instance.streak,
      'streakLastExtended': instance.streakLastExtended?.toIso8601String(),
    };
