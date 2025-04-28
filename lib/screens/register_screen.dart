import 'package:flutter/material.dart';
import 'login_screen.dart'; // Don't forget to import!

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false; // 🔥 new loading variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/bg_black_white.png',
              fit: BoxFit.cover,
            ),
          ),

          // Registration Form
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Full Name
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: _buildInputDecoration('Full Name'),
                  ),
                  const SizedBox(height: 20),

                  // Email
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: _buildInputDecoration('Email'),
                  ),
                  const SizedBox(height: 20),

                  // Gender
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.black,
                    decoration: _buildInputDecoration('Gender'),
                    items: ['Male', 'Female', 'Other']
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender, style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 20),

                  // Age
                  TextField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: _buildInputDecoration('Age'),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  TextField(
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: _buildInputDecoration('Password'),
                  ),
                  const SizedBox(height: 30),

                  // Register Button or Loading Spinner
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white) // 🔥 Spinner
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          ),
                          onPressed: _registerUser, // 💥 calling register function
                          child: const Text('Register'),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white38),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }

  // 🛡️ Fake Register Function (Simulating backend)
  void _registerUser() {
    setState(() {
      _isLoading = true; // Show Spinner
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // Hide Spinner
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account Created Successfully!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }
}
