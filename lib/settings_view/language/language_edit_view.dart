import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/settings_view/language/language_tile.dart';
import 'package:blooddonation_admin/settings_view/language/new_language.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LanguageEditView extends StatefulWidget {
  const LanguageEditView({Key? key}) : super(key: key);

  @override
  State<LanguageEditView> createState() => _LanguageEditViewState();
}

class _LanguageEditViewState extends State<LanguageEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsLanguage),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              print("Saving Languages");
              //TODO: Backend Connection
            },
          ),
        ],
      ),
      body: Center(
        //const Text("List of all Languages"),
        child: SettingService().getLanguages().isNotEmpty
            ? ListView(
                children: getLanguageWidgets(
                  SettingService().getLanguages(),
                ),
              )
            : Center(
                child: Text(
                  AppLocalizations.of(context)!.settingsLanguageEmpty,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (_) {
            return NewLanguage(notifyParents: refreshNewLanguage);
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void refreshNewLanguage(Language lang) {
    setState(() {
      SettingService().addLanguage(lang);
    });
  }

  void refreshDeleteLanguage(int i) {
    setState(() {
      SettingService().deleteLanguage(i);
    });
  }

  List<Widget> getLanguageWidgets(List<Language> languages) {
    List<Widget> result = [];
    for (int i = 0; i < languages.length; i++) {
      result.add(
        LanguageTile(
          iterator: i,
          languages: languages,
          notifyParents: refreshDeleteLanguage,
        ),
      );
    }
    return result;
  }
}
