import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

// Customer Screens
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart' as customer;
import 'screens/dashboard_screen.dart';
import 'screens/hire_bodyguard_screen.dart';
import 'screens/drone_surveillance_screen.dart';
import 'screens/PreBookBodyguardPage.dart';
import 'screens/live_tracking_screen.dart';

// Bodyguard Screens
import 'bodyguard/role_selection_screen.dart';
import 'bodyguard/bodyguard_register_screen.dart';
import 'bodyguard/bodyguard_login_screen.dart' as bodyguard;
import 'bodyguard/bodyguard_dashboard_screen.dart';
import 'bodyguard/bodyguard_requests_screen.dart';
import 'bodyguard/bodyguard_tracking_screen.dart';
import 'bodyguard/bodyguard_profile_screen.dart';

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
      title: 'WSHIELD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        // Initial Route
        '/': (context) => const SplashScreen(),

        // Role Selection
        '/role-selection': (context) => const RoleSelectionScreen(),

        // AuthGate (if used later)
        '/auth': (context) => const AuthGate(),

        // Customer Routes
        '/customer-login': (context) => const customer.LoginScreen(),
        '/customer-dashboard': (context) => const DashboardScreen(),
        '/hire-bodyguard': (context) => const HireBodyguardScreen(),
        '/drone-surveillance': (context) => const DroneSurveillanceScreen(),
        '/prebook-bodyguard': (context) => const PreBookBodyguardPage(),
        '/live-tracking': (context) => const BodyguardTrackingScreen(),

        // Bodyguard Routes
        '/bodyguard-login': (context) => const bodyguard.BodyguardLoginScreen(),
        '/bodyguard-register': (context) => const BodyguardRegisterScreen(),
        '/bodyguard-dashboard': (context) => const BodyguardDashboardScreen(),
        '/bodyguard-requests': (context) => const BodyguardRequestsScreen(),
        '/bodyguard-tracking': (context) => const BodyguardTrackingScreen(),
        '/bodyguard-profile': (context) => const BodyguardProfileScreen(),
      },
    );
  }
}

/// Optional: AuthGate if you want to auto-redirect based on Firebase login
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
          // ⚠️ TODO: Use Firestore to detect role and redirect to correct dashboard
          return const DashboardScreen(); // Default for now
        } else {
          return const RoleSelectionScreen();
        }
      },
    );
  }
}
