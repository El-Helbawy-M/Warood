import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_base/base/blocs/lang_bloc.dart';
import 'package:flutter_project_base/base/blocs/theme_bloc.dart';
import 'package:flutter_project_base/handlers/shared_handler.dart';
import 'package:flutter_project_base/network/network_handler.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/routers/routers.dart';
import 'package:flutter_project_base/utilities/theme/colors/colors.dart';
import 'package:flutter_project_base/utilities/theme/colors/light_theme.dart';

import 'handlers/localization_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHandler.init();
  NetworkHandler.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    langBloc.initLang();
    themeBloc.initTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: langBloc.langStream,
      builder: (context, snapshot) {
        return StreamBuilder<ColorsTheme?>(
            stream: themeBloc.themeStream,
            builder: (context, snapshot) {
              ColorsTheme theme = themeBloc.theme.valueOrNull ?? LightTheme();
              return MaterialApp(
                title: 'Project Title',
                theme: ThemeData(
                  pageTransitionsTheme: const PageTransitionsTheme(
                    builders: {
                      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    },
                  ),
                  colorScheme: ColorScheme(
                    primary: theme.primary,
                    onBackground: theme.background,
                    onError: theme.error,
                    onSecondary: theme.secondery,
                    onSurface: Colors.white,
                    background: theme.background,
                    secondary: theme.secondery,
                    surface: Color(0xFF0A0E21),
                    error: theme.error,
                    onPrimary: theme.primary,
                    brightness: Brightness.dark,
                  ),
                  // fontFamily: langBloc.lang.valueOrNull == 'en' ? "roboto" : "cairo",
                  scaffoldBackgroundColor: theme.background,
                ),
                debugShowCheckedModeBanner: false,
                initialRoute: Routes.splash,
                navigatorKey: CustomNavigator.navigatorState,
                navigatorObservers: [CustomNavigator.routeObserver],
                scaffoldMessengerKey: CustomNavigator.scaffoldState,
                onGenerateRoute: CustomNavigator.onCreateRoute,

                // to tell the app what the language should support
                supportedLocales: const [Locale("en"), Locale("ar")],

                // to tell the app what the components should follow the determined language
                localizationsDelegates: const [
                  AppLocale.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],

                // this is a callback, it's executed when the user open the app or change the localaization of the mobile
                // what is its jop?
                // : it cheks if what is the current language of the mobile and return it for the app to follow it
                // : it cheks too if the user specified any language he need even if it's not same as the mobile language is
                // localeResolutionCallback: (currentLang, supportedLangs) {
                //   // String? savedLgnCode = pref!.getString("lgnCode");
                //   if (currentLang != null) {
                //     for (Locale locale in supportedLangs) {
                //       if (locale.languageCode == currentLang.languageCode) return locale;
                //     }
                //   }
                //   return supportedLangs.first;
                // },
                locale: Locale(langBloc.lang.valueOrNull ?? "en"),
                home: const MyHomePage(title: 'Flutter Demo Home Page'),
              );
            });
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
