import 'package:flutter/material.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.deepOrange,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(Icons.home, size: 80, color: Colors.deepOrange),
            const SizedBox(height: 10),

            const Text(
              "Home Screen",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // METHOD 1: push + data
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(
                      userName: "Shraddha",
                      userEmail: "shraddha@vit.edu",
                      userRole: "Student",
                    ),
                  ),
                );
              },
              child: const Text("Go to Profile"),
            ),

            const SizedBox(height: 20),

            // METHOD 2: pushNamed
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text("Go to Settings"),
            ),
          ],
        ),
      ),
    );
  }
}