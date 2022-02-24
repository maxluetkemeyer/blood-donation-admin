import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///[LangInput] is a widget that generates two input and one [Text] Widget for one question and one language
class FaqInputFields extends StatefulWidget {
  final String country;
  final int iterator;
  final String countryName;

  const FaqInputFields({
    Key? key,
    required this.country,
    required this.iterator,
    required this.countryName,
  }) : super(key: key);

  @override
  _FaqInputFieldsState createState() => _FaqInputFieldsState();
}

class _FaqInputFieldsState extends State<FaqInputFields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 15,
          child: CupertinoFormSection.insetGrouped(
            header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.countryName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            footer: const Divider(),
            margin: const EdgeInsets.all(12),
            children: [
              CupertinoFormRow(
                prefix: Text(
                  AppLocalizations.of(context)!.question,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: CupertinoTextFormFieldRow(
                  placeholder: "",
                  controller: SettingService()
                      .getFaqControllerTranslation(
                        languageCode: widget.country,
                        questionId: widget.iterator,
                      )
                      .headController,
                ),
              ),
              CupertinoFormRow(
                prefix: Text(
                  AppLocalizations.of(context)!.answer,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: CupertinoTextFormFieldRow(
                  placeholder: "",
                  controller: SettingService()
                      .getFaqControllerTranslation(
                        languageCode: widget.country,
                        questionId: widget.iterator,
                      )
                      .bodyController,
                ),
              ),
            ],
          ),
        ),
        const Expanded(flex: 1, child: SizedBox())
      ],
    );
  }
}
