import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  final String userName;
  final String userEmail;
  final String userRole;

  const ProfileScreen({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.deepOrange,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),

            const SizedBox(height: 20),

            Text("Name: $userName"),
            Text("Email: $userEmail"),
            Text("Role: $userRole"),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // go back
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}