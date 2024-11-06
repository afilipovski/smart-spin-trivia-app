import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/core/domain/models/category.dart';
import 'package:trivia_app/features/category/view/category_screen.dart';
import 'package:trivia_app/features/questions/bloc/question_bloc.dart';
import 'package:trivia_app/features/questions/constants/app_colors.dart';
import 'package:trivia_app/features/questions/view/choice_tile.dart';
import 'package:trivia_app/features/results/view/loser_page.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/results/view/winner_page.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.category,
    required this.gradientColor,
  });
  final Category category;
  final GradientColor gradientColor;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int selectedTileIndex = -1;
  int currentQuestionIndex = -1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuestionBloc>(context).add(
      QuestionsScreenInitialized(categoryId: widget.category.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        flexibleSpace: Container(),
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        title: Text(
          widget.category.name,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const CategoryScreen(),
              ),
            );
          },
        ),
      ),
      body: BlocConsumer<QuestionBloc, QuestionState>(
        builder: (context, state) {
          if (state is QuestionAnswering) {
            currentQuestionIndex =
                state.questions.indexOf(state.currentQuestion);
          }
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.gradientColors,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is QuestionLoadInProgress)
                  const LinearProgressIndicator(),
                if (state is QuestionAnswering)
                  LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / state.questions.length,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                const SizedBox(height: 20),
                if (state is QuestionAnswering)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 20,
                        ).copyWith(bottom: 20),
                        child: Text(
                          'Question ${currentQuestionIndex + 1} of ${state.questions.length}',
                          style: const TextStyle(
                            color: AppColors.mainPurpleShade,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8.0),
                if (state is QuestionAnswering)
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          state.currentQuestion.content,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: state.currentQuestion.choices?.map(
                                (choice) {
                                  int choiceIndex = state
                                      .currentQuestion.choices!
                                      .indexOf(choice);
                                  return ChoiceTile(
                                    option: choice.content,
                                    isSelected:
                                        selectedTileIndex == choiceIndex,
                                    onTap: () {
                                      context.read<QuestionBloc>().add(
                                            QuestionChoiceTapped(
                                                choice: choice),
                                          );
                                      setState(() {
                                        selectedTileIndex = choiceIndex;
                                      });
                                    },
                                  );
                                },
                              ).toList() ??
                              [],
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 80.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedTileIndex = -1;
                        });
                        context.read<QuestionBloc>().add(QuestionNextTapped());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 16.0,
                        ),
                        backgroundColor: AppColors.backgroundColor,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              color: AppColors.mainPurpleShade,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.mainPurpleShade,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        listener: (
          BuildContext context,
          QuestionState state,
        ) {
          if (state is QuestionAnswersFinished) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return state.hasPassed
                      ? const WinnerPage()
                      : LoserPage(
                          category: widget.category,
                          gradientColor: widget.gradientColor,
                        );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
