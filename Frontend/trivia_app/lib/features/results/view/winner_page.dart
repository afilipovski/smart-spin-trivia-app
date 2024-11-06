import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trivia_app/features/category/view/category_screen.dart';
import 'package:trivia_app/features/results/constants/colors.dart';
import 'package:trivia_app/features/results/constants/constants.dart';
import 'package:trivia_app/features/results/constants/result_banner_widget.dart';
import 'package:trivia_app/features/results/constants/results_button_widget.dart';

class WinnerPage extends StatefulWidget {
  const WinnerPage({super.key});

  @override
  State<WinnerPage> createState() => _AnimationControlPageState();
}

class _AnimationControlPageState extends State<WinnerPage>
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
    return Container(
      color: ResultUiColors.containerColor,
      child: Transform.translate(
        offset: const Offset(ResultUIConstants.totalScreenOffset, 0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Transform(
              alignment: FractionalOffset.center,
              transform:
                  Matrix4(-2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 2)
                    ..rotateY(-180),
              child: Transform.translate(
                offset: const Offset(-170, -110),
                child: Lottie.asset(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  'assets/confetti_animation.json',
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..repeat();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: ResultUIConstants.sizedBoxAboveWinnerMessage,
                  ),
                  TextBannerWidget(
                    text: 'Huzzah!',
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
                        text: 'Categories',
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const CategoryScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
