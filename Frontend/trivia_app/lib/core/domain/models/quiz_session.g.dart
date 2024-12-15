// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizSession _$QuizSessionFromJson(Map<String, dynamic> json) => QuizSession(
      json['userProfile'] == null
          ? null
          : UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
      json['activeQuestion'] == null
          ? null
          : Question.fromJson(json['activeQuestion'] as Map<String, dynamic>),
      id: json['id'] as String,
      quiz: Quiz.fromJson(json['quiz'] as Map<String, dynamic>),
      userProfileId: json['userProfileId'] as String,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      xpCollected: (json['xpCollected'] as num).toInt(),
      joinCode: json['joinCode'] as String,
      activeQuestionId: json['activeQuestionId'] as String,
      timeActiveQuestionServed:
          DateTime.parse(json['timeActiveQuestionServed'] as String),
    );

Map<String, dynamic> _$QuizSessionToJson(QuizSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quiz': instance.quiz,
      'userProfileId': instance.userProfileId,
      'userProfile': instance.userProfile,
      'questions': instance.questions,
      'xpCollected': instance.xpCollected,
      'joinCode': instance.joinCode,
      'activeQuestionId': instance.activeQuestionId,
      'activeQuestion': instance.activeQuestion,
      'timeActiveQuestionServed':
          instance.timeActiveQuestionServed.toIso8601String(),
    };
