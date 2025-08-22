import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/data/data.dart';
import 'package:mc_donalds/models/main_card_model.dart';
import 'package:mc_donalds/screens/homeInformation_screen.dart';
import 'package:mc_donalds/widgets/homeCard_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _setScreen(News news) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, animation, secondaryAnimation) =>
            HomeInformationScreen(news: news),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('McDonald\'s'),
            backgroundColor: Colors.white,
            floating: false, // не з’являється знову одразу при скролі вгору
            pinned: false, // не закріплений
            snap: false, // зникає поступово, не стрибає
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/McDonald\'s.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final news = newsList[index];
              return InkWell(
                child: HomeCard(news: news),
                onTap: () {
                  _setScreen(news);
                },
              ); // ОТУТ чомусь не відкриває HomeInformationScreen
            }, childCount: newsList.length),
          ),
        ],
      ),
    );
  }
}
