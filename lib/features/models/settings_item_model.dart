import 'package:flutter/material.dart';

typedef OpenModalBottomSheet = void Function(TextEditingController controller);

class SettingsItemModel {
  SettingsItemModel({
    required this.title,
    this.subTitle,
    required this.openModalBottomSheet,
  });

  String title;
  String? subTitle;
  OpenModalBottomSheet openModalBottomSheet;
}
