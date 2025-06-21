import 'package:trivia_app/core/domain/models/user_friendship.dart';
import 'package:trivia_app/core/domain/models/user_profile.dart';
import 'package:trivia_app/core/services/auth_service.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/logger_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';

class UserFriendshipService {
  UserFriendshipService([HttpService? client]);

  final HttpService _client = getIt<HttpService>();
  final LoggerService loggerService = getIt<LoggerService>();
  final AuthService authService = getIt<AuthService>();

  Future<List<UserProfile>> getListOfUsers(String searchQuery) async {
    final response = await _client.get('user-profile?fullName=$searchQuery') as List<dynamic>;
    return response
        .map((json) => UserProfile.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<UserFriendship> sendFriendRequest(String otherUserId) async {
    final response = await _client.post('user-friendship/request/$otherUserId', '');
    return UserFriendship.fromJson(response);
  }

   Future<List<UserFriendship>> getAllFriendRequests() async {
    final response = await _client.get('user-friendship/requests',);
    return response.map((json) => UserFriendship.fromJson(json)).toList();
  }
}
