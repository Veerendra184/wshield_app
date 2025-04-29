import 'package:flutter/material.dart';

class DroneSurveillanceScreen extends StatelessWidget {
  const DroneSurveillanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Drone Surveillance"), backgroundColor: Colors.black),
      body: const Center(
        child: Text("Drone Surveillance Page (Coming Soon)", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
