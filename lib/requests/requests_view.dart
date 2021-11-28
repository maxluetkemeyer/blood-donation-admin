import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:blooddonation_admin/requests/request_tile.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/models/request_model.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';

class Requests extends ConsumerWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Appointment openAppointment = ref.watch(requestTileOpenProvider.state).state;
    double width = MediaQuery.of(context).size.width;

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
                const Positioned(
                  top: 20,
                  child: Text("Keine offenen Anfragen"),
                ),
                const Positioned(
                  bottom: 30,
                  child: Image(
                    image: AssetImage("assets/images/company_logo_full.png"),
                    height: 200,
                  ),
                ),
                ListView(
                  children: buildRequests(),
                )
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
                padding: const EdgeInsets.all(6),
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
                  eventGridColor: const Color.fromRGBO(227, 245, 255, 1),
                  eventGridLineColorFullHour: Colors.black38.withOpacity(0.2),
                  eventGridLineColorHalfHour: Colors.transparent,
                  discreteStepSize: 30,
                  scrollController: ScrollController(
                    initialScrollOffset: 12 * 30,
                  ),
                  eventGridEventWidth: width * 0.03,
                  animated: true,
                  events: buildEvents(openAppointment),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<CoolCalendarEvent> buildEvents(Appointment openAppointment) {
    List<Appointment> appointments = CalendarService.instance.calendar[extractDay(DateTime.now()).toString()];

    List<CoolCalendarEvent> events = [];

    List<int> rows = List.generate(48, (index) => -1);

    for (Appointment appointment in appointments) {
      int topStep = appointment.start.hour * 2;
      int durationSteps = (appointment.duration.inMinutes / 30).ceil();

      rows[topStep]++;
      int durationStepsEdited = topStep + durationSteps;
      if (durationStepsEdited > 47) durationStepsEdited = 47;
      rows[durationStepsEdited]++;

      events.add(
        CoolCalendarEvent(
          child: const Center(
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
          decoration: BoxDecoration(
            color: const Color.fromRGBO(11, 72, 116, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.black26,
            ),
          ),
          decorationHover: BoxDecoration(
            color: const Color.fromRGBO(90, 160, 213, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
          ),
          dragging: false,
        ),
      );
    }

    if (openAppointment.id != "-1") {
      int topStep = openAppointment.start.hour * 2;
      int durationSteps = (openAppointment.duration.inMinutes / 30).ceil();

      rows[topStep]++;
      int durationStepsEdited = topStep + durationSteps;
      if (durationStepsEdited > 47) durationStepsEdited = 47;
      rows[durationStepsEdited]++;

      events.add(
        CoolCalendarEvent(
          child: Center(
            child: Text(
              openAppointment.id,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          initTopMultiplier: topStep,
          initHeightMultiplier: durationSteps,
          rowIndex: rows[topStep],
          decoration: BoxDecoration(
            color: const Color.fromRGBO(95, 122, 142, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          dragging: false,
        ),
      );
    }

    return events;
  }

  List<Widget> buildRequests() {
    List<Widget> requests = [];

    for (Request request in CalendarService.instance.requests) {
      Appointment appointment = request.appointment;

      requests.add(
        RequestTile(
          appointment: appointment,
        ),
      );
    }

    return requests;
  }
}
