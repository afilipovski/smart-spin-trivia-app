import 'package:flutter/material.dart';
import 'package:trivia_app/features/category/view/category_screen.dart';
import 'package:trivia_app/features/friends/view/add_friend_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;
  final String dateOfBirth;
  final int dailyStreak;
  final List<Map<String, dynamic>> friends;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.email,
    required this.dateOfBirth,
    required this.dailyStreak,
    required this.friends,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoryScreen(),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
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
                  const SizedBox(width: 10),
                  Text("Date of Birth: $dateOfBirth"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.orange),
                  const SizedBox(width: 10),
                  Text("Daily Streak: $dailyStreak Days"),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              Text(
                "Friends and their streaks",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: friends.isNotEmpty
                    ? ListView.builder(
                        itemCount: friends.length,
                        itemBuilder: (context, index) {
                          final friend = friends[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Text(
                                friend['name'][0].toUpperCase(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            title: Text(friend['name']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.local_fire_department,
                                    color: Colors.orange),
                                const SizedBox(width: 5),
                                Text("${friend['streak']}"),
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text("No friends yet."),
                      ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const AddFriendScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8668FF),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 40.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Add Friends',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
