import 'package:auto_route/auto_route.dart';
import 'package:pomodoro_timer/core/utils/extensions/translate_helper.dart';
import 'package:pomodoro_timer/features/settings_feature/model/section_list_model.dart';
import 'package:pomodoro_timer/features/settings_feature/view/widgets/settings_section.dart';
import 'package:pomodoro_timer/shared/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/settings_feature/view_model/settings_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsViewModel viewModel = Provider.of<SettingsViewModel>(context);

    List<SectionListModel> sectionList = viewModel.settingsSections(context);

    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'settings_title'.pdfString(context),
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
                itemCount: sectionList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return SettingsSection(index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
