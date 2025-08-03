import 'package:flutter/material.dart';

enum TypeMore {
  Profile,
  Site,
  Instagram,
  Facebook,
  Feedback,
  Information,
  ChangeCountry,
}
abstract class HasIconTitle {
  String get title;
  IconData get icon;
}

enum TypeProfileAction { View, Change, Edit, Share, Delete }

class More implements HasIconTitle {
  final String title;
  final IconData icon;
  final TypeMore type;

  const More(this.title, this.icon, this.type);
}

class ProfileAction implements HasIconTitle {
  final String title;
  final IconData icon;
  final TypeProfileAction type;

  const ProfileAction(this.title, this.icon, this.type);
}

