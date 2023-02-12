import 'package:flutter/material.dart';
import 'colors.dart';

class LightTheme implements ColorsTheme {
  @override
  Color borderColor = const Color(0xffE7E7E7);

  @override
  Color primary = const Color(0xff8cbbf1);

  @override
  Color secondery = const Color(0xfffceecb);

  @override
  @override
  Color greyTitle = const Color(0xff737373);

  @override
  Color background = Colors.white;

  @override
  Color error = const Color(0xffF70000);

  @override
  Color inactiveProgress = const Color(0xffE7E7E7);

  @override
  Color mainTextColor = const Color(0xff373737);

  @override
  Color hintTextColor = const Color(0xff737373);

  @override
  Color activeColor = const Color(0xff2FAB86);

  @override
  Color notStartedColor = const Color(0xff2C3639);

  @override
  Color pendingColor = const Color(0xffA6840A);

  @override
  Color inActiveColor = const Color(0xffDB5353);
}
