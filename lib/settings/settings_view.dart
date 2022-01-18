import 'package:blooddonation_admin/settings/views/donation_question_edit_view.dart';
import 'package:blooddonation_admin/settings/views/faq_edit_view.dart';
import 'package:blooddonation_admin/settings/views/language_edit_view.dart';
import 'package:blooddonation_admin/settings/widgets/settings_button.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

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
        children: const [
          SettingsButton(buttonText: "Edit Languages", nextPage: LanguageEditView()),
          SettingsButton(buttonText: "Edit FAQ", nextPage: FaqEditView()),
          SettingsButton(buttonText: "Edit Donation Questions", nextPage: DonationQuestionEditView()),
        ],
      ),
    );
  }
}
