import 'package:blooddonation_admin/services/settings/language_service.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:language_picker/language_picker.dart' as lp;
import 'package:language_picker/languages.dart' as l;

class NewLanguage extends StatefulWidget {
  final List<Language> languages = LanguageService().getLanguages();
  final Function notifyParents;

  NewLanguage({
    Key? key,
    required this.notifyParents,
  }) : super(key: key);

  @override
  State<NewLanguage> createState() => _NewLanguageState();
}

class _NewLanguageState extends State<NewLanguage> {
  Language newlang = Language(abbr: "de", name: "German");

   Widget _buildDropdownItem(l.Language language) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 8.0,
        ),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: Center(
        child: SingleChildScrollView(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3*2,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: lp.LanguagePickerDropdown(
                    itemBuilder: _buildDropdownItem,
                    initialValue: l.Languages.german,
                    onValuePicked: (l.Language language) {
                      newlang.abbr = language.isoCode;
                      newlang.name = language.name;
                    }),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: CupertinoButton.filled(
                  onPressed: () {
                    setState(() {
                      Language newLanguage = newlang;
                      widget.notifyParents(newLanguage);
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context)!.settingsLanguageNewSave,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
