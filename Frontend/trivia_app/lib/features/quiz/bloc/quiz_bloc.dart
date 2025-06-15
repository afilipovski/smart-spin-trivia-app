import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trivia_app/core/services/logger_service.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/features/quiz/bloc/quiz_event.dart';
import 'package:trivia_app/features/quiz/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<QuizInitialLoad>(_onQuizInitialLoad);
    on<QuizSelected>(_onQuizSelect);
  }

  final QuizService quizService = getIt<QuizService>();
  final LoggerService loggerService = getIt<LoggerService>();

  Future<void> _onQuizInitialLoad(
    QuizInitialLoad event,
    Emitter<QuizState> emit,
  ) async {
    try {
      emit(QuizLoadInProgress());
      final categories = await quizService.getQuizzes();
      if (categories.isEmpty) {
        emit(QuizLoadFailed());
      } else {
        emit(QuizLoadSuccess(categories));
      }
    } on Exception catch (e) {
      loggerService.logError('$e');
      emit(QuizLoadFailed());
    } on Error {
      emit(QuizLoadFailed());
    }
  }

  void _onQuizSelect(
    QuizSelected event,
    Emitter<QuizState> emit,
  ) async {
    emit(QuizCardSelected(event.quiz, event.gradientColor));
  }
}
