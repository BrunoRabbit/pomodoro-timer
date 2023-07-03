import 'package:auto_route/auto_route.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/features/settings_feature/view/widgets/settings_section.dart';
import 'package:pomodoro_timer/shared/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/settings_feature/view_model/settings_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late LanguageModel _languageModel;
  late SettingsViewModel viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<SettingsViewModel>(context);

    _languageModel = MultiLanguagesImpl.of(context)!.instance();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _languageModel.settingsTitle,
          style: const TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            context.router.pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: _languageModel.settingsSection.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return SettingsSection(
                    index: index,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
