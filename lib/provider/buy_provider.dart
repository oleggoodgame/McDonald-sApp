import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/models/foods_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<Food>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<Food>> {
  CartNotifier() : super([]);

  void addToCart(Food food) {
    state = [...state, food];
  }

  void removeCard(Food food) {
    final List<Food> newState = [...state];
    final index = newState.indexOf(food);

    if (index != -1) {
      newState.removeAt(index);
      state = newState;
    }
  }

  void clearCart() {
    state = [];
  }
}

Map<Food, int> countFoodItems(List<Food> items) {
  final Map<Food, int> counts = {};

  for (var food in items) {
    counts.update(food, (count) => count + 1, ifAbsent: () => 1);
  }

  return counts;
}
