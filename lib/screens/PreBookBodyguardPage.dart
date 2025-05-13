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
    {"name": "Raj Verma", "rating": "4.8", "image": "assets/bg1.png"},
    {"name": "Amit Rana", "rating": "4.6", "image": "assets/bg2.png"},
    {"name": "Surya Patil", "rating": "4.9", "image": "assets/bg3.png"},
  ];

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  void _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => selectedTime = picked.format(context));
  }

  void _bookBodyguard(String name) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Booking Confirmed"),
        content: Text("You’ve booked $name successfully."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget buildBodyguardCard(Map<String, String> bg) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(bg['image']!),
        ),
        title: Text(bg['name']!),
        subtitle: Text("⭐ ${bg['rating']}"),
        trailing: ElevatedButton(
          onPressed: () => _bookBodyguard(bg['name']!),
          child: Text("Book"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pre-Book Bodyguard"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Enter Location",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => selectedLocation = value,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickDate,
                  child: Text(selectedDate != null
                      ? selectedDate.toString().split(' ')[0]
                      : "Pick Date"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _pickTime,
                  child: Text(selectedTime ?? "Pick Time"),
                ),
              ],
            ),
            SizedBox(height: 20),
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
