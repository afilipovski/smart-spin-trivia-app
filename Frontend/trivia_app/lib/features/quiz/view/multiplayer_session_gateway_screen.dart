import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/quiz/view/join_session_screen.dart';
import 'package:trivia_app/features/quiz/view/multiplayer_lobby_screen.dart';

class MultiplayerSessionGatewayScreen extends StatelessWidget {
  final Quiz quiz;

  MultiplayerSessionGatewayScreen({
    super.key,
    required this.quiz,
  });

  final QuizService quizService = getIt<QuizService>();

  Future<void> _createSession(BuildContext context) async {
    final session = await quizService.createQuizSession(quiz.id);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MultiplayerLobbyScreen(
          quiz: quiz,
          joinCode: session.joinCode ?? '',
        ),
      ),
    );
  }

  void _goToJoinScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => JoinSessionScreen(
          joinCode: '',
          quiz: quiz,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Multiplayer")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _createSession(context),
              icon: const Icon(Icons.play_arrow),
              label: const Text("Start a New Session"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _goToJoinScreen(context),
              icon: const Icon(Icons.input),
              label: const Text("Join with a Code"),
            ),
          ],
        ),
      ),
    );
  }
}
