import 'package:flutter/material.dart';

class BodyguardDashboardScreen extends StatelessWidget {
  const BodyguardDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bodyguard Dashboard")),
      body: const Center(
        child: Text(
          "Welcome, Bodyguard!\n\nIncoming requests will show here.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
