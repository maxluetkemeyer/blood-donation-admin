import 'package:blooddonation_admin/services/logging_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoggingView extends ConsumerWidget {
  const LoggingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    int update = ref.watch(loggingProvider.state).state;

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            LoggingService().addEvent(DateTime.now().toString());
          },
          child: const Text("Add event"),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: LoggingService().events.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: SelectableText(index.toString() + " " + LoggingService().events[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
