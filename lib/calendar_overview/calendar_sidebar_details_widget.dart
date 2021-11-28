import 'package:blooddonation_admin/models/person_model.dart';
import 'package:blooddonation_admin/providers.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarSidebarDetails extends ConsumerStatefulWidget {
  final Appointment appointment;

  const CalendarSidebarDetails({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  _CalendarSidebarDetailsState createState() => _CalendarSidebarDetailsState();
}

class _CalendarSidebarDetailsState extends ConsumerState<CalendarSidebarDetails> {
  late final TextEditingController requestCreatedController;
  late final TextEditingController appointmentStartController;
  late final TextEditingController appointmentDurationController;
  late final TextEditingController personNameController;
  late final TextEditingController personBirthdayController;
  late final TextEditingController personGenderController;

  bool edited = false;
  bool personEdited = false;

  @override
  void initState() {
    super.initState();

    requestCreatedController = TextEditingController();
    appointmentStartController = TextEditingController();
    appointmentDurationController = TextEditingController();
    personNameController = TextEditingController();
    personBirthdayController = TextEditingController();
    personGenderController = TextEditingController();
  }

  @override
  void dispose() {
    requestCreatedController.dispose();
    appointmentStartController.dispose();
    appointmentDurationController.dispose();
    personNameController.dispose();
    personBirthdayController.dispose();
    personGenderController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    requestCreatedController.text = widget.appointment.request?.created.toString() ?? "";
    appointmentStartController.text = widget.appointment.start.toString();
    appointmentDurationController.text = widget.appointment.duration.toString();
    personNameController.text = widget.appointment.person?.name ?? "";
    personBirthdayController.text = widget.appointment.person?.birthday.toString() ?? "";
    personGenderController.text = widget.appointment.person?.gender ?? "";

    if (widget.appointment is EmptyAppointment) return const SizedBox();

    return Column(
      children: [
        if (edited)
          Container(
            margin: const EdgeInsets.all(12),
            width: double.infinity,
            child: CupertinoButton.filled(
              onPressed: () {
                Appointment newAppointment = Appointment(
                  id: "dssfqremsd",
                  start: widget.appointment.start,
                  duration: widget.appointment.duration,
                  person: Person(
                    birthday: DateTime.parse(personBirthdayController.text),
                    gender: personGenderController.text,
                    name: personNameController.text,
                  ),
                );

                CalendarService.instance.addAppointment(newAppointment);

                personEdited = false;
                edited = false;

                //clear appointment details
                ref.read(calendarOverviewSelectedAppointmentProvider.state).state = EmptyAppointment();
              },
              child: const Text("Save changes"),
            ),
          ),
        widget.appointment.request != null
            ? CupertinoFormSection.insetGrouped(
                header: const Text("Request"),
                footer: const Divider(),
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: requestColor(widget.appointment.request!.status),
                ),
                children: [
                  CupertinoFormRow(
                    prefix: const Text("Created"),
                    child: CupertinoTextFormFieldRow(
                      controller: requestCreatedController,
                    ),
                  ),
                  CupertinoFormRow(
                    prefix: const Text("Status"),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 10),
                      child: DropdownButtonFormField<String>(
                        value: widget.appointment.request!.status,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "pending",
                            child: Text("Pending"),
                          ),
                          DropdownMenuItem(
                            value: "accepted",
                            child: Text("Accepted"),
                          ),
                          DropdownMenuItem(
                            value: "declined",
                            child: Text("Declined"),
                          ),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value != null) {
                            //aufwendiger musst appointment updaten + backend etc.
                            widget.appointment.request!.status = value;
                          }
                          setState(() {
                            edited = true;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        CupertinoFormSection.insetGrouped(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Appointment"),
              TextButton(
                onPressed: () => print("todo delete"),
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red.shade300),
                ),
              ),
            ],
          ),
          footer: const Divider(),
          margin: const EdgeInsets.all(12),
          children: [
            CupertinoFormRow(
              prefix: const Text("Start"),
              child: CupertinoTextFormFieldRow(
                enabled: false,
                controller: appointmentStartController,
              ),
            ),
            CupertinoFormRow(
              prefix: const Text("Duration"),
              child: CupertinoTextFormFieldRow(
                enabled: false,
                controller: appointmentDurationController,
              ),
            ),
          ],
        ),
        CupertinoFormSection.insetGrouped(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Person"),
              TextButton(
                onPressed: () => setState(() {
                  personEdited = true;
                  edited = true;
                }),
                child: const Text("Edit"),
              ),
            ],
          ),
          margin: const EdgeInsets.all(12),
          children: [
            CupertinoFormRow(
              prefix: const Text("Name"),
              child: CupertinoTextFormFieldRow(
                controller: personNameController,
                enabled: personEdited,
              ),
            ),
            CupertinoFormRow(
              prefix: const Text("Birthday"),
              child: CupertinoTextFormFieldRow(
                controller: personBirthdayController,
                enabled: personEdited,
                onTap: () => showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(0),
                  lastDate: DateTime.now(),
                ).then((DateTime? pickedDate) {
                  personBirthdayController.text = pickedDate.toString();
                }),
              ),
            ),
            CupertinoFormRow(
              prefix: const Text("Gender"),
              child: CupertinoTextFormFieldRow(
                controller: personGenderController,
                enabled: personEdited,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color requestColor(String status) {
    switch (status) {
      case "pending":
        return Colors.amber.shade200;
      case "accepted":
        return Colors.lightGreen.shade200;
      case "declined":
        return Colors.deepOrange;
      default:
        return Colors.white;
    }
  }
}
