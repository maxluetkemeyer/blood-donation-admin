import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:blooddonation_admin/calendar_overview/calendar_overview_view.dart';
import 'package:blooddonation_admin/dashboard/dashboard_view.dart';
import 'package:blooddonation_admin/help/help_view.dart';
import 'package:blooddonation_admin/logging/logging_view.dart';
import 'package:blooddonation_admin/requests/requests_view.dart';
import 'package:blooddonation_admin/planner/planner_view.dart';
import 'package:blooddonation_admin/settings/settings_view.dart';

/// The structure of the program
///
/// It contains a list of all pages and an [AppBar] where these pages are selectable.
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// All pages of the program
  final List<Widget> screens = [
    const Dashboard(),
    const Requests(),
    const CalendarOverview(), //key: PageStorageKey("cO"),
    const Planner(),
    const SettingsView(),
    const LoggingView(),
    const Help(),
  ];

  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          TextButton.icon(
            onPressed: () => setState(() {
              screenIndex = 0;
            }),
            icon: const Icon(Icons.home_rounded),
            label: Text(AppLocalizations.of(context)!.navDashboard),
            style: screenIndex == 0 ? _buttonSelectedStyle : null,
          ),
          Stack(
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: SizedBox(
                  height: 60,
                  child: TextButton.icon(
                    onPressed: () => setState(() {
                      screenIndex = 1;
                    }),
                    icon: const Icon(Icons.table_chart),
                    label: Text(AppLocalizations.of(context)!.navRequests),
                    style: screenIndex == 1 ? _buttonSelectedStyle : null,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade400,
                  ),
                  child: const Text(
                    "18",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () => setState(() {
              screenIndex = 2;
            }),
            icon: const Icon(Icons.calendar_today_rounded),
            label: Text(AppLocalizations.of(context)!.navCalendar),
            style: screenIndex == 2 ? _buttonSelectedStyle : null,
          ),
          TextButton.icon(
            onPressed: () => setState(() {
              screenIndex = 3;
            }),
            icon: const Icon(Icons.schedule),
            label: Text(AppLocalizations.of(context)!.navPlanner),
            style: screenIndex == 3 ? _buttonSelectedStyle : null,
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_horiz),
            onSelected: (value) {
              switch (value) {
                case 0:
                  setState(() {
                    screenIndex = 4;
                  });
                  break;
                case 1:
                  setState(() {
                    screenIndex = 5;
                  });
                  break;
                case 2:
                  setState(() {
                    screenIndex = 6;
                  });
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(AppLocalizations.of(context)!.navSettings),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 1,
                child: Text(AppLocalizations.of(context)!.navLogging),
              ),
              const PopupMenuDivider(),
              PopupMenuItem(
                value: 2,
                child: Text(AppLocalizations.of(context)!.navHelp),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: screens[screenIndex],
      ),
    );
  }
}

ButtonStyle _buttonSelectedStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(233, 240, 243, 1)),
);
