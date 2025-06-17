import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trivia_app/core/domain/exceptions/http_response_exception.dart';
import 'package:trivia_app/core/domain/models/choice.dart';
import 'package:trivia_app/core/domain/models/question.dart';
import 'package:trivia_app/core/services/logger_service.dart';
import 'package:trivia_app/core/services/question_service.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc() : super(QuestionInitial()) {
    on<QuestionsScreenInitialized>(_onQuestionsScreenInitialized);
    on<QuestionNextTapped>(_onQuestionNextTapped);
    on<QuestionChoiceTapped>(_onQuestionChoiceTapped);
  }

  final QuizService quizService = getIt<QuizService>();
  final QuestionService questionService = getIt<QuestionService>();
  final LoggerService loggerService = getIt<LoggerService>();

 void _onQuestionsScreenInitialized(
  QuestionsScreenInitialized event,
  Emitter<QuestionState> emit,
) async {
  emit(QuestionLoadInProgress());

  try {
    await quizService.endQuiz(); 
  } catch (e) {
    if (e is HttpResponseException && e.statusCode == 404) {
    } else {
      loggerService.logError("Unexpected error while ending quiz: $e");
    }
  }

  try {
    final session = await quizService.createQuizSession(event.quizId);
    final totalQuestions = session.numQuestions;

    final randomQuestion = await questionService.getRandomQuestion();

    emit(QuestionAnswering(
      question: randomQuestion,
      choicesMap: const <Question, Choice>{},
      currentQuestionIndex: 1,
      totalQuestions: totalQuestions,
    ));
  } catch (e) {
    emit(QuestionLoadFailed());
  }
}

  void _onQuestionNextTapped(
    QuestionNextTapped event,
    Emitter<QuestionState> emit,
  ) async {
    final currentState = state;
    if (currentState is! QuestionAnswering) return;

    if(event.choice != null){
      await quizService.answerQuestion(event.choice!.content);
    }

    if (currentState.currentQuestionIndex >= currentState.totalQuestions) {
      await quizService.endQuiz();
      emit(QuestionAnswersFinished()); 
      return;
    }

    try {
      final nextQuestion = await questionService.getRandomQuestion();
      
      emit(QuestionAnswering(
        question: nextQuestion,
        choicesMap: currentState.choicesMap,
        currentQuestionIndex: currentState.currentQuestionIndex + 1,
        totalQuestions: currentState.totalQuestions,
      ));
    } catch (e) {
      emit(QuestionLoadFailed());
    }
  }

  void _onQuestionChoiceTapped(
    QuestionChoiceTapped event,
    Emitter<QuestionState> emit,
  ) async
   {
    final currentState = state;
    if (currentState is! QuestionAnswering) return;

    final updatedChoices = Map<Question, Choice>.from(currentState.choicesMap);
    updatedChoices[currentState.question] = event.choice;

    final selectedIndex = currentState.question.choices?.indexOf(event.choice);

    emit(QuestionAnswering(
      question: currentState.question,
      choicesMap: updatedChoices,
      currentQuestionIndex: currentState.currentQuestionIndex,
      totalQuestions: currentState.totalQuestions,
      selectedChoice: event.choice,
      selectedIndex: selectedIndex,
    ));
  }
}
