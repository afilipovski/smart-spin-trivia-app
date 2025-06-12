import 'package:trivia_app/core/domain/models/question.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/models.dart';

class UserService {
  UserService([HttpService? client]) {
    _client = client ?? HttpService();
  }

  late final HttpService _client;

  Future<List<Question>> getUserProfile() async {
    final List response = await _client.get("");
    return response.map((q) => Question.fromJson(q)).toList();
  }

  Future<void> registerUser(Object requestBody) async {
    await _client.post("user-profile/register", requestBody);
  }

  Future<void> loginUser(Object requestBody) async {
    await _client.post("user-profile/login", requestBody);
  }
}
