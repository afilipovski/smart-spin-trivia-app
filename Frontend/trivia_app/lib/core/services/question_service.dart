import 'package:trivia_app/core/domain/models/question.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/models.dart';

class QuestionService {
  QuestionService([HttpService? client]) {
    _client = client ?? HttpService();
  }

  late final HttpService _client;

  Future<List<Question>> getQuestions() async {
    final List response = await _client.get("questions");
    return response.map((q) => Question.fromJson(q)).toList();
  }

  Future<Question> getQuestion(String id) async {
    final response = await _client.get("questions/$id");
    return Question.fromJson(response);
  }

  Future<void> postQuestion(Object requestBody) async {
    await _client.post("questions", requestBody);
  }

  Future<void> putQuestion(Object requestBody) async {
    await _client.put("questions", requestBody);
  }

  Future<void> deleteQuestion(String id) async {
    await _client.delete("questions/$id");
  }
}
