import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/base/widgets/app_drawer.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/services/home/Blocs/home_bloc.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_check_bloc.dart';
import 'package:flutter_project_base/services/home/Blocs/pray_time_bloc.dart';
import 'package:flutter_project_base/services/home/models/core_models/pray_model.dart';
import '../../../utilities/components/custom_page_body.dart';
import '../models/network_models/prayer_time_model.dart';
import '../widgets/home_timer_view.dart';
import '../widgets/pray_card_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPageBody(
      drawer: const AppDrawer(),
      appBar: AppBar(),
      body: Column(
        children: [
          // Home Timer
          BlocBuilder<HomeBloc, AppStates>(
            builder: (context, state) {
              if (state is Done) {
                return HomeTimerView(
                  date: state.mapedData!["date"],
                  clock: state.mapedData!["clock"],
                  clockType: state.mapedData!["clock_type"],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),

          // Prauies list
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
                        log_data(label: "Check data", data: praysChecks.fajrCheck);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(height: 4),
                                ...List.generate(
                                  5,
                                  (index) => PrayCardView(
                                    name: model!.timings!.praysNames[index],
                                    time: model.timings!.praysTimes[index],
                                    isChecked: praysChecks.checks[index],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
