import 'package:flutter/material.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_check_bloc.dart';
import 'package:flutter_project_base/utilities/components/custom_btn.dart';
import '../../../base/blocs/settings_bloc.dart';
import '../../../base/widgets/state_card.dart';
import '../../../utilities/theme/media.dart';
import '../../../utilities/theme/text_styles.dart';

class PrayCardView extends StatelessWidget {
  const PrayCardView({
    Key? key,
    required this.isChecked,
    required this.time,
    required this.name,
  }) : super(key: key);
  final bool isChecked;
  final String time;
  final String name;

  PrayState _generateState() {
    List<String> timeSplit = time.split(":");
    int hours = int.parse(timeSplit[0]);
    int minutes = int.parse(timeSplit[1]);

    DateTime currentTime = DateTime.now();
    bool isAfter = false;
    if (currentTime.hour == hours) {
      if (currentTime.minute >= minutes) {
        isAfter = true;
      }
    } else if (currentTime.hour > hours) {
      isAfter = true;
    }
    if (isChecked) {
      return PrayState.checked;
    } else {
      return isAfter ? PrayState.started : PrayState.notStarted;
    }
  }

  Pray _generatePrayType() {
    switch (name) {
      case "Fajr":
        return Pray.fajr;
      case "Dhuhr":
        return Pray.dhuhr;
      case "Asr":
        return Pray.asr;
      case "Maghrib":
        return Pray.maghrib;
      case "Isha":
        return Pray.isha;
      default:
        return Pray.fajr;
    }
  }

  @override
  Widget build(BuildContext context) {
    PrayState state = _generateState();
    log_data(label: "label", data: name.toLowerCase());
    return Container(
      height: state == PrayState.started && !isChecked ? 160 : 94,
      width: MediaHelper.width(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: settings.settingsModel.valueOrNull!.theme.borderColor),
        // color: settings.settingsModel.valueOrNull!.theme.secondery,
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(time, style: AppTextStyles.w500.copyWith(fontSize: 18, color: settings.settingsModel.valueOrNull!.theme.hintTextColor)),
                    Text(getLang(name.toLowerCase()), style: AppTextStyles.w700.copyWith(fontSize: 24, color: settings.settingsModel.valueOrNull!.theme.mainTextColor)),
                  ],
                ),
                StateCard(state: state),
              ],
            ),
          ),
          Visibility(
            visible: state == PrayState.started && !isChecked,
            child: CustomBtn(
              height: 46,
              width: MediaHelper.width(context),
              text: "Check",
              onTap: () {
                PrayCheckBloc.instance.add(Update(arguments: _generatePrayType()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
