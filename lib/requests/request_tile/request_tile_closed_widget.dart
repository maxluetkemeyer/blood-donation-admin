import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:flutter/material.dart';

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
            SizedBox(
              width: 170,
              child: SelectableText(dayWithTimeString(appointment.start)),
            ),
            SizedBox(
              width: 120,
              child: SelectableText(appointment.person?.name ?? ""),
            ),
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
