import 'package:flutter/material.dart';
import 'package:trivia_app/core/domain/dtos/streak_dto.dart';
import 'package:trivia_app/core/domain/models/user_friendship.dart';
import 'package:trivia_app/core/domain/models/user_profile.dart';
import 'package:trivia_app/core/services/service_locator.dart';
import 'package:trivia_app/core/services/user_friendship_service.dart';
import 'package:trivia_app/core/services/user_service.dart';
import 'package:trivia_app/features/friends/view/add_friend_screen.dart';
import 'package:trivia_app/features/quiz/view/quiz_screen.dart';
import 'package:trivia_app/features/user_profile/view/friend_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService userService = getIt<UserService>();
  final UserFriendshipService userFriendshipService =
      getIt<UserFriendshipService>();

  UserProfile? userProfile;
  List<UserFriendship>? userFriendships;
  List<UserFriendship> _friendRequests = [];
  StreakDto? streakDto;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    await Future.wait([
      _loadUserProfile(),
      _loadUserFriendships(),
      _loadFriendRequests(),
      _getStreak(),
    ]);
    setState(() => _isLoading = false);
  }

  Future<void> _loadUserProfile() async {
    final profile = await userService.getUserProfile();
    setState(() {
      userProfile = profile;
    });
  }

  Future<void> _getStreak() async {
    final streak = await userService.getStreak();
    setState(() {
      streakDto = streak;
    });
  }

  Future<void> _loadUserFriendships() async {
    final friendships = await userFriendshipService.getAllFriendships();
    setState(() {
      userFriendships = friendships;
    });
  }

  Future<void> _loadFriendRequests() async {
    final requests = await userFriendshipService.getAllFriendRequests();
    setState(() {
      _friendRequests = requests;
    });
  }

  Future<void> _acceptFriendRequest(String userId) async {
    await userFriendshipService.acceptFriendRequest(userId);
    // Reload both requests and friendships after accepting
    await _loadFriendRequests();
    await _loadUserFriendships();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => QuizScreen()),
            );
          },
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // --- User Profile Header ---
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: const Color(0xFF8668FF),
                            child: userProfile?.fullName != null &&
                                    userProfile!.fullName.isNotEmpty
                                ? Text(
                                    userProfile!.fullName[0].toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 40, color: Colors.white),
                                  )
                                : const Icon(Icons.person,
                                    size: 60, color: Colors.white),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            userProfile?.fullName ?? 'Guest User',
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          Text(
                            userProfile?.email ?? 'No email provided',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.cake,
                                  size: 20, color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(
                                "Born: ${userProfile?.birthDate.day}.${userProfile?.birthDate.month}.${userProfile?.birthDate.year}",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                              const SizedBox(width: 20),
                              const Icon(Icons.local_fire_department,
                                  color: Colors.orange, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Streak: ${userProfile?.streak ?? 0} Days",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // --- Pending Friend Requests ---
                    if (_friendRequests.isNotEmpty) ...[
                      const Divider(),
                      const SizedBox(height: 10),
                      Text(
                        "Pending Friend Requests",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ..._friendRequests.map((user) {
                        final initiator = user.friendshipInitiator;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  child: Text(
                                    initiator?.fullName[0].toUpperCase() ?? '?',
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    initiator?.fullName ?? 'Unknown User',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _acceptFriendRequest(
                                          user.friendshipInitiatorId ?? ''),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                      ),
                                      child: const Text("Accept",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                               
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                    ],
                    // --- Friends List ---
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      "My Friends",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    userFriendships != null && userFriendships!.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true, // Important for nested list views
                            physics:
                                const NeverScrollableScrollPhysics(), // Disable scrolling for this nested list
                            itemCount: userFriendships!
                                .where((f) => f.friendshipAccepted)
                                .length,
                            itemBuilder: (context, index) {
                              final acceptedFriendships = userFriendships!
                                  .where((f) => f.friendshipAccepted)
                                  .toList();
                              final friendship = acceptedFriendships[index];

                              var friend = friendship.friendshipReceiver;
                              if (friend != null &&
                                  friend.id == userProfile?.id) {
                                friend = friendship.friendshipInitiator;
                              }

                              if (friend == null) {
                                return const SizedBox.shrink();
                              }

                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                elevation: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FriendProfileScreen(
                                            friendProfile: friend!),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFF8668FF)
                                        .withOpacity(0.2),
                                    child: Text(
                                      friend.fullName[0].toUpperCase(),
                                      style: const TextStyle(
                                          color: Color(0xFF8668FF),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  title: Text(
                                    friend.fullName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.local_fire_department,
                                          color: Colors.orange, size: 20),
                                      const SizedBox(width: 5),
                                      Text(
                                        "${friend.streak ?? 0}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                "No friends yet. Add some to see their streaks!",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    // --- Add Friends Button ---
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddFriendScreen()),
                                  )
                                  .then((_) =>
                                      _loadData()); // Refresh data when returning
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8668FF),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text(
                              'Add Friends',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }
}
