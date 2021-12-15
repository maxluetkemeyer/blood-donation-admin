import 'package:blooddonation_admin/calendar_overview/style.dart';
import 'package:blooddonation_admin/models/person_model.dart';
import 'package:blooddonation_admin/services/provider/providers.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    if (widget.appointment is EmptyAppointment) {
      return Text(
        AppLocalizations.of(context)!.calendarSidebarNothingSelected,
        style: const TextStyle(
          color: Colors.black54,
        ),
      );
    }

    return Column(
      children: [
        if (edited)
          Container(
            margin: const EdgeInsets.all(12),
            width: double.infinity,
            child: CupertinoButton.filled(
              onPressed: () {
                if (widget.appointment.id == "-1") {
                  //later: Send to backend and recieve new appointment
                  CalendarService.instance.addAppointment(
                    Appointment(
                      id: DateTime.now().toString(),
                      start: widget.appointment.start,
                      duration: widget.appointment.duration,
                      person: Person(
                        birthday: DateTime.parse(personBirthdayController.text),
                        gender: personGenderController.text,
                        name: personNameController.text,
                      ),
                    ),
                  );
                  print("add");
                }
                print(CalendarService.instance.calendar);
                CalendarService.instance.updateAppointment(
                  Appointment(
                    id: widget.appointment.id,
                    start: widget.appointment.start,
                    duration: widget.appointment.duration,
                    person: Person(
                      birthday: DateTime.parse(personBirthdayController.text),
                      gender: personGenderController.text,
                      name: personNameController.text,
                    ),
                    request: widget.appointment.request,
                  ),
                );
                print(CalendarService.instance.calendar);

                personEdited = false;
                edited = false;

                //clear appointment details
                ref.read(calendarOverviewSelectedAppointmentProvider.state).state = EmptyAppointment();
              },
              child: Text(AppLocalizations.of(context)!.saveChanges),
            ),
          ),
        if (widget.appointment.request != null)
          CupertinoFormSection.insetGrouped(
            header: Text(AppLocalizations.of(context)!.request),
            footer: const Divider(),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: requestColor(widget.appointment.request!.status),
            ),
            children: [
              CupertinoFormRow(
                prefix: Text(AppLocalizations.of(context)!.created),
                child: CupertinoTextFormFieldRow(
                  controller: requestCreatedController,
                ),
              ),
              CupertinoFormRow(
                prefix: Text(AppLocalizations.of(context)!.status),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 10),
                  child: DropdownButtonFormField<String>(
                    value: widget.appointment.request!.status,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "pending",
                        child: Text(AppLocalizations.of(context)!.pending),
                      ),
                      DropdownMenuItem(
                        value: "accepted",
                        child: Text(AppLocalizations.of(context)!.accepted),
                      ),
                      DropdownMenuItem(
                        value: "declined",
                        child: Text(AppLocalizations.of(context)!.declined),
                      ),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        //aufwendiger musst appointment updaten + backend etc.
                        //Bug: Das Objekt darf noch nicht geupdated werden!
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
          ),
        CupertinoFormSection.insetGrouped(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.appointment),
              TextButton(
                onPressed: () => print("todo delete"),
                child: Text(
                  AppLocalizations.of(context)!.delete,
                  style: TextStyle(color: Colors.red.shade300),
                ),
              ),
            ],
          ),
          footer: const Divider(),
          margin: const EdgeInsets.all(12),
          children: [
            CupertinoFormRow(
              prefix: Text(AppLocalizations.of(context)!.start),
              child: CupertinoTextFormFieldRow(
                enabled: false,
                controller: appointmentStartController,
              ),
            ),
            CupertinoFormRow(
              prefix: Text(AppLocalizations.of(context)!.duration),
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
              Text(AppLocalizations.of(context)!.person),
              TextButton(
                onPressed: () => setState(() {
                  personEdited = true;
                  edited = true;
                }),
                child: Text(AppLocalizations.of(context)!.edit),
              ),
            ],
          ),
          margin: const EdgeInsets.all(12),
          children: [
            CupertinoFormRow(
              prefix: Text(AppLocalizations.of(context)!.name),
              child: CupertinoTextFormFieldRow(
                controller: personNameController,
                enabled: personEdited,
              ),
            ),
            CupertinoFormRow(
              prefix: Text(AppLocalizations.of(context)!.birthday),
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
              prefix: Text(AppLocalizations.of(context)!.gender),
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
}
