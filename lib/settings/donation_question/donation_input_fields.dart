import 'package:blooddonation_admin/services/settings/settings_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///[LangInput] is a widget that generates two input and one [Text] Widget for one question and one language
class DonationInputFields extends StatefulWidget {
  final String country;
  final int iterator;
  final String countryName;

  const DonationInputFields(
      {Key? key, required this.country, required this.iterator, required this.countryName})
      : super(key: key);

  @override
  _DonationInputFieldsState createState() => _DonationInputFieldsState();
}

class _DonationInputFieldsState extends State<DonationInputFields> {
  @override
  Widget build(BuildContext context) {
    return CupertinoFormSection.insetGrouped(
      header: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.countryName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
            controller: SettingService().findDonationControllerTranslation(widget.iterator, widget.country).bodyController,
          ),
        ),
      ],
    );
  }
}
