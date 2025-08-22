import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/models/foods_model.dart';
import 'package:mc_donalds/models/vaucher_model.dart';
import 'package:mc_donalds/provider/buy_provider.dart';
import 'package:mc_donalds/provider/profile_provider.dart';

class DeliveryWidget extends ConsumerWidget {
  const DeliveryWidget(this.food, this.count, {super.key});
  final Food food;
  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartProvider.notifier);
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
}
