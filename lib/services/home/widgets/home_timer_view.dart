import 'package:flutter/material.dart';
import 'package:flutter_project_base/utilities/theme/colors.dart';
import '../../../base/blocs/settings_bloc.dart';
import '../../../debug/log_printer.dart';
import '../../../handlers/icon_handler.dart';
import '../../../utilities/theme/media.dart';
import '../../../utilities/theme/text_styles.dart';
import '../Blocs/home_bloc.dart';
import 'home_day_date_view.dart';

class HomeTimerView extends StatelessWidget {
  const HomeTimerView({
    Key? key,
    required this.date,
    required this.clock,
    required this.clockType,
  }) : super(key: key);
  final String date, clock, clockType;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: MediaHelper.width(context),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor, image: DecorationImage(image: AssetImage("assets/images/${settings.settingsModel.valueOrNull!.theme == ColorsThemeType.lightTheme ? "main_light_bg" : "main_dark_bg"}.png"), fit: BoxFit.contain)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(clockType, style: AppTextStyles.w700.copyWith(fontSize: 24, color: Theme.of(context).colorScheme.secondary)),
              Text(clock, style: AppTextStyles.w700.copyWith(fontSize: 36, color: Colors.white)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: HomeDayDate(date: date),
          ),
          const SizedBox(height: 8),
          drawSvgIcon(HomeBloc.instance.clockController.hours >= 12 ? "night" : "morning"),
        ],
      ),
    );
  }
}
