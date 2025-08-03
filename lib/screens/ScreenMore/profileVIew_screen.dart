import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/models/profile_model.dart';
import 'package:mc_donalds/provider/profile_provider.dart';
import 'package:intl/intl.dart';

class ProfileViewScreen extends ConsumerWidget {
  const ProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(profileProvider);

    final fullName = '${userProfile.firstName} ${userProfile.lastName}';
    final email = userProfile.email;
    final birthDate = userProfile.birthDate;
    final gender = userProfile.gender == Gender.male ? 'Male' : 'Female';
    final formattedDate = DateFormat('yyyy-MM-dd').format(birthDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Your Profile"), centerTitle: true),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Colors.blueGrey,
                ),
                const SizedBox(height: 16),
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(email),
                const SizedBox(height: 8),
                Text('Born: $formattedDate'),
                Text('Gender: $gender'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
