abstract class AppEvents {
  dynamic arguments;
  AppEvents({this.arguments});
}

class Click extends AppEvents {
  Click({dynamic arguments}) : super(arguments: arguments);
}

class Get extends AppEvents {
  Get({dynamic arguments}) : super(arguments: arguments);
}

class Init extends AppEvents {
  Init({dynamic arguments}) : super(arguments: arguments);
}

class Update extends AppEvents {
  Update({dynamic arguments}) : super(arguments: arguments);
}
