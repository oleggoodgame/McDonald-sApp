import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/models/foods_model.dart';
import 'package:mc_donalds/provider/food_provider.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.amber),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.fastfood, size: 48, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'McDonald\'s App',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Image.asset("assets/images/fries.webp"),
            title: const Text('Fries & Snacks'),
            onTap: () {
              ref.read(foodFilter.notifier).state = TypeFood.Fries_and_Snacks;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/hamburger.webp"),
            title: const Text('Burgers'),
            onTap: () {
              ref.read(foodFilter.notifier).state = TypeFood.Burgers;
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/coca_cola.webp"),
            title: const Text('Drink'),
            onTap: () {
              ref.read(foodFilter.notifier).state = TypeFood.Drink;

              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/ketchup.webp"),
            title: const Text('Side dishes'),
            onTap: () {
              ref.read(foodFilter.notifier).state = TypeFood.Side;

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
