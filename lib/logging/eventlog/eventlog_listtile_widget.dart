import 'package:flutter/material.dart';

import 'package:blooddonation_admin/misc/utils.dart';

class EventLogListTile extends StatelessWidget {
  final DateTime time;
  final String content;

  const EventLogListTile({
    Key? key,
    required this.time,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SelectableText(dayWithTimeString(time)),
      title: SelectableText(content),
    );
  }
}
