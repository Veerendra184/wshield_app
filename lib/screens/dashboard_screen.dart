import 'package:flutter/material.dart';
import 'hire_bodyguard_screen.dart';
import 'drone_surveillance_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("WSHIELD Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Choose Your Protection", style: TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageTile(
                  context,
                  imagePath: 'lib/assets/bodyguard.png',
                  label: "Bodyguard",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HireBodyguardScreen()),
                  ),
                ),
                _buildImageTile(
                  context,
                  imagePath: 'lib/assets/drone.png',
                  label: "Drone",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DroneSurveillanceScreen()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageTile(BuildContext context, {required String imagePath, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
