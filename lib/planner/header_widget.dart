import 'package:flutter/material.dart';

class PlannerHeader extends StatelessWidget {
  final String weekday;
  final VoidCallback onPressed;

  const PlannerHeader({
    Key? key,
    required this.weekday,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(weekday),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text("Zeitslot hinzufügen"),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
