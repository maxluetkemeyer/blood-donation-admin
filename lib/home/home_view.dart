import 'package:blooddonation_admin/overview/overview_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> screens = [
    const Overview(),
  ];

  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.help),
            label: Text(AppLocalizations.of(context)!.navHelp),
          ),
        ],
      ),
      body: screens[screenIndex],
    );
  }
}
