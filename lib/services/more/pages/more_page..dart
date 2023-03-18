// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/handlers/icon_handler.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/routers/routers.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatelessWidget {
  MorePage({super.key});
  final Map<String, Function()> moreOptions = {
    "المعرض": () => CustomNavigator.push(Routes.gallery),
    // "الاعدادات": () => CustomNavigator.push(Routes.settings),
    "سبحة الكترونية": () => CustomNavigator.push(Routes.digitalCounter),
    "تقيم": () {
      try {
        launchUrl(
          Uri.parse("https://docs.google.com/forms/d/1Ee0yq2MKlmJr6kNTZokQ7JkwM8t4P-DWs63l2cnQXBs/edit"),
          webOnlyWindowName: "Rate form",
        );
      } catch (e) {
        showDialog(
          context: CustomNavigator.navigatorState.currentContext!,
          builder: (context) => AlertDialog(
            title: const Text("خطا"),
            content: const Text("لا يمكن فتح الرابط"),
            actions: [TextButton(onPressed: () => CustomNavigator.pop(), child: const Text("حسنا"))],
          ),
        );
      }
    },
  };

  final List<String> moreOptionsIcons = [
    "gallery",
    // "settings",
    "digital_counter",
    "rate",
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, AppStates>(
      builder: (context, state) {
        return SafeArea(
          child: GridView.builder(
            itemCount: moreOptions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            padding: const EdgeInsets.all(24),
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: moreOptions.values.elementAt(index),
                child: BlocBuilder<SettingsBloc, AppStates>(builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.primary.withOpacity(.4)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        drawSvgIcon("more_icons/${moreOptionsIcons[index]}", iconColor: Theme.of(context).colorScheme.primary, width: 48, height: 48),
                        const SizedBox(height: 16),
                        Text(
                          moreOptions.keys.elementAt(index),
                          style: AppTextStyles.w600.copyWith(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                        )
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        );
      },
    );
  }
}
