import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/models/user_profile.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/core/services/user_friendship_service.dart';

class FriendProfileScreen extends StatefulWidget {
  final UserProfile friendProfile;

  const FriendProfileScreen({super.key, required this.friendProfile});

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  final userFriendshipService = getIt<UserFriendshipService>();
  List<UserProfile> mutualFriends = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMutualFriends();
  }

  Future<void> _loadMutualFriends() async {
    try {
      final currentUserId = widget.friendProfile.id;
      final friends = await userFriendshipService.getMutualFriends(currentUserId);
      setState(() {
        mutualFriends = friends;
        _isLoading = false;
      });
    } catch (_) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.friendProfile;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(Icons.person,
                                size: 50, color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user.fullName,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            user.email,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 17),
                        Text(
                          "Date of Birth: ${user.birthDate.day}.${user.birthDate.month}.${user.birthDate.year}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.local_fire_department,
                            color: Colors.orange),
                        const SizedBox(width: 10),
                        Text(
                          "Daily Streak: ${user.streak} Days",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    Text(
                      "Mutual Friends",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: mutualFriends.isNotEmpty
                          ? ListView.builder(
                              itemCount: mutualFriends.length,
                              itemBuilder: (context, index) {
                                final mutual = mutualFriends[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    child: Text(
                                      mutual.fullName[0].toUpperCase(),
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  title: Text(mutual.fullName),
                                );
                              },
                            )
                          : const Center(child: Text("No mutual friends.")),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
