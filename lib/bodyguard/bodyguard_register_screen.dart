import 'package:flutter/material.dart';
import 'bodyguard_dashboard_screen.dart';

class BodyguardRegisterScreen extends StatefulWidget {
  const BodyguardRegisterScreen({super.key});

  @override
  State<BodyguardRegisterScreen> createState() => _BodyguardRegisterScreenState();
}

class _BodyguardRegisterScreenState extends State<BodyguardRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Add Firebase registration logic here later
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BodyguardDashboardScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bodyguard Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (value) => value!.isEmpty ? "Enter name" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Enter email" : null,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) => value!.length < 6 ? "Min 6 chars" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _register, child: const Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}
