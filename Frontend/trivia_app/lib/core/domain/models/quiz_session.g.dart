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
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      xpCollected: (json['xpCollected'] as num).toInt(),
      joinCode: json['joinCode'] as String?,
      timeActiveQuestionServed: json['timeActiveQuestionServed'] == null
          ? null
          : DateTime.parse(json['timeActiveQuestionServed'] as String),
      numQuestions: (json['numQuestions'] as num).toInt(),
    );

Map<String, dynamic> _$QuizSessionToJson(QuizSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quiz': instance.quiz,
      'userProfile': instance.userProfile,
      'questions': instance.questions,
      'xpCollected': instance.xpCollected,
      'joinCode': instance.joinCode,
      'activeQuestion': instance.activeQuestion,
      'timeActiveQuestionServed':
          instance.timeActiveQuestionServed?.toIso8601String(),
      'numQuestions': instance.numQuestions,
    };
