import 'package:blooddonation_admin/settings_view/donation_question/donation_question_edit_view.dart';
import 'package:blooddonation_admin/settings_view/faq/faq_edit_view.dart';
import 'package:blooddonation_admin/settings_view/language/language_edit_view.dart';
import 'package:blooddonation_admin/settings_view/widgets/settings_button_widget.dart';
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
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                SettingsButton(
                  buttonText: AppLocalizations.of(context)!.settingsLanguage,
                  nextPage: const LanguageEditView(),
                ),
                SettingsButton(
                  buttonText: AppLocalizations.of(context)!.settingsFaq,
                  nextPage: const FaqEditView(),
                ),
                SettingsButton(
                  buttonText: AppLocalizations.of(context)!.settingsDonationQuestion,
                  nextPage: const DonationQuestionEditView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
