import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DonationQuestionEditView extends StatelessWidget {
  const DonationQuestionEditView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsDonationQuestion),
      ),
      body: const Center(
        child: Text("Donation Question Settings")
      ),
    );
  }
}