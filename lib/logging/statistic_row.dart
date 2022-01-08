import 'package:flutter/material.dart';

TableRow statisticRow({
  required String key,
  required String value,
}) {
  return TableRow(
    children: <TableCell>[
      TableCell(
        child: SelectableText(key),
      ),
      TableCell(
        child: SelectableText(value),
      ),
    ],
  );
}
