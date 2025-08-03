import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/data/data.dart';
import 'package:mc_donalds/models/foods_model.dart';


final foodFilter = StateProvider((_) => TypeFood.Burgers);

final filteredTodos = Provider<List<Food>>((ref) {
  final filter = ref.watch(foodFilter);

  switch (filter) {
    case TypeFood.Burgers:
      return list_burgers;
    case TypeFood.Fries_and_Snacks:
      return list_of_Fries_and_Snacks;
    case TypeFood.Drink:
      return list_drinks;

    case TypeFood.Side:
      return list_sides;
  }
});


