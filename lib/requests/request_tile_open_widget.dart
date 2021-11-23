import 'package:blooddonation_admin/services/appointment_model.dart';
import 'package:flutter/material.dart';

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
                SelectableText(appointment.start.toString()),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.keyboard_arrow_up),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Name"),
                        SizedBox(height: 10),
                        Text("Birthday"),
                        SizedBox(height: 10),
                        Text("Issued"),
                      ],
                    ),
                    const SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SelectableText("Amelie Ammadeus"),
                        SizedBox(height: 10),
                        SelectableText("15.07.1983"),
                        SizedBox(height: 10),
                        SelectableText("today at 12:00pm"),
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
                  onPressed: () {},
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
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text("Ablehnen"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
