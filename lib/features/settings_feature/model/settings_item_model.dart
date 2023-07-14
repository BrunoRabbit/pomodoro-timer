typedef OpenModalBottomSheet = void Function(double text);

class SettingsItemModel {
  SettingsItemModel({
    this.subTitle,
    required this.openModalBottomSheet,
  });

  String? subTitle;
  OpenModalBottomSheet openModalBottomSheet;
}
