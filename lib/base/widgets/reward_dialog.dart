import 'package:flutter/material.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/handlers/icon_handler.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/utilities/theme/media.dart';

import '../../routers/navigator.dart';
import '../../utilities/components/custom_btn.dart';
import '../../utilities/theme/text_styles.dart';

class RewardDialog extends StatelessWidget {
  const RewardDialog({Key? key, required this.imageName, required this.mainText, required this.subText, this.actionBtnName, this.okBtnName, this.onActionClick, this.onOkClick}) : super(key: key);
  final String imageName;
  final String mainText, subText;
  final String? actionBtnName, okBtnName;
  final Function()? onActionClick, onOkClick;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          children: [
            Column(
              children: [
                Align(alignment: Alignment.bottomRight, child: drawSvgIcon("close_circle", iconColor: settings.settingsModel.valueOrNull!.theme.primary)),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaHelper.width(context),
                      height: 224,
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/reward_bg.jpg"), fit: BoxFit.cover)),
                    ),
                    drawSvgIcon("rewards/$imageName", width: 200, height: 200),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  mainText,
                  style: AppTextStyles.w600.copyWith(fontSize: 24, color: settings.settingsModel.valueOrNull!.theme.primary),
                ),
                Text(
                  subText,
                  style: AppTextStyles.w500.copyWith(fontSize: 12, color: settings.settingsModel.valueOrNull!.theme.greyTitle),
                ),
                const SizedBox(height: 32),
                CustomBtn(
                  height: 56,
                  text: getLang("thank_god"),
                  radius: 10,
                  onTap: () => CustomNavigator.pop(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
