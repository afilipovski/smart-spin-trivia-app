// File: lib/features/quiz/view/multiplayer_session_gateway_screen.dart
import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/models/quiz.dart';
import 'package:trivia_app/core/domain/exceptions/http_response_exception.dart';
import 'package:trivia_app/core/services/quiz_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/quiz/view/join_session_screen.dart';
import 'package:trivia_app/features/quiz/view/multiplayer_lobby_screen.dart';

class MultiplayerSessionGatewayScreen extends StatefulWidget {
  final Quiz quiz;
  final GradientColor gradientColor;

  const MultiplayerSessionGatewayScreen({
    super.key,
    required this.quiz,
    required this.gradientColor,
  });

  @override
  State<MultiplayerSessionGatewayScreen> createState() =>
      _MultiplayerSessionGatewayScreenState();
}

class _MultiplayerSessionGatewayScreenState
    extends State<MultiplayerSessionGatewayScreen> {
  final QuizService _service = getIt<QuizService>();
  bool _loading = false;

  Future<void> _createOrResume() async {
    setState(() => _loading = true);
    try {
      final session = await _service.createQuizSession(widget.quiz.id);
      _navigateToLobby(session);
    } on HttpResponseException catch (e) {
      if (e.message?.contains('already has an active session') == true) {
        await _handleExisting();
      } else {
        _showError('Create failed', e.message ?? '');
      }
    } catch (e) {
      _showError('Error', e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _handleExisting() async {
    final existing = await _service.getQuizSession();
    final resume = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Active Session Found'),
        content: const Text('Resume or create new session?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('New')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Resume')),
        ],
      ),
    );
    if (resume == true) {
      _navigateToLobby(existing);
    } else if (resume == false) {
      await _service.forceEndSession();
      await _createOrResume();
    }
  }

  void _navigateToLobby(session) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MultiplayerLobbyScreen(
          session: session,
          color: widget.gradientColor,
          isLeader: true,
          currentUserId: session.userProfile!.id,
        ),
      ),
    );
  }

  void _showError(String title, String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context), child: const Text('OK'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiplayer')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.play_arrow),
              label: Text(_loading ? 'Processing...' : 'Start New Session'),
              onPressed: _loading ? null : _createOrResume,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.input),
              label: const Text('Join with Code'),
              onPressed: _loading
                  ? null
                  : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => JoinSessionScreen(
                                  quiz: widget.quiz,
                                  gradientColor: widget.gradientColor,
                                )),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
