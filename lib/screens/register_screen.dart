import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  String _gender = 'Male';
  bool _isLoading = false;

  final _auth = FirebaseAuth.instance;
  final _database = FirebaseDatabase.instance.ref();

  void _registerUser() async {
    setState(() => _isLoading = true);

    try {
      // Create Firebase Auth User
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final uid = userCredential.user?.uid;

      // Store User Info in Realtime Database
      await _database.child("users/$uid").set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'gender': _gender,
        'age': _ageController.text.trim(),
        'created_at': DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Registration failed")));
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('lib/assets/bg_black_white.png', fit: BoxFit.cover),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Text("Create Your Account", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  TextField(controller: _nameController, style: const TextStyle(color: Colors.white), decoration: _input("Full Name")),
                  const SizedBox(height: 20),
                  TextField(controller: _emailController, style: const TextStyle(color: Colors.white), decoration: _input("Email")),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _gender,
                    dropdownColor: Colors.black,
                    decoration: _input("Gender"),
                    items: ['Male', 'Female', 'Other']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (val) => setState(() => _gender = val!),
                  ),
                  const SizedBox(height: 20),
                  TextField(controller: _ageController, style: const TextStyle(color: Colors.white), keyboardType: TextInputType.number, decoration: _input("Age")),
                  const SizedBox(height: 20),
                  TextField(controller: _passwordController, obscureText: true, style: const TextStyle(color: Colors.white), decoration: _input("Password")),
                  const SizedBox(height: 30),
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton(
                          onPressed: _registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          ),
                          child: const Text("Register"),
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration _input(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    );
  }
}
