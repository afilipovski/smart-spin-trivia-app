import 'package:trivia_app/core/domain/dtos/create_quiz_session_dto.dart';
import 'package:trivia_app/core/domain/dtos/quiz_dto.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';

class QuizService {
  QuizService();

  final HttpService _client = getIt<HttpService>();

  Future<void> createQuizSession(String quizId) async {
    final createQuizSessionDto = CreateQuizSessionDto(quizId: quizId);
    await _client.post("quiz-session", createQuizSessionDto);
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
          ),
        )
        .toList();
  }
}
