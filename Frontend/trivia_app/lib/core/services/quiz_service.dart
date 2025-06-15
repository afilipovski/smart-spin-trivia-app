import 'package:trivia_app/core/domain/dtos/create_quiz_session_dto.dart';
import 'package:trivia_app/core/domain/dtos/quiz_dto.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/domain/models/quiz_session.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';

class QuizService {
  QuizService();

  final HttpService _client = getIt<HttpService>();

  Future<QuizSession> createQuizSession(String quizId) async {
    final createQuizSessionDto = CreateQuizSessionDto(quizId: quizId);
    final response = await _client.post("quiz-session", createQuizSessionDto);
    print(response);
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

  Future<void> endQuiz() async {
    final time = DateTime.now().toUtc().toIso8601String();
    await _client.post("quiz-session/end?userTime=$time", "");
  }

}
