import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/models/foods_model.dart';
import 'package:mc_donalds/models/vaucher_model.dart';
import 'package:mc_donalds/provider/buy_provider.dart';
import 'package:mc_donalds/provider/profile_provider.dart';

class FoodInformationScreen extends ConsumerWidget {
  const FoodInformationScreen({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(food.title)),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(food.photoPath, fit: BoxFit.cover, height: 300),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                food.title,
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
              child: Text(food.value, style: const TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                food.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildPriceWidget(food, ref),
            ),
            const SizedBox(height: 20),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 200),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  onPressed: () {
                    
                    ref.read(cartProvider.notifier).addToCart(food);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Додано до покупки!')),
                    );
                  },
                  child: const Text("Купити"),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  double getDiscountedPrice(Food food, WidgetRef ref) {
    print(ref.read(profileProvider).activeVauchers);
    for (var v in ref.read(profileProvider).activeVauchers) {
      print(v);
      if (food.title == v.title) {
        if (v.type == TypeVaucher.discount) {
          return food.price * (1 - v.discount / 100);
        } else if (v.type == TypeVaucher.priceDiscount) {
          return v.discount;
        }
      }
    }
    return food.price;
  }

  Widget buildPriceWidget(Food food, WidgetRef ref) {
    final discountedPrice = getDiscountedPrice(food, ref);
    final hasDiscount = discountedPrice < food.price;
    print(getDiscountedPrice(food, ref));
    print(hasDiscount);
    if (!hasDiscount) {
      // Якщо знижки нема — просто показуємо ціну
      return Text(
        'Price: \$${food.price.toStringAsFixed(2)}',
        style: const TextStyle(fontSize: 18),
      );
    }

    // Якщо знижка є — показуємо стару ціну перекресленою і нову жирним зеленим
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Original price: \$${food.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            decoration: TextDecoration.lineThrough,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Discounted price: \$${discountedPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
