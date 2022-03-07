import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageTile extends StatefulWidget {
  final List<Language> languages;
  final int iterator;
  final Function notifyParents;

  const LanguageTile({
    Key? key,
    required this.languages,
    required this.iterator,
    required this.notifyParents,
  }) : super(key: key);

  @override
  State<LanguageTile> createState() => _LanguageTileState();
}

class _LanguageTileState extends State<LanguageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.languages[widget.iterator].name,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  widget.languages[widget.iterator].abbr,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 10,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onPressed: () => setState(() {
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
                        //Delete language
                        widget.notifyParents(widget.iterator);
                        //pop dialog
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.delete),
                    ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      //pop dialog
                      onPressed: () => Navigator.pop(context),
                      child: Text(AppLocalizations.of(context)!.back),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
