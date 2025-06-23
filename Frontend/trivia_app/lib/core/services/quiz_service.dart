import 'package:trivia_app/core/domain/dtos/answer_question_request_dto.dart';
import 'package:trivia_app/core/domain/dtos/answer_question_response_dto.dart';
import 'package:trivia_app/core/domain/dtos/create_quiz_session_dto.dart';
import 'package:trivia_app/core/domain/dtos/quiz_dto.dart';
import 'package:trivia_app/core/domain/exceptions/user_is_not_multiplayer_quiz_leader_exception.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/domain/models/quiz_session.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/logger_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'dart:convert';

class QuizService {
  QuizService();

  final HttpService _client = getIt<HttpService>();
  final LoggerService _loggerService = getIt<LoggerService>();

  Future<QuizSession> createQuizSession(String quizId) async {
    final createQuizSessionDto = CreateQuizSessionDto(quizId: quizId);
    final response = await _client.post("quiz-session", createQuizSessionDto);
    return QuizSession.fromJson(response);
  }

  Future<List<Quiz>> getQuizzes() async {
    final List response = await _client.get("quiz");
    return response
        .map((c) => QuizDto.fromJson(c))
        .map(
          (dto) => Quiz(
            id: dto.id,
            xpPerQuestion: dto.xpPerQuestion,
            event: dto.event,
            category: dto.quizCategory,
            numQuestions: dto.numQuestions,
          ),
        )
        .toList();
  }

  Future<AnswerQuestionResponseDto> answerQuestion(String answer) async {
    final escapedAnswer =
        const HtmlEscape(HtmlEscapeMode.element).convert(answer);
    final dto = AnswerQuestionRequestDto(answer: escapedAnswer);
    final result = await _client.post("quiz-session/answer", dto);

    return AnswerQuestionResponseDto.fromJson(result);
  }

  Future<QuizSession> endQuiz() async {
    final time = DateTime.now().toUtc().toIso8601String();
    final response = await _client.post("quiz-session/end?userTime=$time", "");
    return QuizSession.fromJson(response);
  }

  Future<QuizSession> joinQuizSession(String joinCode) async {
    final response = await _client.post("quiz-session/join/$joinCode", "");
    return QuizSession.fromJson(response);
  }

  Future<void> startQuizSession(String joinCode) async {
    try {
      await _client.post("quiz-session/start/$joinCode", "");
    } on UserIsNotMultiplayerQuizLeaderException catch (e) {
      _loggerService.logError('$e');
    } on Exception catch (e) {
      _loggerService.logError('$e');
    }
    return;
  }
}
