import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trivia_app/core/domain/models/choice.dart';
import 'package:trivia_app/core/domain/models/question.dart';
import 'package:trivia_app/core/services/category_service.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc(
    CategoryService? categoryService,
  ) : super(QuestionInitial()) {
    _categoryService = categoryService ?? CategoryService();

    on<QuestionsScreenInitialized>(_onQuestionsScreenInitialized);
    on<QuestionNextTapped>(_onQuestionNextTapped);
    on<QuestionChoiceTapped>(_onQuestionChoiceTapped);
  }

  late final CategoryService _categoryService;

  void _onQuestionsScreenInitialized(
    QuestionsScreenInitialized event,
    Emitter<QuestionState> emit,
  ) async {
    emit(QuestionLoadInProgress());

    final randomQuestionsForCategory =
        await _categoryService.getRandomQuestionsForCategory(event.categoryId);

    final newState = QuestionAnswering(
      questions: randomQuestionsForCategory.toList(),
      currentQuestion: randomQuestionsForCategory.first,
      // ignore: prefer_const_literals_to_create_immutables
      choicesMap: <Question, Choice>{},
    );

    emit(newState);
  }

  void _onQuestionNextTapped(
    QuestionNextTapped event,
    Emitter<QuestionState> emit,
  ) {
    if (state is! QuestionAnswering) {
      return;
    }

    final questionLoadedState = state as QuestionAnswering;

    final indexOfCurrentQuestion = questionLoadedState.questions
        .indexOf(questionLoadedState.currentQuestion);
    final isOnLastQuestion =
        indexOfCurrentQuestion == questionLoadedState.questions.length - 1;

    if (isOnLastQuestion) {
      int countAll = questionLoadedState.questions.length;

      int countCorrect = questionLoadedState.choicesMap.values
          .where((val) => val.isCorrect)
          .length;
      double percentPassed = (countCorrect * 1.0) / countAll;
      bool hasPassed = false;

      if (percentPassed > 0.5) {
        hasPassed = true;
      }
      emit(QuestionAnswersFinished(hasPassed: hasPassed));
      return;
    }

    final nextQuestion =
        questionLoadedState.questions[indexOfCurrentQuestion + 1];

    final nextState = QuestionAnswering(
      questions: questionLoadedState.questions,
      currentQuestion: nextQuestion,
      choicesMap: questionLoadedState.choicesMap,
    );

    emit(nextState);
  }

  void _onQuestionChoiceTapped(
    QuestionChoiceTapped event,
    Emitter<QuestionState> emit,
  ) {
    if (state is! QuestionAnswering) {
      return;
    }

    final questionAnswerState = state as QuestionAnswering;

    final choices = questionAnswerState.choicesMap;

    choices[questionAnswerState.currentQuestion] = event.choice;

    final nextState = QuestionAnswering(
      questions: questionAnswerState.questions,
      currentQuestion: questionAnswerState.currentQuestion,
      choicesMap: choices,
    );

    emit(nextState);
  }
}
