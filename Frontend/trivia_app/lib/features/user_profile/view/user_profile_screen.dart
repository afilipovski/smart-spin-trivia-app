import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/dtos/streak_dto.dart';
import 'package:trivia_app/core/domain/models/user_friendship.dart';
import 'package:trivia_app/core/domain/models/user_profile.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/core/services/user_friendship_service.dart';
import 'package:trivia_app/core/services/user_service.dart';
import 'package:trivia_app/features/friends/view/add_friend_screen.dart';
import 'package:trivia_app/features/quiz/view/quiz_screen.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({
    super.key,
    
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService userService = getIt<UserService>();
  final UserFriendshipService userFriendshipService = getIt<UserFriendshipService>();

  UserProfile? userProfile;
  List<UserFriendship>? userFriendships;
  StreakDto? streakDto;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadUserFriendships();
    _getStreak();
  }

  Future<void> _loadUserProfile() async {
    final profile = await userService.getUserProfile();
    setState(() {
      userProfile = profile;
    });
  }

  Future<void> _loadUserFriendships() async {
    final friendships = await userFriendshipService.getAllFriendships();
    setState(() {
      userFriendships = friendships;
    });
  }

  Future<void> _getStreak() async {
    final streak = await userService.getStreak();
    setState(() {
      streakDto = streak;
    });
  }

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
                builder: (context) => QuizScreen(),
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
                      userProfile?.fullName ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userProfile?.email ?? '',
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
                  const SizedBox(width: 17),
                  Text(
                    "Date of Birth: ${userProfile?.birthDate.day}.${userProfile?.birthDate.month}.${userProfile?.birthDate.year}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.orange),
                  const SizedBox(width: 10),
                  Text("Daily Streak: ${userProfile?.streak} Days",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
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
                child: userProfile != null &&
                        userFriendships != null &&
                        userFriendships!.isNotEmpty
                    ? ListView.builder(
                        itemCount: userFriendships!.length,
                        itemBuilder: (context, index) {
                          if(!userFriendships![index].friendshipAccepted){
                            return null;
                          }
                          var friend = userFriendships![index].friendshipReceiver;
                          if(friend != null && userProfile!.id == friend.id){
                            friend = userFriendships![index].friendshipInitiator;
                          }
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Text(
                                friend!.fullName[0].toUpperCase(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            title: Text(friend.fullName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.local_fire_department,
                                    color: Colors.orange),
                                const SizedBox(width: 5),
                                Text("${friend.streak}"),
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
