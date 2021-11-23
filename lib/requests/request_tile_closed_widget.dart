import 'package:blooddonation_admin/services/appointment_model.dart';
import 'package:flutter/material.dart';

class RequestTileClosed extends StatelessWidget {
  final Appointment appointment;

  const RequestTileClosed({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            SelectableText(appointment.start.toString()),
            const SizedBox(width: 30),
            const SelectableText("Amelie Ammadeus"),
            const Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
