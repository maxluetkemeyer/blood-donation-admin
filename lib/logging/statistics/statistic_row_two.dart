import 'package:flutter/material.dart';

TableRow statisticRowTwo({
  required String key,
  required String value,
  required String valueTwo,
}) {
  return TableRow(
    children: <TableCell>[
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SelectableText(key),
        ),
      ),
      TableCell(
        child: Table(
          border: const TableBorder(verticalInside: BorderSide(color: Colors.black, style: BorderStyle.solid, width: 1)),
          children: [
            TableRow(
              children: <TableCell>[
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SelectableText(value),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SelectableText(valueTwo),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
