import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_project_base/base/models/settings_model.dart';
import 'package:flutter_project_base/handlers/icon_handler.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/utilities/components/custom_page_body.dart';
import 'package:flutter_project_base/utilities/theme/colors.dart';
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
    return StreamBuilder<SettingsModel?>(
        stream: settings.settingsModelStream,
        builder: (context, snapshot) {
          return CustomPageBody(
            appBar: AppBar(
              title: Text(getLang("app_settings")),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // for change the theme
                  SwitchListTile(
                    value: settings.settingsModel.valueOrNull!.theme == ColorsThemeType.darkTheme,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (check) {
                      if (!check) {
                        settings.updateTheme = ColorsThemeType.lightTheme;
                      } else {
                        settings.updateTheme = ColorsThemeType.darkTheme;
                      }
                      Phoenix.rebirth(context);
                    },
                    title: Text("Dark Mode", style: AppTextStyles.w500.copyWith(fontSize: 14)),
                  ),
                  const Divider(height: 0),
                  // for change the lang
                  ListTile(
                    onTap: () {
                      settings.updateLang = settings.settingsModel.valueOrNull!.lang == "en" ? "ar" : "en";
                      Phoenix.rebirth(context);
                    },
                    leading: drawSvgIcon("lang", iconColor: Theme.of(context).primaryColor),
                    title: Text("Change language", style: AppTextStyles.w500.copyWith(fontSize: 14)),
                    trailing: Text(settings.settingsModel.valueOrNull!.lang == "en" ? "Englisth" : "??????????????", style: AppTextStyles.w500.copyWith(fontSize: 14, color: Theme.of(context).hintColor)),
                  ),
                  const Divider(height: 0),
                ],
              ),
            ),
          );
        });
  }
}
