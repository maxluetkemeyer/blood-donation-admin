import 'package:blooddonation_admin/models/person_model.dart';
import 'package:blooddonation_admin/providers.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarSidebar extends ConsumerStatefulWidget {
  final Appointment? appointment;

  const CalendarSidebar({
    Key? key,
    this.appointment,
  }) : super(key: key);

  @override
  _CalendarSidebarState createState() => _CalendarSidebarState();
}

class _CalendarSidebarState extends ConsumerState<CalendarSidebar> {
  late final TextEditingController requestCreatedController;
  late final TextEditingController requestStatusController;
  late final TextEditingController appointmentStartController;
  late final TextEditingController appointmentDurationController;
  late final TextEditingController personNameController;
  late final TextEditingController personBirthdayController;
  late final TextEditingController personGenderController;

  bool personEdit = false;

  @override
  void initState() {
    super.initState();

    requestCreatedController = TextEditingController();
    requestStatusController = TextEditingController();
    appointmentStartController = TextEditingController();
    appointmentDurationController = TextEditingController();
    personNameController = TextEditingController();
    personBirthdayController = TextEditingController();
    personGenderController = TextEditingController();
  }

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
    requestCreatedController.text = widget.appointment?.request?.created.toString() ?? "";
    requestStatusController.text = widget.appointment?.request?.status ?? "";
    appointmentStartController.text = widget.appointment?.start.toString() ?? "";
    appointmentDurationController.text = widget.appointment?.duration.toString() ?? "";
    personNameController.text = widget.appointment?.person?.name ?? "";
    personBirthdayController.text = widget.appointment?.person?.birthday.toString() ?? "";
    personGenderController.text = widget.appointment?.person?.gender ?? "";

    return Column(
      children: [
        widget.appointment != null
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
        widget.appointment != null
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
                footer: widget.appointment?.request != null ? const Divider() : null,
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
                              Appointment newAppointment = Appointment(
                                id: "dssfqremsd",
                                start: widget.appointment!.start,
                                duration: widget.appointment!.duration,
                                person: Person(
                                  birthday: DateTime.parse(personBirthdayController.text),
                                  gender: personGenderController.text,
                                  name: personNameController.text,
                                ),
                              );

                              CalendarService.instance.addAppointment(newAppointment);

                              personEdit = false;

                              //clear appointment details
                              ref.read(calendarOverviewSelectedAppointmentProvider.state).state = null;
                            },
                            child: const Text("Save changes"),
                          ),
                        )
                      : const SizedBox(),
                ],
              )
            : const SizedBox(),
        widget.appointment?.request != null
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
    );
  }
}
