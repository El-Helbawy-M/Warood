abstract class AppEvents {
  dynamic arguments;
  AppEvents({this.arguments});
}

class Click extends AppEvents {
  Click({dynamic arguments}) : super(arguments: arguments);
}

class GetDay extends AppEvents {
  GetDay({dynamic arguments}) : super(arguments: arguments);
}

class Get extends AppEvents {
  Get({dynamic arguments}) : super(arguments: arguments);
}

class Init extends AppEvents {
  Init({dynamic arguments}) : super(arguments: arguments);
}

class UpdateData extends AppEvents {
  UpdateData({dynamic arguments}) : super(arguments: arguments);
}

class UpdateView extends AppEvents {
  UpdateView({dynamic arguments}) : super(arguments: arguments);
}

class SetState extends AppEvents {
  SetState({dynamic arguments}) : super(arguments: arguments);
}
