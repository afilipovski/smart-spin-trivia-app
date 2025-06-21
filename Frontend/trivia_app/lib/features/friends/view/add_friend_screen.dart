import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/models/user_friendship.dart';
import 'package:trivia_app/core/domain/models/user_profile.dart';
import 'package:trivia_app/core/services/logger_service.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/core/services/user_friendship_service.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController _friendNameController = TextEditingController();
  final UserFriendshipService _userFriendshipService =
      getIt<UserFriendshipService>();
  final LoggerService _loggerService = getIt<LoggerService>();

  final List<UserProfile> _searchResults = [];
  final List<UserFriendship> _friendRequests = [];

  Timer? _debounce;
  bool _isSearching = false;
  bool _isLoadingRequests = true;

  @override
  void initState() {
    super.initState();
    _loadFriendRequests();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchUsers(query);
    });
  }

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final users = await _userFriendshipService.getListOfUsers(query);
      setState(() {
        _searchResults
          ..clear()
          ..addAll(users);
      });
    } catch (e) {
      _loggerService.logError('Error occurred: $e');
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  Future<void> _addFriend(String userId) async {
    try {
      await _userFriendshipService.sendFriendRequest(userId);
      setState(() {
        // _friendNameController.clear();
        _searchResults.clear();
      });
    } catch (e) {
      _loggerService.logError('$e');
    }
  }

  Future<void> _loadFriendRequests() async {
    try {
      final requests = await _userFriendshipService.getAllFriendRequests();
      setState(() {
        _friendRequests
          ..clear()
          ..addAll(requests);
      });
    } catch (e) {
      _loggerService.logError('Error loading friend requests: $e');
    } finally {
      setState(() {
        _isLoadingRequests = false;
      });
    }
  }

  Future<void> _acceptFriendRequest(String userId) async {
    try {
      await _userFriendshipService.acceptFriendRequest(userId);
      setState(() {
        _friendRequests.removeWhere(
            (user) => user.friendshipInitiatorId == userId);
      });
    } catch (e) {
      _loggerService.logError('Failed to accept request: $e');
    }
  }

  void dismissKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void dispose() {
    _friendNameController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your friend's username",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _friendNameController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: "Friend's username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (_isSearching)
                  const Center(child: CircularProgressIndicator())
                else if (_searchResults.isNotEmpty)
                  Column(
                    children: _searchResults.map((user) {
                      return ListTile(
                        title: Text(user.fullName),
                        trailing: ElevatedButton(
                          onPressed: () => _addFriend(user.id),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8668FF),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 20),
                const Divider(),
                Text(
                  "Friend Requests",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 10),
                if (_isLoadingRequests)
                  const Center(child: CircularProgressIndicator())
                else if (_friendRequests.isEmpty)
                  const Text("No friend requests.")
                else
                  Column(
                    children: _friendRequests.map((user) {
                      final initiator = user.friendshipInitiator;
                      return ListTile(
                        title: Text(initiator?.fullName ?? ''),
                        trailing: ElevatedButton(
                          onPressed: () => _acceptFriendRequest(
                              user.friendshipInitiatorId ?? ''),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Accept",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
