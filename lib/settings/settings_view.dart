import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  HtmlEditorController controller = HtmlEditorController();

  @override
  void dispose() {
    //TODO: Dispose HtmlEditor

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 800,
          child: HtmlEditor(
            controller: controller,
            htmlEditorOptions: const HtmlEditorOptions(
              hint: "",
              initialText: "",
              adjustHeightForKeyboard: false,
              autoAdjustHeight: false,
            ),
            otherOptions: const OtherOptions(
              height: 700,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            String html = await controller.getText();
            print(html);
          },
          child: const Text("print"),
        ),
      ],
    );
  }
}
