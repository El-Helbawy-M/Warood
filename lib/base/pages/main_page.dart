import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/handlers/icon_handler.dart';
import 'package:flutter_project_base/services/home/pages/home_page.dart';
import 'package:flutter_project_base/services/trace_schedule/bloc/schedule_prays_checks_bloc.dart';
import 'package:flutter_project_base/utilities/theme/media.dart';

import '../../config/app_events.dart';
import '../../services/more/pages/more_page..dart';
import '../../services/trace_schedule/page/trace_schedule_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  String _mapIcon(int index, String icon) {
    if (_index == index) return "navigation_icons/${icon}_bold";
    return "navigation_icons/${icon}_outline";
  }

  Color _mapColor(int index, BuildContext context) {
    if (_index == index) return Theme.of(context).bottomNavigationBarTheme.selectedItemColor!;
    return Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!;
  }

  List<Widget> screen = [
    const HomePage(),
    const TraceSchedulePage(),
    MorePage(),
  ];

  @override
  void initState() {
    super.initState();
    SchedulePraysChecksBloc.instance.add(Get());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaHelper.width,
        height: MediaHelper.height,
        child: BlocBuilder<SettingsBloc, AppStates>(
          builder: (context, state) {
            return screen[_index];
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        onTap: (value) => setState(() {
          _index = value;
        }),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: drawSvgIcon(_mapIcon(0, "home"), iconColor: _mapColor(0, context)), label: "الرئيسية"),
          BottomNavigationBarItem(icon: drawSvgIcon(_mapIcon(1, "calendar"), iconColor: _mapColor(1, context)), label: "الجدول"),
          BottomNavigationBarItem(icon: drawSvgIcon(_mapIcon(2, "more"), iconColor: _mapColor(2, context)), label: "المزيد"),
        ],
      ),
    );
  }
}
