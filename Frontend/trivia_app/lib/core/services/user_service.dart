import 'package:trivia_app/core/domain/dtos/streak_dto.dart';
import 'package:trivia_app/core/domain/dtos/user_dto.dart';
import 'package:trivia_app/core/domain/models/user_profile.dart';
import 'package:trivia_app/core/services/auth_service.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/logger_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';

class UserService {
  UserService([HttpService? client]);

  final HttpService _client = getIt<HttpService>();
  final LoggerService loggerService = getIt<LoggerService>();
  final AuthService authService = getIt<AuthService>();

  Future<UserProfile?> getUserProfile() async {
    final user = authService.getCurrentUser();

    if(user == null){
      return null;
    }
    final path = "user-profile/${user.uid}"; 
    final response = await _client.get(path);
    return UserProfile.fromJson(response);
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

  Future<StreakDto> getStreak() async {
    final time = DateTime.now().toUtc().toIso8601String();
    final response = await _client.get("user-profile/streak?userTime=$time",);
    return StreakDto.fromJson(response);
  }
}
