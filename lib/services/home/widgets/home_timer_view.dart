import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/handlers/localization_handler.dart';
import 'package:flutter_project_base/services/home/Blocs/home_bloc.dart';
import 'package:flutter_project_base/utilities/theme/colors.dart';
import '../../../base/blocs/settings_bloc.dart';
import '../../../config/app_states.dart';
import '../../../handlers/icon_handler.dart';
import '../../../utilities/theme/media.dart';
import '../Blocs/pray_check_bloc.dart';
import '../Blocs/pray_time_bloc.dart';
import '../../../base/models/pray_model.dart';
import '../models/prayer_time_model.dart';
import '../models/timings_model.dart';

class HomeTimerView extends StatelessWidget {
  const HomeTimerView({
    Key? key,
  }) : super(key: key);

  String _fetchNextPray(Timings timings) {
    for (int x = 0; x < timings.praysTimes.length; x++) {
      List<String> timeSplit = timings.praysTimes[x].split(":");

      int hours = int.parse(timeSplit[0]);
      int minutes = int.parse(timeSplit[1]);

      DateTime currentTime = DateTime.now();
      if (currentTime.hour == hours) {
        if (currentTime.minute <= minutes) {
          return timings.praysNames[x];
        }
      } else if (currentTime.hour < hours) {
        return timings.praysNames[x];
      }
    }
    return timings.praysNames[0];
  }

  String _fetchRemainTime(Timings timings) {
    DateTime currentTime = DateTime.now();
    for (int x = 0; x < timings.praysTimes.length; x++) {
      List<String> timeSplit = timings.praysTimes[x].split(":");

      int hours = int.parse(timeSplit[0]);
      int minutes = int.parse(timeSplit[1]);
      if (currentTime.hour == hours) {
        if (currentTime.minute <= minutes) {
          return "متبقي ${minutes - currentTime.minute} د";
        }
      } else if (currentTime.hour < hours) {
        return "متبقي ${hours - currentTime.hour} ساعات و ${minutes - currentTime.minute} د";
      }
    }
    List<String> timeSplit = timings.praysTimes[0].split(":");
    return "متبقي ${currentTime.hour < 24 ? ((24 - currentTime.hour) + int.parse(timeSplit[0])) : int.parse(timeSplit[0]) - currentTime.hour} ساعات و ${int.parse(timeSplit[1]) - currentTime.hour} د";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, AppStates>(
      builder: (context, state) {
        return Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 284,
              width: MediaHelper.width,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/${SettingsBloc.instance.settingsModel.theme == ColorsThemeType.lightTheme ? "main_light_bg" : "main_dark_bg"}.png"), fit: BoxFit.cover),
              ),
            ),
            Opacity(
              opacity: .4,
              child: Image.asset(
                "assets/images/mosque_vectors.png",
                width: 198,
                height: 192,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaHelper.width,
                height: 284,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                    Theme.of(context).primaryColor.withOpacity(.1),
                    Colors.transparent,
                    Colors.transparent,
                  ]),
                ),
              ),
            ),
            BlocBuilder<PrayTimeBloc, AppStates>(
              builder: (context, state) {
                PrayerTimeModel? model;
                if (state is Done) {
                  model = state.model as PrayerTimeModel;
                  return Container(
                    height: 284,
                    width: MediaHelper.width,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 50),
                              Text("الصلاة التالية", style: Theme.of(context).textTheme.titleSmall),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(getLang(_fetchNextPray(model.timings!).toLowerCase()), style: Theme.of(context).textTheme.bodyLarge),
                              ),
                              Row(
                                children: [
                                  drawSvgIcon("timer", width: 16, height: 16),
                                  const SizedBox(width: 8),
                                  Text(_fetchRemainTime(model.timings!), style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 12)),
                                ],
                              ),
                              const SizedBox(height: 64),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("صلاوات اليوم", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14)),
                            BlocBuilder<PrayCheckBloc, AppStates>(
                              builder: (context, state) {
                                if (state is Done) {
                                  DayPraysModel praysChecks = state.data as DayPraysModel;
                                  return Text("${praysChecks.checkedPraysNum} من أصل 5", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700));
                                }
                                return Text("1 من أصل 5", style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (state is Error) {
                  return const Center(child: Text("Error"));
                }
                return const SizedBox();
              },
            ),
          ],
        );
      },
    );
  }
}
