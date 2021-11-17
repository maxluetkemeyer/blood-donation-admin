import 'package:blooddonation_admin/dashboard/dashboard_view.dart';
import 'package:blooddonation_admin/help/help_view.dart';
import 'package:blooddonation_admin/overview/overview_view.dart';
import 'package:blooddonation_admin/planner/planner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> screens = [
    const Dashboard(),
    const Overview(),
    const Planner(),
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
          ),
          TextButton.icon(
            onPressed: () => setState(() {
              screenIndex = 1;
            }),
            icon: const Icon(Icons.table_chart),
            label: Text(AppLocalizations.of(context)!.navAppointments),
          ),
          TextButton.icon(
            onPressed: () => setState(() {
              screenIndex = 2;
            }),
            icon: const Icon(Icons.calendar_today_rounded),
            label: Text(AppLocalizations.of(context)!.navPlanner),
          ),
          TextButton.icon(
            onPressed: () => setState(() {
              screenIndex = 3;
            }),
            icon: const Icon(Icons.help),
            label: Text(AppLocalizations.of(context)!.navHelp),
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
