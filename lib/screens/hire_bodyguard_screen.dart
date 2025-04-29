import 'package:flutter/material.dart';

class HireBodyguardScreen extends StatelessWidget {
  const HireBodyguardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Hire Bodyguard"), backgroundColor: Colors.black),
      body: const Center(
        child: Text("Bodyguard Booking Page (Coming Soon)", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
