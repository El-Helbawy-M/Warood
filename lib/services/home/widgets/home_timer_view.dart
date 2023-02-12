import 'package:flutter/material.dart';
import '../../../base/blocs/settings_bloc.dart';
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
      width: MediaHelper.width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: SettingsBloc.instance.theme.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(clockType, style: AppTextStyles.w700.copyWith(fontSize: 24, color: SettingsBloc.instance.theme.secondery)),
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
