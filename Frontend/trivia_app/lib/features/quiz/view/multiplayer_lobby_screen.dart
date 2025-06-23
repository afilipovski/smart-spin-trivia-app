import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/services/auth_service.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';

class MultiplayerLobbyScreen extends StatefulWidget {
  final String joinCode;
  final Quiz quiz;

  const MultiplayerLobbyScreen({
    super.key,
    required this.joinCode,
    required this.quiz,
  });

  @override
  State<MultiplayerLobbyScreen> createState() => _MultiplayerLobbyScreenState();
}

class _MultiplayerLobbyScreenState extends State<MultiplayerLobbyScreen> {
  late final DatabaseReference sessionRef;
  late final Stream<DatabaseEvent> sessionStream;

  final QuizService quizService = getIt<QuizService>();
  final AuthService authService = getIt<AuthService>();

  String? leaderId;
  List<String> players = [];
  String status = "CREATED";
  bool isLoading = false;

  bool get isLeader => authService.getCurrentUser()?.uid == leaderId;

  @override
  void initState() {
    super.initState();
    sessionRef = FirebaseDatabase.instance.ref(widget.joinCode);
    sessionStream = sessionRef.onValue;

    sessionStream.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data == null) {
        // if (mounted) {
        //   Navigator.of(context).popUntil((route) => route.isFirst);
        // }
        return;
      }

      setState(() {
        leaderId = data['leader'];
        status = data['status'];
        players = List<String>.from(data['players']);
      });

      if (status == "ACTIVE") {
        if (mounted) {
          Navigator.pushReplacementNamed(context, "/quiz-start");
        }
      }
    });
  }

  Future<void> _startGame(String joinCode) async {
    setState(() => isLoading = true);

    try {
      await quizService.startQuizSession(joinCode);
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog(
        "Oops!",
        "Only the person who created this session can start the game.",
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _endSessionIfLeader() async {
    if (isLeader) {
      await quizService.endQuiz();
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _endSessionIfLeader();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lobby"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await _endSessionIfLeader();
            if (mounted) Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Join Code: ${widget.joinCode}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Text("Players:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            ...players.map((p) => Text(p)).toList(),
            const Spacer(),
            if (isLeader)
              ElevatedButton.icon(
                icon: isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(isLoading ? "Starting..." : "Start Game"),
                onPressed: isLoading ? null : () => _startGame(widget.joinCode),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
