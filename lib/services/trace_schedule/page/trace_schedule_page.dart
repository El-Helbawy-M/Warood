import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/config/app_events.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/debug/log_printer.dart';
import 'package:flutter_project_base/services/trace_schedule/bloc/schedule_prays_checks_bloc.dart';
import 'package:flutter_project_base/services/trace_schedule/widgets/pray_card.dart';
import 'package:flutter_project_base/utilities/components/custom_page_body.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../base/models/pray_model.dart';
import '../../home/Blocs/pray_time_bloc.dart';
import '../../home/models/prayer_time_model.dart';

class TraceSchedulePage extends StatefulWidget {
  const TraceSchedulePage({super.key});

  @override
  State<TraceSchedulePage> createState() => _TraceSchedulePageState();
}

class _TraceSchedulePageState extends State<TraceSchedulePage> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<SchedulePraysChecksBloc>(context);
    date ??= bloc.selectedDateTime;
    return BlocBuilder<SettingsBloc, AppStates>(
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime(1990, 5, 1),
                  focusedDay: date ?? bloc.selectedDateTime,
                  lastDay: DateTime.now(),
                  locale: "ar",
                  weekendDays: const [],
                  rowHeight: 56,
                  startingDayOfWeek: StartingDayOfWeek.saturday,
                  availableCalendarFormats: const {CalendarFormat.month: 'month'},
                  headerStyle: HeaderStyle(titleCentered: true, titleTextStyle: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary)),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
                    todayDecoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
                    markerDecoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, shape: BoxShape.circle),
                    selectedDecoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, shape: BoxShape.circle),
                  ),
                  selectedDayPredicate: (day) => date == day,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      date = selectedDay;
                    });
                    bloc.add(GetDay(arguments: selectedDay));
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<SchedulePraysChecksBloc, AppStates>(
                  builder: (context, state) {
                    if (state is Done) {
                      DayPraysModel day = state.data as DayPraysModel;

                      return BlocBuilder<PrayTimeBloc, AppStates>(
                        builder: (context, state) {
                          if (state is Done) {
                            PrayerTimeModel? model = state.model as PrayerTimeModel;
                            return Column(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => PrayCard(
                                    prayName: model.timings!.praysNames[index],
                                    time: model.timings!.praysTimes[index],
                                    checkedDate: day.checksDates[index],
                                    isChecked: day.checks[index],
                                    model: day,
                                    selectedDate: date ?? bloc.selectedDateTime,
                                  ),
                                ),
                              ],
                            );
                          } else if (state is Loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is Empty) {
                            return Container();
                          } else if (state is Error) {
                            return Container();
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else if (state is Empty) {
                      return Container();
                    } else if (state is Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// selectedDayPredicate: (value) {
//                       String month = DateFormat("MMMM").format(value);
//                       String day = DateFormat("EEEE").format(value);
//                       String year = DateFormat("y").format(value);
//                       if (bloc.repo.indexOf(day, month, year) != -1) return true;
//                       return false;
//                     },