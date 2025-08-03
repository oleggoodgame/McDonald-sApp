import 'package:mc_donalds/models/vaucher_model.dart';

enum Gender { male, female }

class Profile {
  String firstName;
  String lastName;
  String email;
  DateTime birthDate;
  Gender gender;

  List<Vaucher> activeVauchers;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
    required this.gender,
    List<Vaucher>? activeVauchers,
  }) : activeVauchers = activeVauchers ?? [];
  bool isVaucherActive(Vaucher vaucher) {
  return activeVauchers.contains(vaucher);
}
  //Якщо при створенні профілю ти передаєш список activeVauchers, він присвоюється полю.

  // Якщо ні (null), то робиться копія початкового списку vaucherList (імовірно, це глобальний список всіх ваучерів).

  // List.from() створює новий список з елементів vaucherList — щоб унікально зберігати для кожного профілю.
  Profile copyWith({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? birthDate,
    Gender? gender,
    List<Vaucher>? activeVauchers,
  }) {
    return Profile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      activeVauchers: activeVauchers ?? this.activeVauchers,
    );
  }
}
