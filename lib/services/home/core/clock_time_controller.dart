import 'dart:async';

class ClockTimeController {
  // Veriables
  Timer? timer;
  int seconds = 0, minutes = 0, hours = 0;
  // Functions
  void _getCurrentTime() {
    DateTime date = DateTime.now();
    seconds = date.second;
    minutes = date.minute;
    hours = date.hour;
  }

  start({Function()? onTimeChange}) {
    if (timer != null && timer!.isActive) timer!.cancel();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _getCurrentTime();
        if (onTimeChange != null) onTimeChange();
      },
    );
  }
}
