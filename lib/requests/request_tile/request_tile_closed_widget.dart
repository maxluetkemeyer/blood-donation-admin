import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'request_tile.dart';

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
            SelectableText(DateFormat("dd.MM.yyyy").format(appointment.start) + " um " + DateFormat("hh:mm").format(appointment.start)),
            const SizedBox(width: 30),
            SelectableText(appointment.person?.name ?? ""),
            const SizedBox(width: 30),
            genderIcon(appointment.person?.gender ?? ""),
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
