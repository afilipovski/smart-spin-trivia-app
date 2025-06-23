import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/exceptions/http_response_exception.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/features/quiz/view/multiplayer_lobby_screen.dart';

class JoinSessionScreen extends StatefulWidget {
  final Quiz quiz;

  const JoinSessionScreen({
    super.key,
    required this.quiz,
  });

  @override
  State<JoinSessionScreen> createState() => _JoinSessionScreenState();
}

class _JoinSessionScreenState extends State<JoinSessionScreen> {
  final TextEditingController _controller = TextEditingController();
  final QuizService quizService = getIt<QuizService>();

  Future<void> _joinSession() async {
    final code = _controller.text.trim();

    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a join code")),
      );
      return;
    }

    try {
      await quizService.joinQuizSession(code);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MultiplayerLobbyScreen(
            quiz: widget.quiz,
            joinCode: code,
          ),
        ),
      );
    } on HttpResponseException catch (e) {
      if (!mounted) return;

      if (e.statusCode == 404 || e.statusCode == 422) {
        _showErrorDialog(
          "Oops!",
          "We couldn't find a game with that code. Double-check and try again!",
        );
      } else {
        _showErrorDialog(
          "Error",
          "Something went wrong. Please try again.",
        );
      }
    } catch (_) {
      if (!mounted) return;
      _showErrorDialog(
        "Error",
        "An unexpected error occurred. Please try again.",
      );
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          )
        ],
      ),
    );
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
              onPressed: _joinSession,
              icon: const Icon(Icons.login),
              label: const Text("Join"),
            ),
          ],
        ),
      ),
    );
  }
}
