// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/shared/widgets/custom_button.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({
    Key? key,
    required this.onPress,
    required this.controller,
    required this.formKey,
  }) : super(key: key);

  final Function(TextEditingController) onPress;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

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
                  'Digite o tempo em minutos',
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
                    maxLength: 4,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]+$')),
                    ],
                    validator: (text) {
                      if (text!.isNotEmpty) {
                        return null;
                      }
                      return 'Este campo nao pode ser vazio';
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
                    title: 'Salvar',
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
