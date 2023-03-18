import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_check_bloc.dart';
import '../../../base/models/pray_model.dart';
import '../../../base/widgets/state_card.dart';
import '../../../config/app_events.dart';
import '../../../handlers/localization_handler.dart';
import '../../../utilities/components/custom_btn.dart';
import '../../../utilities/theme/media.dart';
import '../../../utilities/theme/text_styles.dart';

class PrayCard extends StatelessWidget {
  const PrayCard({
    super.key,
    required this.prayName,
    required this.checkedDate,
    required this.isChecked,
    required this.time,
    required this.model,
    required this.selectedDate,
  });
  final bool isChecked;
  final String time;
  final String? checkedDate;
  final String prayName;
  final DateTime selectedDate;
  final DayPraysModel model;

  bool _compareTime(int hours, int minutes, DateTime currentTime) {
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
    List<String> timeSplit = time.split(":");
    int hours = int.parse(timeSplit[0]);
    int minutes = int.parse(timeSplit[1]);
    bool isAfter = _compareTime(hours, minutes, selectedDate);
    if (isChecked) {
      return PrayState.checked;
    } else if (isAfter) {
      return PrayState.started;
    } else {
      DateTime dateTimeNow = DateTime.now();
      if (dateTimeNow.day != selectedDate.day || dateTimeNow.month != selectedDate.month || dateTimeNow.year != selectedDate.year) return PrayState.started;
      return PrayState.notStarted;
    }
  }

  Pray _generatePrayType() {
    switch (prayName) {
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
    return Container(
      height: 104,
      width: MediaHelper.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(width: 1, color: (state == PrayState.started || state == PrayState.ended) && !isChecked ? const Color(0xffE3CAA5).withOpacity(.5) : const Color(0xffEEEEEE)),
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
                AnimatedContainer(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isChecked ? Colors.green : Theme.of(context).colorScheme.error,
                  ),
                  duration: const Duration(
                    milliseconds: 800,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getLang(prayName.toLowerCase()), style: AppTextStyles.w600.copyWith(fontSize: 14, color: Colors.black)),
                      if (isChecked) const SizedBox(height: 8),
                      if (isChecked) Text(checkedDate ?? 'Not checked yet', style: Theme.of(context).textTheme.bodyMedium!),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedCrossFade(
                      firstChild: InkWell(
                        onTap: () {
                          PrayCheckBloc.instance.add(UpdateData(arguments: {"pray": _generatePrayType(), "date": selectedDate, "model": model}));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context).colorScheme.primary.withOpacity(.1),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 32,
                          child: Center(
                            child: Text(
                              "تأكيد",
                              style: AppTextStyles.w700.copyWith(fontSize: 14, color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                      secondChild: StateCard(state: state),
                      crossFadeState: (state == PrayState.started || state == PrayState.ended) && !isChecked ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 200),
                    ),

                    // Visibility(
                    //   visible: ,
                    //   child: CustomBtn(
                    //     height: 36,
                    //     width: 50,
                    //     text: "Check",
                    //     onTap: () {
                    //       PrayCheckBloc.instance.add(Update(arguments: _generatePrayType()));
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
