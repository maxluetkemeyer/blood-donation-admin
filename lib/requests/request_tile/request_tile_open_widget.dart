import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'request_tile.dart';

class RequestTileOpen extends StatelessWidget {
  final Appointment appointment;

  const RequestTileOpen({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              children: [
                SelectableText(dayWithTimeString(appointment.start)),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(timeLeft()),
                        const Icon(Icons.keyboard_arrow_up),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          bottom(),
        ],
      ),
    );
  }

  String timeLeft() {
    Duration difference = appointment.start.difference(DateTime.now());

    if (difference.inHours >= 24) return "";

    return "Termin ist in " +
        DateFormat("hh").format(DateTime.fromMillisecondsSinceEpoch(difference.inMilliseconds)) +
        " Stunden und " +
        DateFormat("mm").format(DateTime.fromMillisecondsSinceEpoch(difference.inMilliseconds)) +
        " Minuten";
  }

  Widget bottom() {
    return Row(
      children: [
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Person",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Table(
                          columnWidths: const {
                            2: FixedColumnWidth(200),
                            1: FractionColumnWidth(0.7),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [
                                const Text("Name"),
                                Text(appointment.person?.name ?? ""),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text("Birthday"),
                                Text(appointment.person?.birthday != null ? DateFormat("dd.MM.yyyy").format(appointment.person!.birthday!) : ""),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text("Gender"),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: genderIcon(appointment.person?.gender ?? ""),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Request",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Table(
                          columnWidths: const {
                            2: FixedColumnWidth(100),
                            1: FractionColumnWidth(0.7),
                          },
                          children: [
                            TableRow(
                              children: [
                                const Text("Created"),
                                Text(
                                  dayWithTimeString(appointment.request!.created),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(11, 72, 116, 1),
            ),
            onPressed: () {
              CalendarService().updateAppointment(
                appointment.copyWith(
                  request: appointment.request!.copyWith(
                    status: "accepted",
                  ),
                ),
              );

              //reset selected request appointment
              ProviderService().container.read(requestTileOpenProvider.state).state = EmptyAppointment();
            },
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text("Bestätigen"),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: const Color.fromRGBO(11, 72, 116, 1),
              side: const BorderSide(
                width: 2,
              ),
            ),
            onPressed: () {
              CalendarService().updateAppointment(
                appointment.copyWith(
                  request: appointment.request!.copyWith(
                    status: "declined",
                  ),
                ),
              );

              //reset selected request appointment
              ProviderService().container.read(requestTileOpenProvider.state).state = EmptyAppointment();
            },
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text("Ablehnen"),
            ),
          ),
        ),
      ],
    );
  }
}
