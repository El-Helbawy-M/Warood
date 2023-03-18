import 'package:flutter/material.dart';
import 'package:flutter_project_base/handlers/icon_handler.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/routers/routers.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

class AppDrawer extends StatelessWidget with MenuOptionsActions {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            //app setting options
            const DrawerPartHeader(header: "App Options"),
            DrawerMenuOption(iconName: "gallery", label: getLang("gallery"), onTap: goToGallery),
            DrawerMenuOption(iconName: "settings", label: getLang("settings"), onTap: goToSettings),
            DrawerMenuOption(iconName: "rate", label: getLang("rate"), onTap: goToSettings),
          ],
        ),
      ),
    );
  }
}

class DrawerMenuOption extends StatelessWidget {
  const DrawerMenuOption({Key? key, required this.iconName, required this.label, required this.onTap}) : super(key: key);
  final String iconName, label;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: drawSvgIcon("drawer_icons/$iconName", iconColor: Theme.of(context).primaryColor),
      minLeadingWidth: 24,
      title: Text(
        label,
        style: AppTextStyles.w500.copyWith(fontSize: 16),
      ),
    );
  }
}

class DrawerPartHeader extends StatelessWidget {
  const DrawerPartHeader({Key? key, required this.header}) : super(key: key);
  final String header;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              header,
              style: AppTextStyles.w600.copyWith(fontSize: 18),
            ),
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}

mixin MenuOptionsActions {
  goToSettings() {
    CustomNavigator.pop();
    CustomNavigator.push(Routes.settings);
  }

  goToGallery() {
    CustomNavigator.pop();
    CustomNavigator.push(Routes.gallery);
  }
}
