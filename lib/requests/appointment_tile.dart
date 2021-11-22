import 'package:flutter/material.dart';

ExpansionPanelRadio appointmentTile({
  required String id,
  required DateTime start,
  required Duration duration,
}) {
  return ExpansionPanelRadio(
    value: id,
    canTapOnHeader: true,
    
    headerBuilder: (context, isExpanded) {
      if (isExpanded) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text(start.toString()),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Text(start.toString()),
            SizedBox(width: 10),
            const Text("Amelie Ammadeus"),
            SizedBox(width: 10),
          ],
        ),
      );
    },
    body: Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
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
                    SizedBox(width: 40),
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
