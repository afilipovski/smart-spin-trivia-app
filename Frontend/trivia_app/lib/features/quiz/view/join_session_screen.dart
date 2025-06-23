import 'package:flutter/material.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/features/quiz/view/lobby_screen.dart';

class JoinSessionScreen extends StatefulWidget {
  final String userId;

  const JoinSessionScreen({super.key, required this.userId});

  @override
  State<JoinSessionScreen> createState() => _JoinSessionScreenState();
}

class _JoinSessionScreenState extends State<JoinSessionScreen> {
  final _controller = TextEditingController();
  final QuizService quizService = getIt<QuizService>();
  bool _loading = false;

  Future<void> _joinSession() async {
    setState(() => _loading = true);
    final code = _controller.text.trim();

    final success = await quizService.joinQuizSession(code); 

    if (true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MultiplayerLobbyScreen(
            joinCode: code,
            currentUserId: widget.userId,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to join session")),
      );
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join a Session")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Enter Join Code"),
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _joinSession,
                    child: const Text("Join"),
                  ),
          ],
        ),
      ),
    );
  }
}
