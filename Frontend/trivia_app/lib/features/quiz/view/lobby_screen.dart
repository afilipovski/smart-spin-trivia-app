import 'package:flutter/material.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:firebase_database/firebase_database.dart';

class MultiplayerLobbyScreen extends StatefulWidget {
  final String joinCode;
  final String currentUserId;

  const MultiplayerLobbyScreen({
    super.key,
    required this.joinCode,
    required this.currentUserId,
  });

  @override
  State<MultiplayerLobbyScreen> createState() => _MultiplayerLobbyScreenState();
}

class _MultiplayerLobbyScreenState extends State<MultiplayerLobbyScreen> {
  late DatabaseReference sessionRef;
  late Stream<DatabaseEvent> sessionStream;

  final QuizService quizService = getIt<QuizService>();

  String? leaderId;
  List<String> players = [];
  String status = "CREATED";

  @override
  void initState() {
    super.initState();
    sessionRef = FirebaseDatabase.instance.ref(widget.joinCode);
    sessionStream = sessionRef.onValue;

    sessionStream.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data == null) {
        Navigator.of(context).pop();
        return;
      }

      setState(() {
        leaderId = data['leader'];
        status = data['status'];
        players = List<String>.from(data['players']);
      });

      if (status == "ACTIVE") {
        Navigator.pushReplacementNamed(context, "/quiz-start");
      }
    });
  }

  Future<void> _startGame() async {
    await quizService.startQuizSession(widget.joinCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lobby")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text("Join Code: ${widget.joinCode}", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          const Text("Players:", style: TextStyle(fontSize: 18)),
          for (var player in players) Text(player),
          const Spacer(),
          if (widget.currentUserId == leaderId)
            ElevatedButton(
              onPressed: _startGame,
              child: const Text("Start Game"),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
