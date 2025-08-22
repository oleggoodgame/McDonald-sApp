import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mc_donalds/models/profile_model.dart';
import 'package:mc_donalds/models/vaucher_model.dart';

class ProfileProvider extends StateNotifier<Profile> {
  ProfileProvider()
    : super(
        Profile(
          firstName: "",
          lastName: "",
          birthDate: null,
          gender: Gender.male,
          email: '',
        ),
      );

  void updateProfile({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? birthDate,
    Gender? gender,
  }) {
    state = state.copyWith(
      firstName: firstName,
      lastName: lastName,
      email: email,
      birthDate: birthDate,
      gender: gender,
    );
  }

  void activateVaucher(Vaucher vaucher) {
    if (!state.activeVauchers.contains(vaucher)) {
      state = state.copyWith(
        activeVauchers: [...state.activeVauchers, vaucher],
      );
    }
  }

  void deactivateVaucher(Vaucher vaucher) {
    state = state.copyWith(
      activeVauchers: state.activeVauchers
          .where((v) => v.title != vaucher.title)
          .toList(),
    );
  }

  bool isVaucherActive(String title) {
    return state.activeVauchers.any((v) => v.title == title);
  }
}

final profileProvider = StateNotifierProvider<ProfileProvider, Profile>(
  (ref) => ProfileProvider(),
);
