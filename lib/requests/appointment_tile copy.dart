import 'package:flutter/material.dart';

ExpansionPanelRadio appointmentTile(String id,double width) {
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
