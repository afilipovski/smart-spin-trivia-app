import 'package:get_it/get_it.dart';
import 'package:trivia_app/core/services/category_service.dart';
import 'package:trivia_app/core/services/choice_service.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/logger_service.dart';
import 'package:trivia_app/core/services/question_service.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/user_friendship_service.dart';
import 'package:trivia_app/core/services/user_service.dart';
import 'package:trivia_app/core/services/auth_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => UserService());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => LoggerService());
  getIt.registerLazySingleton(() => HttpService());
  getIt.registerLazySingleton(() => QuestionService());
  getIt.registerLazySingleton(() => CategoryService());
  getIt.registerLazySingleton(() => ChoiceService());
  getIt.registerLazySingleton(() => QuizService());
  getIt.registerLazySingleton(() => UserFriendshipService());
}
