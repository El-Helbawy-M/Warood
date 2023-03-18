import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String get getMonth => DateFormat("MMMM").format(this);
  String get getYear => DateFormat("y").format(this);
  String get getDate => DateFormat("d").format(this) + "-" + this.month.toString() + "-" + DateFormat("y").format(this);
}
