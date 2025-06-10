import 'package:flutter/material.dart';
import 'bodyguard_register_screen.dart';
import 'bodyguard_dashboard_screen.dart';

class BodyguardLoginScreen extends StatefulWidget {
  const BodyguardLoginScreen({super.key});

  @override
  State<BodyguardLoginScreen> createState() => _BodyguardLoginScreenState();
}

class _BodyguardLoginScreenState extends State<BodyguardLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // Add Firebase login logic here later
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BodyguardDashboardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bodyguard Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const BodyguardRegisterScreen()));
              },
              child: const Text("New? Register here"),
            )
          ],
        ),
      ),
    );
  }
}
