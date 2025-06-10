import 'package:flutter/material.dart';

class BodyguardProfileScreen extends StatelessWidget {
  const BodyguardProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/assets/bodyguard_marker.png'),
            ),
            SizedBox(height: 16),
            Text("Name: John Doe", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Email: johndoe@example.com", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Experience: 3 Years", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Location: Bangalore", style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: null,
              child: Text("Edit Profile (Coming Soon)"),
            )
          ],
        ),
      ),
    );
  }
}
