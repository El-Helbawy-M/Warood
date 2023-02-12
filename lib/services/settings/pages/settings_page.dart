import 'package:flutter/material.dart';
import 'package:flutter_project_base/handlers/icon_handler.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/routers/routers.dart';
import 'package:flutter_project_base/utilities/components/custom_page_body.dart';
import 'package:flutter_project_base/utilities/theme/colors/colors.dart';
import 'package:flutter_project_base/utilities/theme/colors/dark_theme.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

import '../../../base/blocs/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomPageBody(
      appBar: AppBar(
        title: const Text("App Settings"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // for change the theme
            SwitchListTile(
              value: SettingsBloc.instance.theme is DarkTheme,
              activeColor: SettingsBloc.instance.theme.primary,
              onChanged: (check) {
                if (!check) {
                  SettingsBloc.instance.updateTheme = ColorsThemeType.lightTheme;
                } else {
                  SettingsBloc.instance.updateTheme = ColorsThemeType.darkTheme;
                }
                CustomNavigator.push(Routes.splash, clean: true);
              },
              title: Text("Dark Mode", style: AppTextStyles.w500.copyWith(fontSize: 14)),
            ),
            const Divider(height: 0),
            // for change the lang
            ListTile(
              onTap: () {
                SettingsBloc.instance.updateLang = SettingsBloc.instance.lang == "en" ? "ar" : "en";
                CustomNavigator.push(Routes.splash, clean: true);
              },
              leading: drawSvgIcon("lang"),
              title: Text("Change language", style: AppTextStyles.w500.copyWith(fontSize: 14)),
              trailing: Text(SettingsBloc.instance.lang == "en" ? "Englisth" : "العربية", style: AppTextStyles.w500.copyWith(fontSize: 14, color: SettingsBloc.instance.theme.hintTextColor)),
            ),
            const Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
