import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
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

  LinearGradient get _backgroundGradient {
    switch (gradientColor) {
      case GradientColor.pink:
        return const LinearGradient(
            colors: [Color(0xFFF48FB1), Color(0xFFF8BBD0)]);
      case GradientColor.purple:
        return const LinearGradient(
            colors: [Color(0xFF7E57C2), Color(0xFFCE93D8)]);
      case GradientColor.blue:
        return const LinearGradient(
            colors: [Color(0xFF42A5F5), Color(0xFF90CAF9)]);
      case GradientColor.ocean:
        return const LinearGradient(
            colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)]);
      case GradientColor.sunset:
        return const LinearGradient(
            colors: [Color(0xFFFF8A65), Color(0xFFFFB74D)]);
      case GradientColor.teal:
        return const LinearGradient(
            colors: [Color(0xFF26A69A), Color(0xFF80CBC4)]);
      case GradientColor.other:
      default:
        return const LinearGradient(
            colors: [Color(0xFF90A4AE), Color(0xFFCFD8DC)]);
    }
  }

  void _navigateToResultsPage(BuildContext context, int xp) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => WinnerPage(
            quiz: quiz,
            gradientColor: gradientColor,
            xpCollected: xp,
          ),
        ),
      );
    });
  }

  void _goBack(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) =>  QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // trigger loading
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionBloc>().add(
            QuestionsScreenInitialized(quizId: quiz.id),
          );
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => _goBack(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(gradient: _backgroundGradient),
        child: Stack(
          children: [
            // Decorative bubbles
            Positioned(
              top: 100,
              left: 40,
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              right: 20,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white12,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Main content
            BlocConsumer<QuestionBloc, QuestionState>(
              listener: (ctx, state) {
                if (state is QuestionAnswersFinished) {
                  _navigateToResultsPage(ctx, state.xpCollected);
                }
              },
              builder: (ctx, state) {
                if (state is QuestionLoadInProgress ||
                    state is QuestionLoadFailed) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is QuestionAnswering) {
                  final unescape = HtmlUnescape();
                  final qText = unescape.convert(state.question.content);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 120),
                        // Question card
                        Card(
                          color: Colors.white.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              qText,
                              style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Choices list
                        ...List.generate(state.question.choices!.length, (i) {
                          final choice = state.question.choices![i];
                          final selected = state.selectedIndex == i;
                          final cText = unescape.convert(choice.content);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ElevatedButton(
                              onPressed: () => ctx.read<QuestionBloc>().add(
                                    QuestionChoiceTapped(choice: choice),
                                  ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    selected ? Colors.white : Colors.white24,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 16),
                                side: const BorderSide(
                                    color: Colors.white, width: 2),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    selected
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    color: selected
                                        ? gradientColor == GradientColor.blue
                                            ? Colors.blueAccent
                                            : Colors.purpleAccent
                                        : Colors.white,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      cText,
                                      style: GoogleFonts.nunito(
                                        textStyle: TextStyle(
                                          color: selected
                                              ? Colors.black87
                                              : Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),

                        const Spacer(),

                        // Next button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state.selectedChoice != null
                                ? () => ctx.read<QuestionBloc>().add(
                                      QuestionNextTapped(
                                          choice: state.selectedChoice!),
                                    )
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'NEXT',
                              style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
