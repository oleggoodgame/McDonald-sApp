import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/provider/start_provider.dart';
import 'package:mc_donalds/screens/start/sign_up.dart';

class StartSignUp extends ConsumerStatefulWidget {
  const StartSignUp({super.key});

  @override
  ConsumerState<StartSignUp> createState() => _StartSignUpScreenState();
}

class _StartSignUpScreenState extends ConsumerState<StartSignUp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

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

  void _onNext() {
    if (ref.read(userDataProvider.notifier).fifi()) {
      if (_formKey.currentState!.validate()) {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => SignUp(),
          ),
        );
      }
    }
  }

  void _showAgreement() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Agreement"),
        content: const Text("You are a good person, and you understand that this is not a real program."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    final userNotifier = ref.read(userDataProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Personal data",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "We need to know how to contact you",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration("Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                      onChanged: (val) => userNotifier.setName(val),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _surnameController,
                      decoration: _inputDecoration("Surname"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Surname is required';
                        }
                        return null;
                      },
                      onChanged: (val) => userNotifier.setSurname(val),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Switch(
                        value: userData.read,
                        onChanged: (value) => userNotifier.setRead(value),
                      ),
                      TextButton(
                        onPressed: _showAgreement,
                        child: const Text(
                          "You have read the agreement.",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Next", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
