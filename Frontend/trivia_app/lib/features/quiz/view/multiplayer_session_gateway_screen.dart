// lib/features/quiz/view/multiplayer_session_gateway_screen.dart

import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/domain/models/quiz_session.dart'; // ← Added
import 'package:trivia_app/core/domain/exceptions/http_response_exception.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/features/quiz/view/join_session_screen.dart';
import 'package:trivia_app/features/quiz/view/multiplayer_lobby_screen.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';

class MultiplayerSessionGatewayScreen extends StatelessWidget {
  final Quiz quiz;
  final GradientColor gradientColor;

  const MultiplayerSessionGatewayScreen({
    super.key,
    required this.quiz,
    required this.gradientColor,
  });

  @override
  Widget build(BuildContext context) {
    final service = getIt<QuizService>();

    Future<void> createOrResume() async {
      QuizSession session;
      try {
        session = await service.createQuizSession(quiz.id);
      } on HttpResponseException catch (e) {
        if (e.statusCode == 422) {
          session = await service.getQuizSession();
        } else {
          rethrow;
        }
      }
      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MultiplayerLobbyScreen(
            session: session,
            color: gradientColor,
            isLeader: true,
            currentUserId: session.userProfile!.id,
          ),
        ),
      );
    }

    void goJoin() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => JoinSessionScreen(
            quiz: quiz,
            gradientColor: gradientColor,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Multiplayer")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: createOrResume,
              icon: const Icon(Icons.play_arrow),
              label: const Text("Start a New Session"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: goJoin,
              icon: const Icon(Icons.input),
              label: const Text("Join with a Code"),
            ),
          ],
        ),
      ),
    );
  }
}
