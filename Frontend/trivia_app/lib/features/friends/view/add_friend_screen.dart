import 'package:flutter/material.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController _friendNameController = TextEditingController();
  final List<String> _friends = [];

  void _addFriend() {
    String friendName = _friendNameController.text.trim();
    if (friendName.isNotEmpty) {
      setState(() {
        _friends.add(friendName);
      });
      _friendNameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Friends"),
        backgroundColor: const Color.fromARGB(255, 220, 63, 144),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Enter Friend's Username",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _friendNameController,
                    decoration: const InputDecoration(
                      hintText: "Friend's name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addFriend,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 220, 63, 144),
                  ),
                  child: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            Text(
              "Friends List",
              style: TextStyle(
                fontSize: 18,
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
                            backgroundColor: Colors.grey[300],
                            child: Text(
                              _friends[index][0].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(_friends[index]),
                        );
                      },
                    )
                  : const Center(
                      child: Text("No friends added yet."),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
