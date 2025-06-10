import 'package:flutter/material.dart';
import 'bodyguard_tracking_screen.dart';

class BodyguardRequestsScreen extends StatelessWidget {
  const BodyguardRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // In future: this list will come from Firebase
    final dummyRequests = [
      {"name": "Harsha", "location": "Bangalore", "time": "Now"},
      {"name": "Nisha", "location": "Indiranagar", "time": "Today, 5:30 PM"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Incoming Requests")),
      body: ListView.builder(
        itemCount: dummyRequests.length,
        itemBuilder: (context, index) {
          final request = dummyRequests[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text("Customer: ${request["name"]}"),
              subtitle: Text("Location: ${request["location"]}\nTime: ${request["time"]}"),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => const BodyguardTrackingScreens(),
                  ));
                },
                child: const Text("Accept"),
              ),
            ),
          );
        },
      ),
    );
  }
}
