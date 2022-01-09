import 'package:blooddonation_admin/dashboard/patientoverview/patient_card_widget.dart';
import 'package:flutter/material.dart';

class PatientOverviewListTile extends StatelessWidget {
  const PatientOverviewListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "09.00 - 10.00 Uhr",
              style: TextStyle(
                fontSize: 34,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GridView.count(
              //Change to custom grid view in future
              crossAxisCount: 3,
              shrinkWrap: true,
              childAspectRatio: 7 / 6,
              children: const [
                PatientCard(),
                PatientCard(),
                PatientCard(),
                PatientCard(),
                PatientCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
