import 'package:badges/badges.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:blooddonation_admin/calendar_overview/calendar_overview_view.dart';
import 'package:blooddonation_admin/dashboard/dashboard_view.dart';
import 'package:blooddonation_admin/help/help_view.dart';
import 'package:blooddonation_admin/logging/logging_view.dart';
import 'package:blooddonation_admin/planner/planner_view.dart';
import 'package:blooddonation_admin/settings_view/settings_view.dart';
import 'package:blooddonation_admin/requests/requests_view.dart';

/// The structure of the program
///
/// It contains a list of all pages and an [AppBar] where these pages are selectable.
class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  /// All pages of the program
  final List<Widget> screens = [
    const Dashboard(),
    const Requests(),
    const CalendarOverview(),
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage("assets/images/logo_transparent.png"),
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(width: 20),
            Text(AppLocalizations.of(context)!.appTitle),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => setState(() {
              screenIndex = 0;
            }),
            icon: const Icon(Icons.home_rounded),
            label: Text(AppLocalizations.of(context)!.navDashboard),
            style: screenIndex == 0 ? _buttonSelectedStyle : null,
          ),
          RequestAppBarTab(
            screenIndex: screenIndex,
            cb: () {
              CalendarService().newAmount = 0;
              ref.read(newAppointmentsProvider.state).state = 0;

              if (screenIndex == 1) {
                ref.read(updateRequestViewProvider.state).state++;
              }

              setState(() {
                screenIndex = 1;
              });
            },
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

class RequestAppBarTab extends ConsumerWidget {
  final VoidCallback cb;
  final int screenIndex;

  const RequestAppBarTab({
    Key? key,
    required this.cb,
    required this.screenIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int requestBadgeCount = ref.watch(newAppointmentsProvider.state).state;

    return TextButton.icon(
      onPressed: cb,
      icon: const Icon(Icons.table_chart),
      label: Badge(
        showBadge: requestBadgeCount == 0 ? false : true,
        alignment: Alignment.topLeft,
        position: const BadgePosition(top: -15, end: -15),
        badgeContent: Text(requestBadgeCount.toString()),
        badgeColor: Colors.red.shade300,
        child: Text(AppLocalizations.of(context)!.navRequests),
      ),
      style: screenIndex == 1 ? _buttonSelectedStyle : null,
    );
  }
}
