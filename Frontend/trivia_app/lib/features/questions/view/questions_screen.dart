import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/core/domain/models/choice.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/questions/bloc/question_bloc.dart';
import 'package:trivia_app/features/quiz/view/quiz_screen.dart';
import 'package:trivia_app/features/results/view/loser_page.dart';
import 'package:trivia_app/features/results/view/winner_page.dart';

// ignore: must_be_immutable
class QuestionsScreen extends StatefulWidget {
  QuestionsScreen({
    super.key,
    required this.quiz,
    required this.gradientColor,
  });

  final Quiz quiz;
  final GradientColor gradientColor;
  Choice? selectedChoice;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int selectedTileIndex = -1;
  bool hasPassed = true;

  final quizService = getIt<QuizService>();

  @override
  void initState() {
    super.initState();
    context.read<QuestionBloc>().add(
          QuestionsScreenInitialized(quizId: widget.quiz.id),
        );
  }

  void _navigateToResultsPage() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await quizService.endQuiz();
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => hasPassed
                ? const WinnerPage()
                : LoserPage(
                    quiz: widget.quiz,
                    gradientColor: widget.gradientColor,
                  ),
          ),
        );
      },
    );
  }

  Future<void> _handleBackPressed() async {
    await quizService.endQuiz();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B1055),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            await _handleBackPressed();
          },
        ),
      ),
      body: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          if (state is QuestionLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuestionLoadFailed) {
            return const Center(child: Text("Failed to load questions"));
          }

          if (state is QuestionAnswersFinished) {
            _navigateToResultsPage();
          }

          if (state is QuestionAnswering) {
            final question = state.question;
            final choices = question.choices;

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2B1055),
                    Color(0xFF7597DE),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      question.content,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Column(
                      children: List.generate(choices!.length, (index) {
                        final choice = choices[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTileIndex = index;
                              });

                              widget.selectedChoice = choice;

                              context.read<QuestionBloc>().add(
                                    QuestionChoiceTapped(choice: choice),
                                  );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: selectedTileIndex == index
                                    ? Colors.white
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedTileIndex == index
                                          ? Colors.purple
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    choice.content,
                                    style: TextStyle(
                                      color: selectedTileIndex == index
                                          ? Colors.purple
                                          : Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<QuestionBloc>().add(
                                  QuestionNextTapped(
                                      choice: widget.selectedChoice!));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 40.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
