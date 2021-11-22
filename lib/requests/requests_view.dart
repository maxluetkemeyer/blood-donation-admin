import 'package:blooddonation_admin/services/appointment_model.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/services/request_model.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'appointment_tile.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final DateTime now = DateTime.now();
  final DateTime date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: SizedBox(
            height: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  bottom: 30,
                  child: Image(
                    image: AssetImage("assets/images/company_logo_full.png"),
                    height: 200,
                  ),
                ),
                SingleChildScrollView(
                  child: ExpansionPanelList.radio(
                    children: buildRequests(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade200,
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(6),
                child: Text(
                  DateFormat("dd.MM.yyyy").format(DateTime.now()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: CoolCalendar(
                  backgroundColor: Colors.white,
                  timeLineColor: Colors.white,
                  eventGridColor: Color.fromRGBO(227, 245, 255, 1),
                  eventGridLineColorFullHour: Colors.black38.withOpacity(0.2),
                  eventGridLineColorHalfHour: Colors.transparent,
                  discreteStepSize: 34,
                  eventGridEventWidth: 60,
                  events: buildEvents(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<CoolCalendarEvent> buildEvents() {
    List<Appointment> appointments = CalendarService
        .instance.calendar[extractDay(DateTime.now()).toString()];

    List<CoolCalendarEvent> events = [];

    List<int> rows = List.generate(48, (index) => -1);

    for (Appointment appointment in appointments) {
      int topStep = appointment.start.hour * 2;
      int durationSteps = (appointment.duration.inMinutes / 30).ceil();

      rows[topStep]++;
      rows[topStep + durationSteps]++;

      events.add(
        CoolCalendarEvent(
          child: Center(
            child: Text(
              "VBS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          initTopMultiplier: topStep,
          initHeightMultiplier: durationSteps,
          rowIndex: rows[topStep],
          backgroundColor: Color.fromRGBO(11, 72, 116, 1),
          dragging: false,
        ),
      );
    }

    return events;
  }

  List<ExpansionPanelRadio> buildRequests() {
    List<ExpansionPanelRadio> requests = [];

    for (Request request in CalendarService.instance.requests) {
      Appointment appointment = request.appointment;

      requests.add(
        appointmentTile(
          id: appointment.id,
          duration: appointment.duration,
          start: appointment.start,
        ),
      );
    }

    return requests;
  }
}

/*
CoolCalendarEvent(
                      child: Center(
                        child: Text(
                          "Neu",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      initTopMultiplier: 16,
                      initHeightMultiplier: 2,
                      rowIndex: 1,
                      backgroundColor: Color.fromRGBO(95, 122, 142, 1),
                      dragging: false,
                    ),
                    */