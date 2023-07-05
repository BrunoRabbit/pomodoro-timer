import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/shared/widgets/custom_button.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({
    Key? key,
    required this.onPress,
    required this.controller,
    required this.formKey,
    required this.index,
    required this.model,
  }) : super(key: key);

  final Function(TextEditingController) onPress;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final int index;
  final LanguageModel model;

  static const int maxCharactersMin = 4;
  static const int maxCharactersCycle = 3;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.kScaffoldPrimary,
              AppColors.kScaffoldSecondary,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 2,
            top: 12,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.inputTitleMinutes,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.85),
                    fontSize: FontSizes.medium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    maxLength:
                        index == 2 ? maxCharactersCycle : maxCharactersMin,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(
                        index != 2 ? r'^[0-9.]+$' : r'[0-9]',
                      )),
                    ],
                    validator: (text) {
                      if (text!.isNotEmpty) {
                        return null;
                      }
                      return model.inputError;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      fillColor: AppColors.kCardBackground,
                      labelText: 'Ex: 10',
                      labelStyle: TextStyle(
                        color: Colors.white.withOpacity(.55),
                      ),
                      errorStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      counterStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: AppColors.kLinesColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: AppColors.kLinesColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onPress(controller);
                        context.router.pop();
                      }
                    },
                    title: model.inputSaveButton,
                    isWorking: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
