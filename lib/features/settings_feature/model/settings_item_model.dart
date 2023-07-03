import 'package:flutter/material.dart';

typedef OpenModalBottomSheet = void Function(TextEditingController controller);

class SettingsItemModel {
  SettingsItemModel({
    this.subTitle,
    required this.openModalBottomSheet,
  });

  String? subTitle;
  OpenModalBottomSheet openModalBottomSheet;
}
