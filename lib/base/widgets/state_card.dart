import 'package:flutter/material.dart';
import 'package:flutter_project_base/utilities/theme/text_styles.dart';

class StateCard extends StatelessWidget {
  const StateCard({super.key, required this.state});
  final PrayState state;
  Color _stateColorMapper(BuildContext context) {
    switch (state) {
      case PrayState.started:
        return const Color(0xffD7AD09);
      case PrayState.notStarted:
        return Theme.of(context).cardColor;
      case PrayState.checked:
        return const Color(0xff41BF2D);
      case PrayState.ended:
        return Theme.of(context).colorScheme.error;
    }
  }

  String _stateNameMapper() {
    switch (state) {
      case PrayState.started:
        return "اذنت";
      case PrayState.notStarted:
        return "لم تأذن";
      case PrayState.checked:
        return "تمت بحمد الله";
      case PrayState.ended:
        return "فاتت";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: _stateColorMapper(context).withOpacity(.1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 32,
      child: Center(
        child: Text(
          _stateNameMapper(),
          style: AppTextStyles.w600.copyWith(fontSize: 12, color: Colors.black),
        ),
      ),
    );
  }
}

enum PrayState { started, ended, notStarted, checked }
