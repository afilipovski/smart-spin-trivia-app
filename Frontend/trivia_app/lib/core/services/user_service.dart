import 'package:trivia_app/core/domain/dtos/user_dto.dart';
import 'package:trivia_app/core/domain/models/question.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/logger_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/models.dart';

class UserService {
  UserService([HttpService? client]);

  final HttpService _client = getIt<HttpService>();
  final LoggerService loggerService = getIt<LoggerService>();

  Future<List<Question>> getUserProfile() async {
    final List response = await _client.get("");
    return response.map((q) => Question.fromJson(q)).toList();
  }

  Future<void> registerUser({
    required String fullName,
    required DateTime birthDate,
  }) async {
    try {
      await _client.post(
        "user-profile/register",
        UserDto(fullName: fullName, birthDate: birthDate),
      );
    } on Exception catch (e) {
      loggerService.logError('$e');
    }
  }
}
