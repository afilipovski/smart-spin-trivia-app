// lib/core/services/quiz_service.dart

import 'dart:convert';
import 'package:trivia_app/core/domain/dtos/answer_question_request_dto.dart';
import 'package:trivia_app/core/domain/dtos/answer_question_response_dto.dart';
import 'package:trivia_app/core/domain/dtos/create_quiz_session_dto.dart';
import 'package:trivia_app/core/domain/dtos/quiz_dto.dart';
import 'package:trivia_app/core/domain/exceptions/http_response_exception.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/domain/models/quiz_session.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';

class QuizService {
  QuizService();

  final HttpService _client = getIt<HttpService>();

  Future<QuizSession> createQuizSession(String quizId) async {
    final dto = CreateQuizSessionDto(quizId: quizId);
      try {
      final response = await _client.post("quiz-session", dto);
      return QuizSession.fromJson(response);
    } on HttpResponseException catch (e) {
      if (e.statusCode == 422) {
        return getQuizSession();
      }
      rethrow;
    }
  }

  Future<QuizSession> getQuizSession() async {
    final response = await _client.get("quiz-session");
    return QuizSession.fromJson(response);
  }

  Future<List<Quiz>> getQuizzes() async {
    final List response = await _client.get("quiz");
    return response
        .map((c) => QuizDto.fromJson(c))
        .map((dto) => Quiz(
              id: dto.id,
              xpPerQuestion: dto.xpPerQuestion,
              event: dto.event,
              category: dto.quizCategory,
              numQuestions: dto.numQuestions,
            ))
        .toList();
  }

  Future<AnswerQuestionResponseDto> answerQuestion(String answer) async {
    final escaped = const HtmlEscape(HtmlEscapeMode.element).convert(answer);
    final dto = AnswerQuestionRequestDto(answer: escaped);
    final result = await _client.post("quiz-session/answer", dto);
    return AnswerQuestionResponseDto.fromJson(result);
  }

  Future<QuizSession> endQuiz() async {
    final now = DateTime.now().toUtc().toIso8601String();
    final response = await _client.post("quiz-session/end?userTime=$now", "");
    return QuizSession.fromJson(response);
  }

  Future<QuizSession> joinQuizSession(String joinCode) async {
    final response = await _client.post("quiz-session/join/$joinCode", "");
    return QuizSession.fromJson(response);
  }

  Future<void> startQuizSession(String joinCode) async {
    await _client.post("quiz-session/start/$joinCode", "");
  }
}
