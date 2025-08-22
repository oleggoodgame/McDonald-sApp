import 'package:flutter/material.dart';
import 'package:mc_donalds/data/data.dart';
import 'package:mc_donalds/models/more_model.dart';
import 'package:mc_donalds/screens/ScreenMore/information_screen.dart';
import 'package:mc_donalds/screens/ScreenMore/profile_screen.dart';
import 'package:mc_donalds/screens/ScreenMore/yourDelivery_screen.dart';
import 'package:mc_donalds/widgets/moreCard_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MoreScreenState();
  }
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "MORE",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(child: Image.asset("assets/images/morePhoto.jpg")),
            ],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: moreItems.length,
              itemBuilder: (context, index) {
                final item = moreItems[index];
                return InkWell(
                  onTap: () {
                    _showOnTap(item.type);
                  },
                  child: MoreCard(item: item, )

                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _showOnTap(TypeMore type) {
    if (type == TypeMore.Profile) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => ProfileScreen(),
        ),);
    } else if (type == TypeMore.Site) {
      _launchUrl("https://www.mcdonalds.com/ua/uk-ua.html");
    } else if (type == TypeMore.Instagram) {
      _launchUrl("https://www.instagram.com/mcdonalds/?hl=uk");
    } else if (type == TypeMore.YourDelivery) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const YourDeliveryScreen()),
      );
    } else if (type == TypeMore.Feedback) {
      _launchUrl("https://github.com/oleggoodgame");
    } else if (type == TypeMore.Information) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const InformationScreen()),
      );
    } else if (type == TypeMore.ChangeCountry) {
      // пусто нічого, майбутнє, потім додамо
    }
  }

  _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
