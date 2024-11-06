import 'package:flutter/material.dart';
import 'package:trivia_app/features/results/constants/colors.dart';

class ResultsButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ResultsButtonWidget({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ResultUiColors.buttonBackgroundColor,
        shadowColor: ResultUiColors.buttonShadowColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: ResultUiColors.buttonTextColor,
        ),
      ),
    );
  }
}
