import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_app/core/domain/dtos/streak_dto.dart';
import 'package:trivia_app/core/services/auth_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/core/services/user_service.dart';
import 'package:trivia_app/features/authentication/view/login_screen.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/questions/view/questions_screen.dart';
import 'package:trivia_app/features/quiz/bloc/quiz_bloc.dart';
import 'package:trivia_app/features/quiz/bloc/quiz_event.dart';
import 'package:trivia_app/features/quiz/bloc/quiz_state.dart';
import '../../user_profile/view/user_profile_screen.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({super.key});

  final AuthService authService = getIt<AuthService>();
  final UserService userService = getIt<UserService>();

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  StreakDto? streak;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<QuizBloc>(context).add(
      QuizInitialLoad(),
    );

    _getUserStreak();
  }

  Future<void> _getUserStreak() async {
    final streakDto = await widget.userService.getStreak();
    setState(() {
      streak = streakDto;
    });
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout_outlined, color: Colors.black),
          onPressed: () {
            widget.authService.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<QuizBloc, QuizState>(
        buildWhen: (previous, current) => previous is! QuizLoadSuccess,
        builder: (BuildContext context, QuizState state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            '🔥 ${streak?.streak}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: streak?.shouldReset == true
                                  ? Colors.red
                                  : Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'day streak',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Let\'s play',
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 220, 63, 144),
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state is QuizLoadSuccess)
                      Column(
                        children: state.quizzes.map(
                          (quiz) {
                            final GradientColor color =
                                GradientColor.values[random.nextInt(
                              GradientColor.values.length,
                            )];
                            return ColoredCard(
                              isFinished: true,
                              categoryName: quiz.category?.name ?? "",
                              color: GradientColor.values[
                                  random.nextInt(GradientColor.values.length)],
                              onSelectTap: () {
                                BlocProvider.of<QuizBloc>(context).add(
                                  QuizSelected(quiz, color),
                                );
                              },
                            );
                          },
                        ).toList(),
                      )
                    // else if (state is QuizLoadFailed)
                    //   const QuizStateUpdatePage(
                    //     emojiToBeDisplayed: '😭',
                    //     messageToBeDisplayed: 'Something went wrong!',
                    //   )
                    // else if (state is QuizLoadInProgress)
                    //   const QuizStateUpdatePage(
                    //     emojiToBeDisplayed: '🛸',
                    //     messageToBeDisplayed: 'Loading Categories...',
                    //   ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, QuizState state) {
          if (state is QuizCardSelected) {
            BlocProvider.of<QuizBloc>(context).add(
              QuizSelected(state.quiz, state.color),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuestionsScreen(
                  quiz: state.quiz,
                  gradientColor: state.color,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
