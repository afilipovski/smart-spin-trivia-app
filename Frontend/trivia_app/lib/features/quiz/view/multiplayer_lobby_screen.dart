// File: lib/features/quiz/view/multiplayer_lobby_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trivia_app/core/domain/models/quiz_session.dart';
import 'package:trivia_app/core/domain/models/user_profile.dart';
import 'package:trivia_app/core/services/http_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/core/services/user_service.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/questions/view/questions_screen.dart';
import 'package:trivia_app/pick_category_page.dart';

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
  final HttpService _http = getIt<HttpService>();
  final _userSvc = getIt<UserService>();

  String status = 'WAITING';
  List<String> players = [];
  String? leaderId;
  bool _navigated = false;
  bool _isStarting = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    if (!widget.isLeader) {
      await _joinSession();
    }

    sessionRef = FirebaseDatabase.instance
        .ref('multiplayerSessions/${widget.session.joinCode}');

    try {
      final snapshot = await sessionRef.get();
      if (!snapshot.exists) {
        setState(() => errorMessage = 'Session not found.');
        return;
      }
      _setupListener();
    } catch (e) {
      setState(() => errorMessage = 'Init error: $e');
    }
  }

  Future<void> _joinSession() async {
    try {
      await _http.post('quiz-session/join/${widget.session.joinCode}', {});
    } catch (e) {
      print('Join warning: $e');
    }
  }

  void _setupListener() {
    sessionSub = sessionRef.onValue.listen(
      (event) {
        final snap = event.snapshot;
        if (!snap.exists) {
          _handleDeleted();
          return;
        }
        final data =
            Map<String, dynamic>.from(snap.value as Map<dynamic, dynamic>);
        setState(() {
          leaderId = data['leader'] as String?;
          status = data['status'] as String? ?? 'WAITING';
          players = (data['players'] as List).cast<String>();
          errorMessage = null;
        });
        if (status == 'ACTIVE' && !_navigated) {
          _navigated = true;
          _goToQuestions();
        }
      },
      onError: (e) => setState(() => errorMessage = 'Listener error: $e'),
    );
  }

  Future<void> _startSession() async {
    if (_isStarting || status != 'WAITING') return;
    setState(() => _isStarting = true);
    try {
      await _http.post('quiz-session/start/${widget.session.joinCode}', {});
    } catch (e) {
      setState(() => errorMessage = 'Start error: $e');
    } finally {
      setState(() => _isStarting = false);
    }
  }

  void _handleDeleted() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const PickCategoryPage()),
      (route) => false,
    );
  }

  void _goToQuestions() {
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

  @override
  void dispose() {
    sessionSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amILeader = widget.currentUserId == leaderId;
    return Scaffold(
      appBar: AppBar(title: const Text('Waiting Room')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (errorMessage != null)
              Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            Text('Join Code: ${widget.session.joinCode}',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Text('Players (${players.length}):',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (_, i) {
                  final playerId = players[i];
                  final isLeaderFlag = playerId == leaderId;

                  // Load user profile asynchronously
                  return FutureBuilder<UserProfile?>(
                    future: _userSvc.getUserProfileById(playerId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return ListTile(
                          leading:
                              Icon(isLeaderFlag ? Icons.star : Icons.person),
                          title: const Text('Loading...'),
                        );
                      }
                      if (snapshot.hasError || snapshot.data == null) {
                        return ListTile(
                          leading:
                              Icon(isLeaderFlag ? Icons.star : Icons.person),
                          title: const Text('Unknown User'),
                        );
                      }

                      final profile = snapshot.data!;
                      final displayName = profile.fullName ?? playerId;
                      final youTag =
                          playerId == widget.currentUserId ? ' (You)' : '';

                      return ListTile(
                        leading: Icon(isLeaderFlag ? Icons.star : Icons.person),
                        title: Text('$displayName$youTag'),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            if (amILeader)
              ElevatedButton(
                onPressed: players.length > 1 ? _startSession : null,
                child: _isStarting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('START GAME'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              )
            else
              const Text('Waiting for the leader...',
                  style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}
