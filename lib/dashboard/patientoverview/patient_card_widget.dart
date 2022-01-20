import 'package:flutter/material.dart';

import 'package:blooddonation_admin/models/person_model.dart';
import 'package:intl/intl.dart';

class PatientCard extends StatelessWidget {
  final Person person;

  const PatientCard({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    String name = person.name ?? "";
    String gender = person.gender ?? "";
    String birthday = person.birthday != null ? DateFormat("dd.MM.yyyy").format(person.birthday!) : "";

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.person,
          //size: 150,
          size: width * 0.08,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: width * 0.013,
          ),
        ),
        genderIcon(gender, width * 0.013),
        Text(
          birthday,
          style: TextStyle(
            fontSize: width * 0.013,
          ),
        ),
      ],
    );
  }
}

Widget genderIcon(String gender, double width) {
  switch (gender) {
    case "male":
      return Icon(
        Icons.male,
        size: width,
      );
    case "female":
      return Icon(
        Icons.female,
        size: width,
      );
    default:
      return Text(
        gender,
        style: TextStyle(
          fontSize: width - 3, //not pretty, change structure to fit to sizedbox
        ),
      );
  }
}
