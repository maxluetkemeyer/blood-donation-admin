import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/requests/build_events.dart';
import 'package:blooddonation_admin/services/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'request_tile/request_tile.dart';

class Requests extends ConsumerStatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends ConsumerState<Requests> {
  // settings
  double hourHeight = 80;
  int appointmentLengthInMinutes = 15;

  ScrollController calendarScrollController = ScrollController();

  @override
  void dispose() {
    calendarScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    int update = ref.watch(updateRequestViewProvider.state).state;
    Appointment openAppointment = ref.watch(requestTileOpenProvider.state).state;
    double width = MediaQuery.of(context).size.width;
    String dayString = DateFormat("dd.MM.yyyy").format(openAppointment.start);

    if (openAppointment is! EmptyAppointment) {
      Future.delayed(const Duration(milliseconds: 1), () {
        double scrollOffset = Duration(
              milliseconds: openAppointment.start.millisecondsSinceEpoch - extractDay(openAppointment.start).millisecondsSinceEpoch,
            ).inMinutes /
            appointmentLengthInMinutes;
        calendarScrollController.animateTo(scrollOffset * hourHeight / (60 / appointmentLengthInMinutes) - hourHeight,
            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      });
    }

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
                /*const Positioned(
                  top: 50,
                  child: Text("Keine offenen Anfragen"),
                ),*/
                const Positioned(
                  bottom: 30,
                  child: Image(
                    image: AssetImage("assets/images/company_logo_full.png"),
                    height: 200,
                  ),
                ),
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Today " + DateFormat("dd.MM.yyyy").format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ...buildRequests(CalendarService().getRequests(today: true)),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Requests",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ...buildRequests(CalendarService().getRequests(today: false)),
                  ],
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: openAppointment is EmptyAppointment
              ? Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    border: Border(
                      left: BorderSide(
                        width: 2,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  child: const Text("Nothing selected"),
                )
              : Column(
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(6),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1, end: 254),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, child) => Text(
                          dayString,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            //fontSize: 30,
                            fontSize: value / 8,
                            fontWeight: FontWeight.bold,
                            //color: Theme.of(context).primaryColor.withBlue(value.floor()),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CoolCalendar(
                        key: const PageStorageKey("request_view"),
                        backgroundColor: Colors.white,
                        timeLineColor: Colors.white,
                        eventGridColor: const Color.fromRGBO(227, 245, 255, 1),
                        eventGridLineColorFullHour: Colors.black38.withOpacity(0.2),
                        eventGridLineColorHalfHour: Colors.transparent,
                        hourHeight: hourHeight,
                        scrollController: calendarScrollController,
                        eventGridEventWidth: width * 0.05,
                        animated: true,
                        events: requestBuildEventsOfDay(
                          requestedAppointment: openAppointment,
                          appointmentLengthInMinutes: appointmentLengthInMinutes,
                        ),
                        //events: calendarBuildEventsOfDay(day: extractDay(DateTime.now())),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  List<Widget> buildRequests(List<Appointment> appointments) {
    List<Widget> requestsTiles = [];

    for (Appointment appointmentWithOpenRequest in appointments) {
      requestsTiles.add(
        RequestTile(
          appointment: appointmentWithOpenRequest,
        ),
      );
    }

    return requestsTiles;
  }
}
