import 'package:get_it/get_it.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/logger_service.dart';
import 'package:trivia_app/core/services/user_service.dart';
import 'package:trivia_app/core/services/auth_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => UserService());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => LoggerService());
  getIt.registerLazySingleton(() => HttpService());
}
