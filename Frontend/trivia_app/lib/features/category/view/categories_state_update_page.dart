import 'package:flutter/material.dart';

class CategoriesStateUpdatePage extends StatelessWidget {
  const CategoriesStateUpdatePage(
      {super.key,
      required this.emojiToBeDisplayed,
      required this.messageToBeDisplayed});
  final String emojiToBeDisplayed;
  final String messageToBeDisplayed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 200,
        ),
        Text(
          emojiToBeDisplayed,
          style: const TextStyle(fontSize: 64),
        ),
        Text(
          messageToBeDisplayed,
          style: theme.textTheme.headlineSmall,
        ),
      ],
    );
  }
}
