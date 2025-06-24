import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trivia_app/core/domain/models/quiz_session.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/questions/view/questions_screen.dart';

class MultiplayerLobbyScreen extends StatefulWidget {
  final QuizSession session;
  final GradientColor color;
  final bool isLeader;
  final String currentUserId;

  const MultiplayerLobbyScreen({
    super.key,
    required this.session,
    required this.color,
    required this.isLeader,
    required this.currentUserId,
  });

  @override
  _MultiplayerLobbyScreenState createState() => _MultiplayerLobbyScreenState();
}

class _MultiplayerLobbyScreenState extends State<MultiplayerLobbyScreen> {
  late final DatabaseReference sessionRef;
  StreamSubscription<DatabaseEvent>? sessionSub;
  final QuizService _quizService = getIt<QuizService>();

  String? leaderId;
  String status = 'UNKNOWN';
  List<String> players = [];
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    sessionRef =
        FirebaseDatabase.instance.ref('sessions/${widget.session.joinCode}');

    sessionSub = sessionRef.onValue.listen(_onSessionEvent);
  }

  void _onSessionEvent(DatabaseEvent event) {
    final snap = event.snapshot;

    if (!snap.exists || snap.value == null) {
      return;
    }

    final data = Map<String, dynamic>.from(
      snap.value as Map<dynamic, dynamic>,
    );

    final newStatus = (data['status'] as String?) ?? 'UNKNOWN';
    final newLeader = (data['leader'] as String?) ?? '';
    final newPlayers =
        (data['players'] as List<dynamic>?)?.cast<String>() ?? <String>[];

    setState(() {
      status = newStatus;
      leaderId = newLeader;
      players = newPlayers;
    });

    if (!_navigated && status == 'ACTIVE') {
      _navigated = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuestionsScreen(
            quiz: widget.session.quiz,
            gradientColor: widget.color,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    sessionSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amILeader = widget.currentUserId == leaderId;

    return Scaffold(
      appBar: AppBar(title: const Text('Lobby')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Code: ${widget.session.joinCode}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${widget.session.quiz.category}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),

            Text(
              'Players (${players.length}):',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (_, i) => ListTile(
                  leading: Icon(
                    i == 0 ? Icons.star : Icons.person,
                    color: i == 0 ? Colors.amber : Colors.grey,
                  ),
                  title: Text(players[i]),
                ),
              ),
            ),
            const SizedBox(height: 16),

            if (amILeader)
              ElevatedButton(
                onPressed: status == 'WAITING'
                    ? () => _quizService
                        .startQuizSession(widget.session.joinCode!)
                        .catchError((_) {})
                    : null,
                child: const Text('Start Quiz'),
              )
            else
              const Text('Waiting for leader to start…'),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
