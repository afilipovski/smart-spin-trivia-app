import 'package:flutter/material.dart';
import 'constants.dart';

class TextBannerWidget extends StatelessWidget {
  final String text;
  final Color baseTextColor;
  final Color shadowTextColor;
  final double fontSize;

  const TextBannerWidget({
    required this.text,
    required this.baseTextColor,
    required this.shadowTextColor,
    this.fontSize = ResultUIConstants.messageFontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (double i = 0; i < 10; i++)
          Positioned(
            top: i,
            left: i,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: baseTextColor.withValues(alpha: 0.01 * (10 - i),),
                decoration: TextDecoration.none,
              ),
            ),
          ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: shadowTextColor,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
