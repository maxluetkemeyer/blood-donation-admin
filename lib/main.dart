import 'dart:html';
import 'dart:ui' as ui;

import 'package:blooddonation_admin/connection_view/connetion_view.dart';
import 'package:blooddonation_admin/services/backend/backend_service.dart';
import 'package:blooddonation_admin/services/logging_service.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blooddonation_admin/misc/theme.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  IFrameElement ifE = IFrameElement()
    ..width = "640"
    ..height = "360"
    //..src = "https://github.com/maxluetkemeyer/blood-donation-app/wiki"
    ..src = "https://www.wi.uni-muenster.de/"
    ..style.border = "none";
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory('github-wiki', (_) => ifE);

  //Services
  ProviderService();
  BackendService();
  CalendarService();
  CapacityService();
  LoggingService();
  SettingService();

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
        home: const ConnectionView(),
      ),
    );
  }
}
