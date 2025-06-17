import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/questions/bloc/question_bloc.dart';
import 'package:trivia_app/features/quiz/view/quiz_screen.dart';
import 'package:trivia_app/features/results/view/loser_page.dart';

class QuestionsScreen extends StatelessWidget {
  final Quiz quiz;
  final GradientColor gradientColor;

  const QuestionsScreen({
    super.key,
    required this.quiz,
    required this.gradientColor,
  });

  void _navigateToResultsPage(BuildContext context, int xpCollected) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WinnerPage(
            quiz: quiz,
            gradientColor: gradientColor,
            xpCollected: xpCollected,
          ),
        ),
      );
    });
  }

  void _handleBackPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionBloc>().add(QuestionsScreenInitialized(quizId: quiz.id));
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B1055),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => _handleBackPressed(context),
        ),
      ),
      body: BlocConsumer<QuestionBloc, QuestionState>(
        listener: (context, state) {
          if (state is QuestionAnswersFinished) {
            _navigateToResultsPage(context, state.xpCollected);
          }
        },
        builder: (context, state) {
          if (state is QuestionLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuestionLoadFailed) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuestionAnswering) {
            final question = state.question;
            final selectedChoice = state.selectedChoice; 

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2B1055), Color(0xFF7597DE)],
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
                      children: List.generate(question.choices!.length, (index) {
                        final choice = question.choices![index];
                        final isSelected = state.selectedIndex == index;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              context.read<QuestionBloc>().add(
                                QuestionChoiceTapped(choice: choice,),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: isSelected ? Colors.white : Colors.transparent,
                                border: Border.all(color: Colors.white, width: 2.0),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected ? Colors.purple : Colors.transparent,
                                      border: Border.all(color: Colors.white, width: 2.0),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    choice.content,
                                    style: TextStyle(
                                      color: isSelected ? Colors.purple : Colors.white,
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
                            onPressed: selectedChoice != null
                                ? () {
                                    context.read<QuestionBloc>().add(
                                          QuestionNextTapped(choice: selectedChoice),
                                        );
                                  }
                                : null,
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
