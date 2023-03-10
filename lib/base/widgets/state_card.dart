import 'package:flutter/material.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

class StateCard extends StatelessWidget {
  const StateCard({super.key, required this.state});
  final PrayState state;
  Color _stateColorMapper() {
    switch (state) {
      case PrayState.started:
        return Color(0xffD7AD09);
      case PrayState.notStarted:
        return Color(0xffF5F5F5);
      case PrayState.checked:
        return Color(0xff41BF2D);
      case PrayState.ended:
        return Color(0xffDF4759);
    }
  }

  String _stateNameMapper() {
    switch (state) {
      case PrayState.started:
        return "Started";
      case PrayState.notStarted:
        return "No Started";
      case PrayState.checked:
        return "Checked";
      case PrayState.ended:
        return "Passed";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: _stateColorMapper().withOpacity(.1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 32,
      child: Center(
        child: Text(
          _stateNameMapper(),
          style: AppTextStyles.w600.copyWith(fontSize: 12, color: _stateColorMapper()),
        ),
      ),
    );
  }
}

enum PrayState { started, ended, notStarted, checked }
