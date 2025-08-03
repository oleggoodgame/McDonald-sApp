import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/provider/buy_provider.dart';
import 'package:mc_donalds/screens/approveBuy_screen.dart';
import 'package:mc_donalds/widgets/buyView_widget.dart';
import 'package:mc_donalds/widgets/mainDrawer.dart';

class BuyScreen extends ConsumerStatefulWidget {
  const BuyScreen({super.key});

  @override
  ConsumerState<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends ConsumerState<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final foodCounts = countFoodItems(cart).entries.toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Buy")),
      drawer: const MainDrawer(),
      body: const BuyGridView(),

      // 🟡 FAB для підтвердження покупки
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.shopping_cart_checkout),
            if (foodCounts.length > 0)
              Positioned(
                right: -42,
                top: -28,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 30,
                  ),
                  child: Text(
                    foodCounts.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        label: const Text('Buy'),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ApproveBuyScreen()),
          );
        },
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // 🔽 по центру
    );
  }
}
