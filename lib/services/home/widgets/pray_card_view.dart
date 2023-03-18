import 'package:flutter/material.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/handlers/icon_handler.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_check_bloc.dart';
import 'package:flutter_project_base/utilities/components/custom_btn.dart';
import '../../../base/widgets/reward_bottomsheet.dart';
import '../../../base/widgets/state_card.dart';
import '../../../routers/navigator.dart';
import '../../../utilities/theme/media.dart';
import '../../../utilities/theme/text_styles.dart';

class PrayCardView extends StatelessWidget {
  const PrayCardView({Key? key, required this.isChecked, required this.time, required this.name, required this.nextPrayTime}) : super(key: key);
  final bool isChecked;
  final String time;
  final String name;
  final String nextPrayTime;
  bool _compareTime(int hours, int minutes) {
    DateTime currentTime = DateTime.now();
    if (currentTime.hour == hours) {
      if (currentTime.minute >= minutes) {
        return true;
      }
    } else if (currentTime.hour > hours) {
      return true;
    }
    return false;
  }

  PrayState _generateState() {
    List<String> timeSplit = time.split(":"), nextTimeSplit = nextPrayTime.split(":");
    int hours = int.parse(timeSplit[0]);
    int minutes = int.parse(timeSplit[1]);
    int nextHours = int.parse(nextTimeSplit[0]);
    int nextMinutes = int.parse(nextTimeSplit[1]);
    bool isAfter = _compareTime(hours, minutes);

    if (isChecked) {
      return PrayState.checked;
    } else if (isAfter) {
      if (!(name == "Isha" && DateTime.now().hour > nextHours)) {
        if (_compareTime(nextHours, nextMinutes)) return PrayState.ended;
      }
      return PrayState.started;
    } else {
      return PrayState.notStarted;
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
    int hours = int.parse(time.split(":")[0]);
    return Container(
      height: (state == PrayState.started || state == PrayState.ended) && !isChecked ? 160 : 104,
      width: MediaHelper.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: (state == PrayState.started || state == PrayState.ended) && !isChecked ? Theme.of(context).cardColor : const Color(0x00EEEEEE)),
        // color: settings.settingsModel.valueOrNull!.theme.secondery,
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                drawSvgIcon(hours > 12 ? "moon" : "sun"),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getLang(name.toLowerCase()), style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text("$time ${hours > 12 ? "مساء" : "صباحا"}", style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                StateCard(state: state),
              ],
            ),
          ),
          Visibility(
            visible: (state == PrayState.started || state == PrayState.ended) && !isChecked,
            child: CustomBtn(
              height: 46,
              width: MediaHelper.width,
              text: "Check",
              onTap: () {
                PrayCheckBloc.instance.add(UpdateData(arguments: {"pray": _generatePrayType(), "date": DateTime.now()}));
              },
            ),
          ),
        ],
      ),
    );
  }
}
