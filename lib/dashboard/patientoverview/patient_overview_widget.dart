import 'package:blooddonation_admin/dashboard/patientoverview/patient_listtile_widget.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/models/person_model.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:flutter/material.dart';

class PatienOverview extends StatefulWidget {
  const PatienOverview({Key? key}) : super(key: key);

  @override
  State<PatienOverview> createState() => _PatienOverviewState();
}

class _PatienOverviewState extends State<PatienOverview> {
  ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      isAlwaysShown: true,
      showTrackOnHover: true,
      hoverThickness: 14,
      thickness: 14,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          controller: controller,
          itemCount: 24 - DateTime.now().hour,
          itemBuilder: (context, i) {
            DateTime now = DateTime.now();
            DateTime startHour = DateTime(now.year, now.month, now.day, now.hour);
            DateTime hour = startHour.add(Duration(hours: i));
            List<Appointment> appointments = CalendarService().getAppointmentsInHour(hour);
            List<Person> persons = [];
            for (Appointment appointment in appointments) {
              persons.add(appointment.person ?? Person());
            }

            return PatientOverviewListTile(
              persons: persons,
              startTime: hour,
            );
          },
        ),
      ),
    );
  }
}
