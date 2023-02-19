import 'package:flutter/material.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

class StateCard extends StatelessWidget {
  const StateCard({super.key, required this.state});
  final PrayState state;
  Color _stateColorMapper() {
    switch (state) {
      case PrayState.started:
        return settings.settingsModel.valueOrNull!.theme.pendingColor;
      case PrayState.notStarted:
        return settings.settingsModel.valueOrNull!.theme.notStartedColor;
      case PrayState.checked:
        return settings.settingsModel.valueOrNull!.theme.activeColor;
      case PrayState.ended:
        return settings.settingsModel.valueOrNull!.theme.inActiveColor;
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
