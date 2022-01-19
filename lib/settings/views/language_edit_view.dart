import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/settings/widgets/new_language.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LanguageEditView extends StatefulWidget {
  const LanguageEditView({Key? key}) : super(key: key);

  @override
  State<LanguageEditView> createState() => _LanguageEditViewState();
}

class _LanguageEditViewState extends State<LanguageEditView> {
  //TODO: Funktionsweise für Backend hinzufügen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsLanguage),
      ),
      body: Center(
          //const Text("List of all Languages"),
          child: ListView(
        children: getLanguageWidgets(SettingService().getLanguages()),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return NewLanguage(notifyParents: refreshNewLanguage);
            },
          );
        },
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
    if (languages.isEmpty) {
      return [Text(AppLocalizations.of(context)!.settingsLanguageEmpty)];
    }
    for (int i = 0; i < languages.length; i++) {
      result.add(Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              languages[i].name,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Expanded(child: SizedBox()),
            IconButton(
                onPressed: () {
                  setState(() {
                    showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                              title: Text(
                                AppLocalizations.of(context)!.settingsLanguageDeleteTitle,
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              content: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    AppLocalizations.of(context)!.settingsLanguageDeleteSubtitle,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  key: const ValueKey('deleteLanguage'),
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    //Delete Faq Question
                                    SettingService().deleteLanguage(i);
                                    //pop dialog
                                    Navigator.pop(context);
                                  },
                                  //child: const Text('Cancel Booking'),
                                  child: Text(AppLocalizations.of(context)!.delete),
                                ),
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  //pop dialog
                                  onPressed: () => Navigator.pop(context),
                                  //child: const Text('Back'),
                                  child: Text(AppLocalizations.of(context)!.back),
                                ),
                              ],
                            ));
                  });
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
      ));
    }

    return result;
  }
}
