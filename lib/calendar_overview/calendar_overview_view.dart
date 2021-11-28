import 'package:blooddonation_admin/calendar_overview/build_events.dart';
import 'package:blooddonation_admin/calendar_overview/calendar_sidebar_details_widget.dart';
import 'package:blooddonation_admin/calendar_overview/style.dart';
import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/providers.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarOverview extends ConsumerStatefulWidget {
  const CalendarOverview({Key? key}) : super(key: key);

  @override
  _CalendarOverviewState createState() => _CalendarOverviewState();
}

class _CalendarOverviewState extends ConsumerState<CalendarOverview> {
  DateTime _selectedDay = extractDay(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Appointment appointment = ref.watch(calendarOverviewSelectedAppointmentProvider.state).state;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: CoolCalendar(
            key: GlobalKey(),
            discreteStepSize: 30,
            scrollController: ScrollController(
              initialScrollOffset: 14 * 30,
            ),
            events: calendarBuildEventsOfDay(
              day: _selectedDay,
              ref: ref,
            ),
            eventGridEventWidth: 70,
            animated: true,
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TableCalendar(
                  locale: "de",
                  weekendDays: const [DateTime.saturday, DateTime.sunday],
                  currentDay: _selectedDay,
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: calendarStyle(context),
                  headerStyle: calendarHeaderStyle(context),
                  calendarBuilders: calendarBuilder,
                  focusedDay: _selectedDay,
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _selectedDay = focusedDay.toLocal().add(const Duration(hours: -1));
                    });
                    //clear appointment details
                    ref.read(calendarOverviewSelectedAppointmentProvider.state).state = EmptyAppointment();
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay.toLocal().add(const Duration(hours: -1));
                    });
                    // clear appointment details
                    ref.read(calendarOverviewSelectedAppointmentProvider.state).state = EmptyAppointment();
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                ),
                const Divider(),
                CalendarSidebarDetails(
                  key: GlobalKey(),
                  appointment: appointment,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
