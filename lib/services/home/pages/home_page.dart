import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_check_bloc.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_time_bloc.dart';
import 'package:flutter_project_base/base/models/pray_model.dart';
import 'package:flutter_project_base/utilities/components/custom_btn.dart';
import 'package:flutter_project_base/utilities/theme/media.dart';
import 'package:lottie/lottie.dart';
import '../../../base/pages/empty_view.dart';
import '../../../config/app_events.dart';
import '../models/prayer_time_model.dart';
import '../widgets/home_timer_view.dart';
import '../widgets/pray_card_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, AppStates>(
      builder: (context, state) {
        return Stack(
          children: [
            // Prauies list
            Column(
              children: [
                const SizedBox(height: 270),
                Expanded(
                  child: BlocBuilder<PrayTimeBloc, AppStates>(
                    builder: (context, state) {
                      PrayerTimeModel? model;
                      if (state is Done) {
                        model = state.model as PrayerTimeModel;
                        return BlocBuilder<PrayCheckBloc, AppStates>(
                          builder: (context, state) {
                            if (state is Done) {
                              DayPraysModel praysChecks = state.data as DayPraysModel;
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 16),
                                      ...List.generate(
                                        5,
                                        (index) => PrayCardView(
                                          name: model!.timings!.praysNames[index],
                                          time: model.timings!.praysTimes[index],
                                          isChecked: praysChecks.checks[index],
                                          nextPrayTime: model.timings!.praysTimes[index == 4 ? 0 : index + 1],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      } else if (state is Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is Empty) {
                        return const EmptyView();
                      } else if (state is NoLocation) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: CustomBtn(
                              text: 'Enable Location',
                              height: 56,
                              width: MediaHelper.width,
                              radius: 8,
                              onTap: () {
                                PrayTimeBloc.instance.add(Get());
                              },
                            ),
                          ),
                        );
                      } else if (state is Error) {
                        return const Center(
                          child: Text('Error'),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),

            // Home Timer
            const HomeTimerView(),
          ],
        );
      },
    );
  }
}
