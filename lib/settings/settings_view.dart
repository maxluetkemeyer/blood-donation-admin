import 'package:blooddonation_admin/settings/donation_question/donation_question_edit_view.dart';
import 'package:blooddonation_admin/settings/faq/faq_edit_view.dart';
import 'package:blooddonation_admin/settings/language/language_edit_view.dart';
import 'package:blooddonation_admin/settings/widgets/settings_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SettingsButton(buttonText: AppLocalizations.of(context)!.settingsLanguage, nextPage: const LanguageEditView()),
          SettingsButton(buttonText: AppLocalizations.of(context)!.settingsFaq, nextPage: const FaqEditView()),
          SettingsButton(buttonText: AppLocalizations.of(context)!.settingsDonationQuestion, nextPage: const DonationQuestionEditView()),
        ],
      ),
    );
  }
}
