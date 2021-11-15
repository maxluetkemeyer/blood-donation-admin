import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

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
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Container(
            color: Colors.amber,
            height: double.infinity,
            child: SingleChildScrollView(
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
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            color: Colors.green,
            //Column Widget in Future
            child: DayView(
              backgroundColor: Colors.blue,
              timeLineWidth: width * 0.04,
            ),
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
            /*
            const Text(
              "(15.07.1983)",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            */
          ],
        );
      },
      body: Padding(
        padding: EdgeInsets.only(left: width * 0.01),
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
                  child: Container(
                    height: 60,
                    color: Colors.green,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: 60,
                    color: Colors.purple,
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
