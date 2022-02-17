import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String buttonText;
  final Widget nextPage;

  const SettingsButton({
    Key? key,
    required this.buttonText,
    required this.nextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          child: FittedBox(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
