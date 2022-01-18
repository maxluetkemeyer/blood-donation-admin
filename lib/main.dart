import 'package:blooddonation_admin/services/logging_service.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blooddonation_admin/app.dart';
import 'package:blooddonation_admin/misc/theme.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:blooddonation_admin/tester.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Services
  ProviderService();
  //BackendService();
  CalendarService();
  CapacityService();
  LoggingService();
  SettingService();


  // Test Data
  for (int i = 0; i < 1000;i++){
    LoggingService().addEvent(DateTime.now().toString());
  }
  addTestAppointments();
  addTestRequests();
  addTestPlannerEvents();
  addTestSettings();

  runApp(const MainWidget());
}

/// The top widget in the widget tree of the program
class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: ProviderService().container,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          //Locale('de', ''), // German, no country code
        ],
        onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
        theme: lightTheme,
        darkTheme: darkTheme,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        ),
        locale: const Locale("en"),
        home: const App(),
      ),
    );
  }
}
