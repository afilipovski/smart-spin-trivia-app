// lib/features/quiz/view/game_mode_selection_screen.dart

import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/questions/view/questions_screen.dart';
import 'package:trivia_app/features/quiz/view/multiplayer_session_gateway_screen.dart';

class GameModeSelectionScreen extends StatelessWidget {
  final Quiz quiz;
  final GradientColor gradientColor;

  const GameModeSelectionScreen({
    super.key,
    required this.quiz,
    required this.gradientColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Game Mode"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuestionsScreen(
                      quiz: quiz,
                      gradientColor: gradientColor,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text("Single Player"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MultiplayerSessionGatewayScreen(
                      quiz: quiz,
                      gradientColor: gradientColor,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.people),
              label: const Text("Multiplayer"),
            ),
          ],
        ),
      ),
    );
  }
}
