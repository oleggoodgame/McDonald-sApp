import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/data/data.dart';
import 'package:mc_donalds/models/foods_model.dart';
import 'package:mc_donalds/models/vaucher_model.dart';
import 'package:mc_donalds/provider/buy_provider.dart';
import 'package:mc_donalds/provider/profile_provider.dart';

class ApproveBuyScreen extends ConsumerWidget {
  const ApproveBuyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final foodCounts = countFoodItems(cart).entries.toList();
    final totalAmount = foodCounts.fold<double>(
      0.0,
      (sum, entry) => sum + getDiscountedPrice(entry.key, entry.value, ref),
    );
    return Scaffold(
      appBar: AppBar(title: Text("Total $totalAmount")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: foodCounts.length,
              itemBuilder: (context, index) {
                final entry = foodCounts[index];
                final food = entry.key;
                final count = entry.value;
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            food.photoPath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            food.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text("Price: ${getDiscountedPrice(food, count, ref)}\$"),
                        SizedBox(width: 12),
                        Text("× $count"),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            cartNotifier.removeCard(food);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () {
                final profileNotifier = ref.read(profileProvider.notifier);
                final profile = ref.read(profileProvider);

                for (final entry in foodCounts) {
                  final food = entry.key;

                  Vaucher? activeVoucher;

                  try {
                    activeVoucher = profile.activeVauchers.firstWhere(
                      (v) => v.title == food.title,
                    );
                  } catch (e) {
                    activeVoucher = null;
                  }

                  if (activeVoucher != null) {
                    vaucherList.removeWhere(
                      (v) => v.title == activeVoucher!.title,
                    );
                    profileNotifier.deactivateVaucher(activeVoucher);
                  }
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order confirmed!")),
                );
                cartNotifier.clearCart();
                Navigator.pop(context);
              },

              child: const Text("Підтвердити замовлення"),
            ),
          ),
        ],
      ),
    );
  }

  double getDiscountedPrice(Food food, int count, WidgetRef ref) {
      print(ref.read(profileProvider).activeVauchers);
      for (var v in ref.read(profileProvider).activeVauchers) {
        print(v);
        if (food.title == v.title) {
          if (v.type == TypeVaucher.discount) {
            return count * food.price * (1 - v.discount / 100);
          } else if (v.type == TypeVaucher.priceDiscount) {
            return count * v.discount;
          }
        }
      }
      return count * food.price;
    }

  // double getDiscountedPrice(Food food, WidgetRef ref) {
  //   print(ref.read(profileProvider).activeVauchers);
  //   for (var v in ref.read(profileProvider).activeVauchers) {
  //     print(v);
  //     if (food.title == v.title) {
  //       if (v.type == TypeVaucher.discount) {
  //         totalAmount += food.price * (1 - v.discount / 100);
  //         return food.price * (1 - v.discount / 100);
  //       } else if (v.type == TypeVaucher.priceDiscount) {
  //         totalAmount += v.discount;

  //         return v.discount;
  //       }
  //     }
  //   }
  //   totalAmount += food.price;
  //   return food.price;
  // }
}
