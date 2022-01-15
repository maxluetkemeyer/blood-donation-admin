import 'package:flutter/material.dart';

import 'package:blooddonation_admin/dashboard/patientoverview/patient_card_widget.dart';
import 'package:blooddonation_admin/models/person_model.dart';

class PatientOverviewListTile extends StatelessWidget {
  final List<Person> persons;
  final DateTime startTime;

  const PatientOverviewListTile({
    Key? key,
    required this.persons,
    required this.startTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              timeString(),
              style: const TextStyle(
                fontSize: 34,
              ),
            ),
          ),
          if (persons.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GridView.count(
                //Change to custom grid view in future
                crossAxisCount: 3,
                shrinkWrap: true,
                childAspectRatio: 7 / 6,
                children: buildPatientCards(),
              ),
            ),
        ],
      ),
    );
  }

  List<PatientCard> buildPatientCards() {
    List<PatientCard> cards = [];

    for (Person person in persons) {
      cards.add(
        PatientCard(
          person: person,
        ),
      );
    }

    return cards;
  }

  String timeString() {
    //"09.00 - 10.00 Uhr"

    int hour = startTime.hour;
    int nextHour = hour + 1;
    String hourString = hour.toString();
    String nextHourString = nextHour.toString();

    if (hour < 10) hourString = "0" + hourString;
    if (nextHour < 10) nextHourString = "0" + nextHourString;

    return "$hourString:00 - $nextHourString:00 Uhr";
  }
}
