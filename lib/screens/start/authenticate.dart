import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/screens/buttomNavigation_scree.dart';
import 'package:mc_donalds/screens/load_screen.dart';
import 'package:mc_donalds/screens/start/welcome.dart';

class Authenticate extends ConsumerWidget {
  const Authenticate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // if (snapshot.hasData) {
        //   print("✅ Logged in as: ${snapshot.data!.uid}");
        // } else {
        //   print("❌ No user, going to Authenticate()");
        // }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {

          return const McLoadScreen();

          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (_) => const ButtomnavigationScreen()),
          //     (route) => false,
          //   );
          // });
          // return const SizedBox(); // тимчасово пустий екран, поки іде навігація
        }

        if (snapshot.hasData) {
          print("✅ Logged in as: ${snapshot.data!.uid}");
          return const ButtomnavigationScreen();
        }

        return WelcomeScreen();
      },
    );
  }
}
