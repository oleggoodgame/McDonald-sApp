import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/screens/buy_screen.dart';
import 'package:mc_donalds/screens/home_screen.dart';
import 'package:mc_donalds/screens/more_screen.dart';
import 'package:mc_donalds/screens/vauchers_screen.dart';
// import 'package:mc_donalds/screens/vouchers_screen.dart';
// import 'package:mc_donalds/screens/buy_screen.dart';
// import 'package:mc_donalds/screens/information_more.dart';

class ButtomnavigationScreen extends ConsumerStatefulWidget {
  const ButtomnavigationScreen({super.key});

  @override
  ConsumerState<ButtomnavigationScreen> createState() => _ButtomnavigationScreenState();
}

class _ButtomnavigationScreenState extends ConsumerState<ButtomnavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
     const VauchersScreen(),
     const BuyScreen(),
     const MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.yellow[700],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex==1 ? Image.asset(
              'assets/images/McDonald\'s.png',
              width: 24,
              height: 24,) : 
              Image.asset('assets/images/McDonaldGrey.png',
              width: 24,
              height: 24,),
              label: 'Vouchers',
            ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Buy',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
