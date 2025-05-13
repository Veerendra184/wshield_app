import 'package:flutter/material.dart';

class PreBookBodyguardPage extends StatefulWidget {
  const PreBookBodyguardPage({Key? key}) : super(key: key);

  @override
  State<PreBookBodyguardPage> createState() => _PreBookBodyguardPageState();
}

class _PreBookBodyguardPageState extends State<PreBookBodyguardPage> {
  String? selectedTime;
  DateTime? selectedDate;
  String selectedLocation = '';

  List<Map<String, String>> bodyguards = [
    {"name": "Raj Verma", "rating": "4.8", "image": "lib/assets/bg1.png"},
    {"name": "Radha", "rating": "4.6", "image": "lib/assets/bg2.png"},
    {"name": "Surya Patil", "rating": "4.9", "image": "lib/assets/bg3.png"},
  ];

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // Dark date picker
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  void _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // Dark time picker
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => selectedTime = picked.format(context));
  }

  void _bookBodyguard(String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text("Booking Confirmed", style: TextStyle(color: Colors.white)),
        content: Text("You’ve booked $name successfully.", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget buildBodyguardCard(Map<String, String> bg) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(bg['image']!),
        ),
        title: Text(
          bg['name']!,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          "⭐ ${bg['rating']}",
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          onPressed: () => _bookBodyguard(bg['name']!),
          child: const Text("Book"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Pre-Book Bodyguard"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Enter Location",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white30),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => selectedLocation = value,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickDate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(selectedDate != null
                        ? selectedDate.toString().split(' ')[0]
                        : "Pick Date"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickTime,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(selectedTime ?? "Pick Time"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Available Bodyguards",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: bodyguards.map(buildBodyguardCard).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
