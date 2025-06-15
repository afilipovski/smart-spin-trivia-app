import 'package:trivia_app/core/domain/dtos/quiz_dto.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/models.dart';

class QuizService {
  QuizService();

  final HttpService _client = getIt<HttpService>();

  Future<List<Quiz>> getQuizzes() async {
    // final List response = await _client.get("quiz");
    // return response
    //     .map((c) => QuizDto.fromJson(c))
    //     .map((dto) => Quiz(id: dto.id, name: dto.name))
    //     .toList();
    return Future.value();
  }
}
