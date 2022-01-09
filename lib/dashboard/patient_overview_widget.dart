import 'package:blooddonation_admin/dashboard/patientoverview/patient_listtile_widget.dart';
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
        child: ListView(
          controller: controller,
          children: const [
            PatientOverviewListTile(),
            PatientOverviewListTile(),
            PatientOverviewListTile(),
          ],
        ),
      ),
    );
  }
}
