import 'package:flutter/material.dart';
import 'package:mc_donalds/models/main_card_model.dart';
import 'package:mc_donalds/widgets/end_widget.dart';

class HomeInformationScreen extends StatelessWidget {
  const HomeInformationScreen({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.inviteTitle)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: news.photoPath,
              child: Image.asset(
                news.photoPath,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                news.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                news.fullInformation,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            PrivacyScreen(),
          ],
        ),
      ),
    );
  }
}
