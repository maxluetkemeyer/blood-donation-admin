import 'package:blooddonation_admin/calendar_overview/build_events.dart';
import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/providers.dart';
import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarOverview extends ConsumerStatefulWidget {
  const CalendarOverview({Key? key}) : super(key: key);

  @override
  _CalendarOverviewState createState() => _CalendarOverviewState();
}

class _CalendarOverviewState extends ConsumerState<CalendarOverview> {
  TextEditingController requestCreatedController = TextEditingController();
  TextEditingController requestStatusController = TextEditingController();
  TextEditingController appointmentStartController = TextEditingController();
  TextEditingController appointmentDurationController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController personBirthdayController = TextEditingController();
  TextEditingController personGenderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Appointment? appointment =
        ref.watch(calendarOverviewSelectedAppointmentProvider.state).state;

    requestCreatedController.text =
        appointment?.request?.created.toString() ?? "";
    requestStatusController.text = appointment?.request?.status ?? "";
    appointmentStartController.text = appointment?.start.toString() ?? "";
    appointmentDurationController.text = appointment?.duration.toString() ?? "";
    personNameController.text = appointment?.person?.name ?? "";
    personBirthdayController.text =
        appointment?.person?.birthday.toString() ?? "";
    personGenderController.text = appointment?.person?.gender ?? "";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: CoolCalendar(
            events: calendarBuildEventsOfDay(extractDay(DateTime.now()), ref),
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
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now(),
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    headerPadding: EdgeInsets.all(0),
                  ),
                ),
                const Divider(),
                appointment?.request != null
                    ? CupertinoFormSection.insetGrouped(
                        header: const Text("Request"),
                        footer: const Divider(),
                        margin: const EdgeInsets.all(12),
                        children: [
                          CupertinoFormRow(
                            prefix: const Text("Created"),
                            child: CupertinoTextFormFieldRow(
                              controller: requestCreatedController,
                            ),
                          ),
                          CupertinoFormRow(
                            prefix: const Text("Status"),
                            child: CupertinoTextFormFieldRow(
                              controller: requestStatusController,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                appointment != null
                    ? CupertinoFormSection.insetGrouped(
                        header: const Text("Appointment"),
                        footer: const Divider(),
                        margin: const EdgeInsets.all(12),
                        children: [
                          CupertinoFormRow(
                            prefix: const Text("Start"),
                            child: CupertinoTextFormFieldRow(
                              controller: appointmentStartController,
                            ),
                          ),
                          CupertinoFormRow(
                            prefix: const Text("Duration"),
                            child: CupertinoTextFormFieldRow(
                              controller: appointmentDurationController,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                appointment != null
                    ? CupertinoFormSection.insetGrouped(
                        header: const Text("Person"),
                        margin: const EdgeInsets.all(12),
                        children: [
                          CupertinoFormRow(
                            prefix: const Text("Name"),
                            child: CupertinoTextFormFieldRow(
                              controller: personNameController,
                            ),
                          ),
                          CupertinoFormRow(
                            prefix: const Text("Birthday"),
                            child: CupertinoTextFormFieldRow(
                              controller: personBirthdayController,
                            ),
                          ),
                          CupertinoFormRow(
                            prefix: const Text("Gender"),
                            child: CupertinoTextFormFieldRow(
                              controller: personGenderController,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/*
Text(ref
                  .watch(calendarOverviewSelectedAppointmentProvider.state)
                  .state
                  .start
                  .toString()),
                  */