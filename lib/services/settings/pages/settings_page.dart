import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/base/models/settings_model.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/handlers/icon_handler.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/utilities/components/custom_page_body.dart';
import 'package:flutter_project_base/utilities/theme/colors.dart';
import 'package:flutter_project_base/utilities/theme/media.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, AppStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(getLang("app_settings"), style: Theme.of(context).appBarTheme.toolbarTextStyle),
          ),
          body: SizedBox(
            width: MediaHelper.width,
            height: MediaHelper.height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // for change the theme
                  SwitchListTile(
                    value: SettingsBloc.instance.settingsModel.theme == ColorsThemeType.darkTheme,
                    activeColor: Theme.of(context).iconTheme.color,
                    onChanged: (check) {
                      log_data(label: "theme", data: SettingsBloc.instance.settingsModel.theme);
                      if (SettingsBloc.instance.settingsModel.theme != ColorsThemeType.lightTheme) {
                        SettingsBloc.instance.updateTheme = ColorsThemeType.lightTheme;
                      } else {
                        SettingsBloc.instance.updateTheme = ColorsThemeType.darkTheme;
                      }
                    },
                    title: Text(
                      "Dark Mode",
                      style: AppTextStyles.w500.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  const Divider(height: 0),
                  // for change the lang
                  ListTile(
                    onTap: () {
                      SettingsBloc.instance.updateLang = SettingsBloc.instance.settingsModel.lang == "en" ? "ar" : "en";
                    },
                    leading: drawSvgIcon("lang", iconColor: Theme.of(context).iconTheme.color),
                    title: Text(
                      "Change language",
                      style: AppTextStyles.w500.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    trailing: Text(SettingsBloc.instance.settingsModel.lang == "en" ? "Englisth" : "العربية", style: AppTextStyles.w500.copyWith(fontSize: 14, color: Theme.of(context).iconTheme.color)),
                  ),
                  const Divider(height: 0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
