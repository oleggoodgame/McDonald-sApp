import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Information")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About Our App",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                  "Here you can write any information about the app, company, data policy, "
                  "or even some jokes :) It's a great way to show users what your app is about.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Got it!"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
