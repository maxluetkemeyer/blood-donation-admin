import 'package:flutter/material.dart';

TableRow statisticRow({
  required String key,
  required String value,
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
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SelectableText(value.toString()),
        ),
      ),
    ],
  );
}
