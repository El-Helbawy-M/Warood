import 'package:flutter/material.dart';
import 'package:flutter_project_base/handlers/qr_code_scanner/qr_scanner_view.dart';
import 'package:flutter_project_base/routers/routers.dart';
import 'package:flutter_project_base/services/digital_counter/pages/digital_counter_page.dart';
import 'package:flutter_project_base/services/gallery/pages/gallery_page.dart';
import '../base/pages/main_page.dart';
import '../services/settings/pages/settings_page.dart';
import '../services/splash/pages/splash_page.dart';

const begin = Offset(0.0, 1.0);
const end = Offset.zero;
const curve = Curves.easeInOut;
var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static _pageRoute(Widget screen) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return _pageRoute(const SizedBox());
      case Routes.splash:
        return _pageRoute(const SplashPage());
      case Routes.qrScannerCode:
        return _pageRoute(const QrCodeScannerView());
      case Routes.main:
        return _pageRoute(const MainPage());
      case Routes.settings:
        return _pageRoute(const SettingsPage());
      case Routes.gallery:
        return _pageRoute(const GalleryPage());
      case Routes.digitalCounter:
        return _pageRoute(const DigitalCounterPage());
    }
    return MaterialPageRoute(builder: (_) => Container());
  }

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName, {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return navigatorState.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }
}
