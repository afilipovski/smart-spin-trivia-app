import 'package:trivia_app/core/domain/models/question.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/models.dart';

class QuestionService {
  QuestionService([HttpService? client]) {
    _client = client ?? HttpService();
  }

  late final HttpService _client;

  Future<Question> getRandomQuestion() async {
    final response = await _client.post("quiz-question/random", "");
    return Question.fromJson(response);
  }
}
