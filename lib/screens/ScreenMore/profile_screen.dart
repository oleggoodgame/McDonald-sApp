import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/data/data.dart';
import 'package:mc_donalds/models/more_model.dart';
import 'package:mc_donalds/provider/profile_provider.dart';
import 'package:mc_donalds/screens/ScreenMore/editProfile_screen.dart';
import 'package:mc_donalds/screens/ScreenMore/profileVIew_screen.dart';
import 'package:mc_donalds/screens/start/authenticate.dart';
import 'package:mc_donalds/widgets/moreCard_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Future<void> _deleteAccount() async {
    final TextEditingController passwordController = TextEditingController();
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No user signed in")));
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm account deletion"),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Enter your password"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final password = passwordController.text.trim();

                try {
                  // спочатку треба повторна автентифікація
                  final cred = EmailAuthProvider.credential(
                    email: user.email!,
                    password: password,
                  );
                  await user.reauthenticateWithCredential(cred);

                  // після успішної авторизації видаляємо
                  await user.delete();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop(); 
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Authenticate(),
                      ),
                      (route) => false,
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${e.toString()}")),
                  );
                }
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Hi ${userProfile.firstName}"),
              const Icon(Icons.account_circle),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: profileActions.length,
              itemBuilder: (context, index) {
                final action = profileActions[index];
                return InkWell(
                  onTap: () => _showOnTap(context, action.type),
                  child: MoreCard(item: action),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showOnTap(BuildContext context, TypeProfileAction type) async {
    if (type == TypeProfileAction.View) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileViewScreen()),
      );
    } else if (type == TypeProfileAction.Change) {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Authenticate()),
          (route) => false,
        );
      }
    } else if (type == TypeProfileAction.Edit) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EditProfileScreen()),
      );
    } else if (type == TypeProfileAction.Share) {
      // тут треба буде поцікавтись як поділитись
    } else if (type == TypeProfileAction.Delete) {
      // треба підтвердити пароль а тоді видаляти
      _deleteAccount();
    }
  }
}
