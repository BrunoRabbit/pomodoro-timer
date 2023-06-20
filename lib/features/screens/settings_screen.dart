import 'package:auto_route/auto_route.dart';
import 'package:pomodoro_timer/features/models/section_list_model.dart';
import 'package:pomodoro_timer/features/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/widgets/settings_section.dart';
import 'package:pomodoro_timer/features/controllers/settings_controller.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController settings = Provider.of<SettingsController>(context);

    List<SectionListModel> sectionList = settings.settingsSections();

    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Configurações',
          style: TextStyle(
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
