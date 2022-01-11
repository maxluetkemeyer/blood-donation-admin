import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
          "Helene Hubbert",
          style: TextStyle(
            fontSize: width * 0.013,
          ),
        ),
        Icon(
          Icons.female,
          size: width * 0.013,
        ),
        Text(
          "09.01.1990",
          style: TextStyle(
            fontSize: width * 0.013,
          ),
        ),
      ],
    );
  }
}
