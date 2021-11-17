// ignore_for_file: prefer_const_constructors

import 'package:blooddonation_admin/widgets/day_view/day_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final DateTime now = DateTime.now();
  final DateTime date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: SizedBox(
            height: double.infinity,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  bottom: 30,
                  child: Image(
                    image: AssetImage("assets/images/company_logo_full.png"),
                    height: 200,
                  ),
                ),
                SingleChildScrollView(
                  child: ExpansionPanelList.radio(
                    children: [
                      appointmentTile("0", width),
                      appointmentTile("1", width),
                      appointmentTile("2", width),
                      appointmentTile("3", width),
                      appointmentTile("4", width),
                      appointmentTile("5", width),
                      appointmentTile("6", width),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade200,
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(6),
                child: Text(
                  DateFormat("dd.MM.yyyy").format(DateTime.now()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: DayView(
                  backgroundColor: Colors.white,
                  timeLineColor: Colors.white,
                  dividerColor: Colors.black,
                  eventGridColor: Color.fromRGBO(227, 245, 255, 1),
                  lineColorFullHour: Colors.black54,
                  eventGridLineColorFullHour: Colors.black38.withOpacity(0.2),
                  eventGridLineColorHalfHour: Colors.transparent,
                  discreteStepSize: 30,
                  events: [
                    CoolCalendarEvent(
                      child: Center(
                          child: Text(
                        "Vollblutspende",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                      initTopMultiplier: 16,
                      initHeightMultiplier: 4,
                      backgroundColor: Color.fromRGBO(11, 72, 116, 1),
                    ),
                    CoolCalendarEvent(
                      child: Center(
                        child: Text(
                          "Neuer Termin",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      initTopMultiplier: 16,
                      initHeightMultiplier: 4,
                      rowIndex: 1,
                      backgroundColor: Color.fromRGBO(95, 122, 142, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ExpansionPanelRadio appointmentTile(String id, double width) {
    return ExpansionPanelRadio(
      value: id,
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) {
        if (isExpanded) {
          return Row(
            children: [
              SizedBox(
                width: width * 0.01,
              ),
              const SelectableText("24.12.2021 at 9:30pm"),
            ],
          );
        }
        return Row(
          children: [
            SizedBox(
              width: width * 0.01,
            ),
            const SelectableText("24.12.2021 at 9:30pm"),
            SizedBox(width: width * 0.05),
            const Text("Amelie Ammadeus"),
            SizedBox(width: width * 0.01),
          ],
        );
      },
      body: Padding(
        padding: EdgeInsets.only(
          left: width * 0.01,
          right: width * 0.01,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Name"),
                          SizedBox(height: 10),
                          Text("Birthday"),
                          SizedBox(height: 10),
                          Text("Issued"),
                        ],
                      ),
                      SizedBox(width: width * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Amelie Ammadeus"),
                          SizedBox(height: 10),
                          Text("15.07.1983"),
                          SizedBox(height: 10),
                          Text("today at 12:00pm"),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(11, 72, 116, 1),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text("Bestätigen"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Color.fromRGBO(11, 72, 116, 1),
                      side: BorderSide(
                        width: 2,
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text("Ablehnen"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
