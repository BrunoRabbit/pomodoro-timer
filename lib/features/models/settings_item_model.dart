import 'package:flutter/material.dart';

class SettingsItemModel {
  SettingsItemModel({
    required this.title,
    this.subTitle,
    required this.onPress,
  });

  String title;
  String? subTitle;
  Function(TextEditingController) onPress;
}
