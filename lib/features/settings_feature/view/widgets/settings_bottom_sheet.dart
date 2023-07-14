import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/features/settings_feature/view_model/settings_view_model.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({
    Key? key,
    required this.onPress,
    required this.title,
    required this.model,
    required this.index,
  }) : super(key: key);

  final Function(double) onPress;
  final String title;
  final LanguageModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ? cancel, title, done and divider widget
          TitleWidget(
            title: title,
            model: model,
            onPress: onPress,
            itemSelected: viewModel.itemSelected,
          ),

          // ? picker
          SizedBox(
            height:
                MediaQuery.of(context).size.height / (isLandscape ? 1.65 : 3),
            child: CupertinoPicker(
              itemExtent: 32,
              looping: true,
              magnification: 1.2,
              squeeze: 1,
              useMagnifier: true,
              selectionOverlay: Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.black.withOpacity(.4),
                    ),
                  ),
                ),
              ),
              onSelectedItemChanged: index == 2
                  ? viewModel.updateCycle
                  : viewModel.updateItemSelected,
              children: index == 2
                  ? List<Widget>.generate(11, (index) {
                      return Center(child: Text('${(index)}'));
                    })
                  : List<Widget>.generate(12, (index) {
                      return Center(child: Text('${(index + 1) * 5} min'));
                    }),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.onPress,
    required this.title,
    required this.itemSelected,
    required this.model,
  }) : super(key: key);

  final Function(double) onPress;
  final String title;
  final int itemSelected;
  final LanguageModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  context.router.pop();
                },
                child: Text(
                  model.bottomSheetButtonCancel,
                  style: const TextStyle(
                    color: Color(0xff1A9FF3),
                    fontSize: FontSizes.large,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSizes.large,
                    color: Colors.black.withOpacity(.85),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  onPress(itemSelected.toDouble());
                },
                child: Text(
                  model.bottomSheetButtonDone,
                  style: const TextStyle(
                    color: Color(0xff1A9FF3),
                    fontSize: FontSizes.large,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black.withOpacity(.4),
          ),
        ],
      ),
    );
  }
}
