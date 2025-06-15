import 'package:trivia_app/core/domain/dtos/create_quiz_session_dto.dart';
import 'package:trivia_app/core/domain/models/question.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/models.dart';

class QuestionService {
  QuestionService([HttpService? client]) {
    _client = client ?? HttpService();
  }

  late final HttpService _client;

  // Future<List<Question>> getQuestions() async {
  //   final List response = await _client.get("questions");
  //   return response.map((q) => Question.fromJson(q)).toList();
  // }

  Future<Question> getRandomQuestion() async {
    final response = await _client.get("quiz-question/random");
    return Question.fromJson(response);
  }

  Future<void> createQuizSession() async {
    CreateQuizSessionDto createQuizSessionDto = CreateQuizSessionDto(quizId: '823d4940-9d3c-4e57-bd3a-4d1b45bcb6c6');
    await _client.post("quiz-session", createQuizSessionDto);
  }

  // Future<void> putQuestion(Object requestBody) async {
  //   await _client.put("questions", requestBody);
  // }

  // Future<void> deleteQuestion(String id) async {
  //   await _client.delete("questions/$id");
  // }
}
