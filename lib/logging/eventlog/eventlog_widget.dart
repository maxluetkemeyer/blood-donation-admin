import 'package:blooddonation_admin/logging/eventlog/eventlog_listtile_widget.dart';
import 'package:blooddonation_admin/services/logging_service.dart';
import 'package:blooddonation_admin/services/provider/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Eventlog extends ConsumerStatefulWidget {
  const Eventlog({Key? key}) : super(key: key);

  @override
  ConsumerState<Eventlog> createState() => _EventlogState();
}

class _EventlogState extends ConsumerState<Eventlog> {
  ScrollController controller = ScrollController();
  double oldOffset = 0; //show scroll down button
  bool reloading = false; //show refresh indicator

  @override
  void initState() {
    controller.addListener(() {
      if (controller.hasClients) {
        if (oldOffset == 0) {
          setState(() {
            print("set state");
            oldOffset = controller.offset;
          });
        } else {
          if (controller.offset == 0) {
            setState(() {
              print("set state");
              oldOffset = controller.offset;
            });
          }
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    int update = ref.watch(loggingUpdateProvider.state).state;

    print("rebuild logging");

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text("Eventlog"),
        centerTitle: true,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () {
              LoggingService().addEvent(DateTime.now().toString());
            },
            label: const Text("Add event"),
          ),
          TextButton.icon(
            icon: const Icon(Icons.replay_rounded),
            onPressed: () {
              //show refresh indicator
              setState(() {
                reloading = true;
              });

              //reload events
              LoggingService().reload().then((_) {
                if (!controller.hasClients) return;

                // delay to await build process
                Future.delayed(const Duration(milliseconds: 1), () {
                  //hide refresh indicator
                  setState(() {
                    reloading = false;
                  });
                  //scroll down
                  controller.jumpTo(0);
                });
              });
            },
            label: const Text("Refresh"),
          ),
        ],
      ),
      body: Stack(
        children: [
          Scrollbar( //bigger scrollbar and scrollbar track
            controller: controller,
            isAlwaysShown: true,
            showTrackOnHover: true,
            hoverThickness: 14,
            thickness: 14,
            child: ScrollConfiguration( //hide scrollbar of listview
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                controller: controller,
                itemCount: LoggingService().events.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return EventLogListTile(
                    time: DateTime.now(),
                    content: (LoggingService().events.length - index - 1).toString() +
                        " " +
                        LoggingService().events[LoggingService().events.length - index - 1],
                  );
                },
              ),
            ),
          ),
          if (reloading) const Center(child: RefreshProgressIndicator())
        ],
      ),
      floatingActionButton: (controller.hasClients && controller.offset > 0) //only show when scrolled
          ? FloatingActionButton(
              onPressed: () {
                controller.animateTo(0, duration: const Duration(seconds: 2), curve: Curves.easeInOut);
              },
              child: const Icon(Icons.arrow_downward),
            )
          : null,
    );
  }
}
