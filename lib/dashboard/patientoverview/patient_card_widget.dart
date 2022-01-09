import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Icon(
          Icons.person,
          size: 150,
        ),
        Text(
          "Helene Hubbert",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        Icon(
          Icons.female,
          size: 26,
        ),
        Text(
          "09.01.1990",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
