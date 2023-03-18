import 'package:firebase_core/firebase_core.dart';
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
import 'package:flutter_project_base/services/trace_schedule/page/trace_schedule_page.dart';
import 'package:flutter_project_base/utilities/theme/colors.dart';
import 'config/app_blocs_provider.dart';
import 'firebase_options.dart';
import 'handlers/firebase_notification_handler.dart';
import 'handlers/localization_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHandler.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotifications.init();
  await LocaleDatabaseHadnler.localDatabaseHelper.initDatabase(intialTableName: TablesNames().praysTable);

  NetworkHandler.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // create: (context) => SubjectBloc(),
      providers: ProviderList.providers,
      child: const LunchPage(),
    );
  }
}

class LunchPage extends StatelessWidget {
  const LunchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, AppStates>(
      builder: (context, state) {
        return MaterialApp(
          home: const TraceSchedulePage(),
          title: 'Warood',
          theme: ColoresThemes().mapColor(BlocProvider.of<SettingsBloc>(context).settingsModel.theme, "amiri_quran"), //lang == "en" ? "poppins" :
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
          navigatorKey: CustomNavigator.navigatorState,
          navigatorObservers: [CustomNavigator.routeObserver],
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
          locale: const Locale("ar"),
        );
      },
    );
  }
}
