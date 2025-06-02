import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WSHIELD Firebase Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthGate(),
    );
  }
}

// 🔐 Authentication Gate - Shows Login or Main Screen
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const FirebaseTestScreen(); // User is signed in
        } else {
          return const LoginScreen(); // Show login screen
        }
      },
    );
  }
}

// 🔐 Simple Login Screen (Anonymous Login)
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void loginAnonymously(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => loginAnonymously(context),
          child: const Text("Login Anonymously"),
        ),
      ),
    );
  }
}

// ✅ Your Existing Firebase Test Screen
class FirebaseTestScreen extends StatefulWidget {
  const FirebaseTestScreen({super.key});

  @override
  State<FirebaseTestScreen> createState() => _FirebaseTestScreenState();
}

class _FirebaseTestScreenState extends State<FirebaseTestScreen> {
  final databaseRef = FirebaseDatabase.instance.ref("test"); // test node
  String dataFromFirebase = "";

  @override
  void initState() {
    super.initState();
    readData();
  }

  void writeData() {
    databaseRef.set({
      'message': 'Hello from Flutter!',
      'timestamp': DateTime.now().toString(),
    });
  }

  void readData() {
    databaseRef.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null && mounted) {
        setState(() {
          dataFromFirebase = data['message'] ?? "No message";
        });
      }
    });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Realtime Test"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("User ID: ${user?.uid}", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Text("Message from Firebase:", style: TextStyle(fontSize: 16)),
            Text(dataFromFirebase, style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: writeData,
              child: const Text("Write to Firebase"),
            ),
          ],
        ),
      ),
    );
  }
}
