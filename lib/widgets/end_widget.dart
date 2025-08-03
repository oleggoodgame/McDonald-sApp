import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  void _showDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: const Text('Why do you need it?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy Policy'),
          onTap: () => _showDialog(context, 'Privacy Policy'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.description),
          title: const Text('Terms and conditions'),
          onTap: () => _showDialog(context, 'Terms and conditions'),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Image.asset(
            'assets/images/McDonald\'s.png',
            height: 120,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

