import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/questions/bloc/question_bloc.dart';
import 'package:trivia_app/features/questions/view/questions_screen.dart';
import 'package:trivia_app/features/quiz/view/quiz_screen.dart';
import 'package:trivia_app/features/results/constants/colors.dart';
import 'package:trivia_app/features/results/constants/constants.dart';
import 'package:trivia_app/features/results/constants/result_banner_widget.dart';
import 'package:trivia_app/features/results/constants/results_button_widget.dart';

class LoserPage extends StatefulWidget {
  final Quiz quiz;
  final GradientColor gradientColor;

  const LoserPage({
    super.key,
    required this.quiz,
    required this.gradientColor,
  });

  @override
  State<LoserPage> createState() => _LoserPagePageState();
}

class _LoserPagePageState extends State<LoserPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Transform.translate(
      offset: const Offset(
        ResultUIConstants.totalScreenOffset,
        0,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Lottie.asset(
            fit: BoxFit.cover,
            alignment: Alignment.center,
            'assets/sad_emoji_animation.json',
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration *
                    ResultUIConstants.animationDurationLength
                ..repeat();
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              screenHeight * ResultUIConstants.paddingForInteractiveElements,
              0,
              0,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight *
                      ResultUIConstants.sizedBoxAboveMainMessageRatio,
                ),
                TextBannerWidget(
                  text: 'You win some!\nYou lose some!',
                  baseTextColor: ResultUiColors.resultMessageTextColor,
                  shadowTextColor: ResultUiColors.resultMessageShadowColor,
                ),
                const SizedBox(
                  height: ResultUIConstants.sizedBoxBetweenWidgetsAndMessage,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ResultsButtonWidget(
                      text: 'Try again',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => QuestionBloc(),
                              child: QuestionsScreen(
                                quiz: widget.quiz,
                                gradientColor:  widget.gradientColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ResultsButtonWidget(
                      text: 'Categories',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
