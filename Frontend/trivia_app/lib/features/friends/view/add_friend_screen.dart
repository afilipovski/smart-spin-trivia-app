import 'dart:async';
import 'package:flutter/material.dart';
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
  final UserFriendshipService _userFriendshipService = getIt<UserFriendshipService>();
  final LoggerService _loggerService = getIt<LoggerService>();
  final List<String> _friends = List.empty(growable: true);

  Timer? _debounce;
  List<UserProfile> _searchResults = List.empty(growable: true);
  bool _isSearching = false;
  String _addLabel = "Add";

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchUsers(query);
    });
  }

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final response = await _userFriendshipService.getListOfUsers(query);

      setState(() {
        _searchResults = response;
        _isSearching = false;
      });
    } on Exception catch (e) {
      _loggerService.logError('Error occurred: $e');
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _addFriend(String userId) async {
    // if (!_friends.contains(fullName)) {
      try{
        await _userFriendshipService.sendFriendRequest(userId);
      }catch(e){
        _loggerService.logError('$e');
      }

      setState(() {
        // _friends.add(fullName);
        _searchResults = [];
        _friendNameController.clear();
        _addLabel = "Pending";
      });
    // }
  }

  void dismissKeyboard(BuildContext buildContext) {
    final FocusScopeNode currentFocus = FocusScope.of(buildContext);
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
                    children: _searchResults
                        .map(
                          (user) => ListTile(
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
                              child: Text(
                                _addLabel,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 20),
                const Divider(),
                Text(
                  "Friends",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _friends.isNotEmpty
                      ? ListView.builder(
                          itemCount: _friends.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: const Color(0xFF8668FF),
                                child: Text(
                                  _friends[index][0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(_friends[index]),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            "No friends added yet.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
