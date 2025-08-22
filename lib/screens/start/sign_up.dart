import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/database/database.dart';
import 'package:mc_donalds/models/profile_model.dart';
import 'package:mc_donalds/provider/start_provider.dart';
import 'package:mc_donalds/screens/start/sign_in.dart';

class SignUp extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  // final _birthdayController = TextEditingController();
  // final _nameController = TextEditingController();
  final db = DatabaseService();

  SignUp({super.key});

  Future<void> _saveItem(BuildContext context, WidgetRef ref) async {
    // проблема що довго загружає
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final repeatPassword = _repeatPasswordController.text;

      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: repeatPassword,
          );

      final uid = userCredential.user!.uid;
      await db.addProfile(
        uid,
        ref.read(userDataProvider).name,
        ref.read(userDataProvider).surname,
        Gender.nothing,
        ref.read(userDataProvider).read,
      );

      ref.read(userDataProvider.notifier).clear();
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.amber, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.amber.shade700, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Sign up to MacDonalds App", style: t.titleLarge),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: _inputDecoration("Email"),
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: _inputDecoration("Password"),
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _repeatPasswordController,
                    obscureText: true,
                    decoration: _inputDecoration("Repeat password"),
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Passwords must match';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.amber, width: 1.5),
              ),
            ),
            onPressed: () => _saveItem(context, ref),
            child: const Text("REGISTER"),
          ),
          Row(
            children: [
              const Text('If you have already account'),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => SignIn()),
                  );
                },
                child: const Text(
                  'Please sign in',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
