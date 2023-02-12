import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_project_base/base/blocs/settings_bloc.dart';
import 'package:flutter_project_base/config/app_states.dart';
import 'package:flutter_project_base/config/database_table_names.dart';
import 'package:flutter_project_base/handlers/local_database_hendler.dart';
import 'package:flutter_project_base/handlers/shared_handler.dart';
import 'package:flutter_project_base/network/network_handler.dart';
import 'package:flutter_project_base/routers/navigator.dart';
import 'package:flutter_project_base/routers/routers.dart';
import 'package:flutter_project_base/utilities/theme/colors/colors.dart';
import 'config/app_blocs_provider.dart';
import 'handlers/localization_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHandler.init();
  await LocaleDatabaseHadnler.localDatabaseHelper.initDatabase(intialTableName: TablesNames().praysTable);
  NetworkHandler.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: ProviderList.providers,
      child: BlocBuilder<SettingsBloc, AppStates>(
        builder: (context, state) {
          ColorsTheme theme = (state as SettingsDone).theme;
          String lang = (state as SettingsDone).lang;
          return MaterialApp(
            title: 'Warood',
            theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
              dividerColor: theme.borderColor,
              fontFamily: lang == "en" ? "poppins" : "amiri_quran",
              snackBarTheme: SnackBarThemeData(backgroundColor: theme.primary),
              primaryColor: theme.primary,
              errorColor: theme.error,
              backgroundColor: theme.background,
              appBarTheme: AppBarTheme(backgroundColor: theme.primary, elevation: 0),
              drawerTheme: DrawerThemeData(backgroundColor: theme.background),
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
            locale: Locale(lang),
          );
        },
      ),
    );
  }
}
