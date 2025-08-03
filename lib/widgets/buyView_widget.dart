import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/models/foods_model.dart';
import 'package:mc_donalds/models/vaucher_model.dart';
import 'package:mc_donalds/provider/food_provider.dart';
import 'package:mc_donalds/provider/profile_provider.dart';
import 'package:mc_donalds/screens/buyInformation_screen.dart';

class BuyGridView extends ConsumerWidget {
  const BuyGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredList = ref.watch(filteredTodos);

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filteredList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final food = filteredList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodInformationScreen(food: food),
              ),
            );
          },

          child: Card(
            elevation: 3,
            color: Colors.white, // Білий фон
            margin: EdgeInsets
                .zero, // Прибрати зовнішній відступ (якщо хочеш трохи залишити — постав EdgeInsets.all(4))
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      food.photoPath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      food.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  double getDiscountedPrice(Food food, List<Vaucher> activeVauchers, WidgetRef ref) {
  for (var v in ref.read(profileProvider).activeVauchers) {
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

}
