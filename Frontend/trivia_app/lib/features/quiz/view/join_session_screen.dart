// lib/features/quiz/view/join_session_screen.dart

import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/exceptions/http_response_exception.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/features/quiz/view/multiplayer_lobby_screen.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';

class JoinSessionScreen extends StatefulWidget {
  final Quiz quiz;
  final GradientColor gradientColor;

  const JoinSessionScreen({
    super.key,
    required this.quiz,
    required this.gradientColor,
  });

  @override
  State<JoinSessionScreen> createState() => _JoinSessionScreenState();
}

class _JoinSessionScreenState extends State<JoinSessionScreen> {
  final _controller = TextEditingController();
  final _service = getIt<QuizService>();

  Future<void> _join() async {
    final code = _controller.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a join code")),
      );
      return;
    }
    try {
      final session = await _service.joinQuizSession(code);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MultiplayerLobbyScreen(
            session: session,
            color: widget.gradientColor,
            isLeader: false,
            currentUserId: session.userProfile!.id,
          ),
        ),
      );
    } on HttpResponseException catch (e) {
      final msg = (e.statusCode == 404 || e.statusCode == 422)
          ? "We couldn't find a game with that code."
          : "Something went wrong. Try again.";
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Oops!"),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join a Game")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter the join code your friend sent you"),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Join Code",
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _join,
              icon: const Icon(Icons.login),
              label: const Text("Join"),
            ),
          ],
        ),
      ),
    );
  }
}
