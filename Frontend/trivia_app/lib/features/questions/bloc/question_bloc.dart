import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trivia_app/core/domain/models/choice.dart';
import 'package:trivia_app/core/domain/models/question.dart';
import 'package:trivia_app/core/services/category_service.dart';
import 'package:trivia_app/core/services/question_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc() : super(QuestionInitial()) {
    on<QuestionsScreenInitialized>(_onQuestionsScreenInitialized);
    on<QuestionNextTapped>(_onQuestionNextTapped);
    on<QuestionChoiceTapped>(_onQuestionChoiceTapped);
  }

  final CategoryService categoryService = getIt<CategoryService>();
  final QuestionService questionService = getIt<QuestionService>();

  void _onQuestionsScreenInitialized(
    QuestionsScreenInitialized event,
    Emitter<QuestionState> emit,
  ) async {
    emit(QuestionLoadInProgress());

    try {
      await questionService.createQuizSession();

      final randomQuestion = await questionService.getRandomQuestion();

      emit(QuestionAnswering(
        question: randomQuestion,
        choicesMap: const <Question, Choice>{},
      ));
    } catch (e) {
      emit(QuestionLoadFailed());
    }
  }

  void _onQuestionNextTapped(
    QuestionNextTapped event,
    Emitter<QuestionState> emit,
  ) async {
    if (state is! QuestionAnswering) return;

    final questionLoadedState = state as QuestionAnswering;

    // Decide whether to continue or finish quiz (here we just finish after 1 question for example)
    final hasPassed = true;

    // If quiz is over:
    emit(QuestionAnswersFinished(hasPassed: hasPassed));
    // Otherwise, remove the above emit and return, and load next question below.

    /*
    try {
      final randomQuestion = await questionService.getRandomQuestion();

      emit(QuestionAnswering(
        question: randomQuestion,
        choicesMap: questionLoadedState.choicesMap,
      ));
    } catch (e) {
      emit(QuestionLoadFailure(error: e.toString()));
    }
    */
  }

  void _onQuestionChoiceTapped(
    QuestionChoiceTapped event,
    Emitter<QuestionState> emit,
  ) {
    if (state is! QuestionAnswering) return;

    final questionAnswerState = state as QuestionAnswering;

    final newChoices = Map<Question, Choice>.from(questionAnswerState.choicesMap);
    newChoices[questionAnswerState.question] = event.choice;

    emit(QuestionAnswering(
      question: questionAnswerState.question,
      choicesMap: newChoices,
    ));
  }
}
