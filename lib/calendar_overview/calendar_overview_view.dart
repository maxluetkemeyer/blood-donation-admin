import 'package:blooddonation_admin/calendar_overview/build_events.dart';
import 'package:blooddonation_admin/calendar_overview/calendar_style.dart';
import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/models/person_model.dart';
import 'package:blooddonation_admin/providers.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
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
  final TextEditingController requestCreatedController =
      TextEditingController();
  final TextEditingController requestStatusController = TextEditingController();
  final TextEditingController appointmentStartController =
      TextEditingController();
  final TextEditingController appointmentDurationController =
      TextEditingController();
  final TextEditingController personNameController = TextEditingController();

  final TextEditingController personBirthdayController =
      TextEditingController();
  final TextEditingController personGenderController = TextEditingController();

  DateTime _selectedDay = extractDay(DateTime.now());
  bool personEdit = false;

  @override
  void dispose() {
    requestCreatedController.dispose();
    requestStatusController.dispose();
    appointmentStartController.dispose();
    appointmentDurationController.dispose();
    personNameController.dispose();
    personBirthdayController.dispose();
    personGenderController.dispose();

    super.dispose();
  }

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
            discreteStepSize: 30,
            scrollController: ScrollController(
              initialScrollOffset: 12 * 30,
            ),
            events: calendarBuildEventsOfDay(_selectedDay, ref),
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
                      _selectedDay =
                          focusedDay.toLocal().add(const Duration(hours: -1));
                    });
                    //clear appointment details
                    ref
                        .read(calendarOverviewSelectedAppointmentProvider.state)
                        .state = null;
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay =
                          selectedDay.toLocal().add(const Duration(hours: -1));
                    });
                    // clear appointment details
                    ref
                        .read(calendarOverviewSelectedAppointmentProvider.state)
                        .state = null;
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                ),
                const Divider(),
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
                        header: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Person"),
                            TextButton(
                              onPressed: () => setState(() {
                                personEdit = !personEdit;
                              }),
                              child: const Text("Edit"),
                            ),
                          ],
                        ),
                        footer: appointment.request != null
                            ? const Divider()
                            : null,
                        margin: const EdgeInsets.all(12),
                        children: [
                          CupertinoFormRow(
                            prefix: const Text("Name"),
                            child: CupertinoTextFormFieldRow(
                              controller: personNameController,
                              enabled: personEdit,
                            ),
                          ),
                          CupertinoFormRow(
                            prefix: const Text("Birthday"),
                            child: CupertinoTextFormFieldRow(
                              controller: personBirthdayController,
                              enabled: personEdit,
                            ),
                          ),
                          CupertinoFormRow(
                            prefix: const Text("Gender"),
                            child: CupertinoTextFormFieldRow(
                              controller: personGenderController,
                              enabled: personEdit,
                            ),
                          ),
                          personEdit
                              ? Container(
                                  margin: const EdgeInsets.all(12),
                                  width: double.infinity,
                                  child: CupertinoButton.filled(
                                    onPressed: () {
                                      appointment.person = Person(
                                        birthday: DateTime.parse(
                                          (personBirthdayController.text),
                                        ),
                                        gender: personGenderController.text,
                                        name: personNameController.text,
                                      );
                                      CalendarService.instance
                                          .addAppointment(appointment);
                                      //clear appointment details
                                      ref
                                          .read(
                                              calendarOverviewSelectedAppointmentProvider
                                                  .state)
                                          .state = null;
                                      setState(() {
                                        personEdit = false;
                                        _selectedDay =
                                            extractDay(DateTime(2021, 12, 30));
                                      });
                                    },
                                    child: const Text("Save changes"),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      )
                    : const SizedBox(),
                appointment?.request != null
                    ? CupertinoFormSection.insetGrouped(
                        header: const Text("Request"),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/* Außerplanmäßiger Termin
const Divider(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => const SimpleDialog(
                            children: [Text("Termin")],
                          ),
                        ),
                        child: const Text("Außerplanmäßiger Termin"),
                      ),
                    ],
                  ),
                ),
                */