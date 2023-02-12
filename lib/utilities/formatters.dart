class Formatter {
  String clockTimeFormat(int hours, int minutes, int seconds) => "${hours < 10 ? "0$hours" : hours} : ${minutes < 10 ? "0$minutes" : minutes} : ${seconds < 10 ? "0$seconds" : seconds}";
}
