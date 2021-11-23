import 'package:blooddonation_admin/requests/request_tile_closed_widget.dart';
import 'package:blooddonation_admin/requests/request_tile_open_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blooddonation_admin/providers.dart';
import 'package:blooddonation_admin/services/appointment_model.dart';

class RequestTile extends ConsumerWidget {
  final Appointment appointment;
  const RequestTile({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isOpen = ref.watch(requestTileOpenProvider.state).state == appointment;

    return GestureDetector(
      onTap: () {
        if (ref.watch(requestTileOpenProvider.state).state == appointment) {
          ref.watch(requestTileOpenProvider.state).state = Appointment(
              id: "-1", start: DateTime(0), duration: const Duration());
        } else {
          ref.watch(requestTileOpenProvider.state).state = appointment;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          color: isOpen ? Colors.lightBlue.shade50 : Colors.white,
          border: const Border(
            bottom: BorderSide(width: 1.0, color: Colors.black26),
          ),
        ),
        child: AnimatedCrossFade(
          firstChild: RequestTileClosed(
            appointment: appointment,
          ),
          secondChild: RequestTileOpen(
            appointment: appointment,
          ),
          crossFadeState:
              isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(
            milliseconds: 200,
          ),
        ),
      ),
    );
  }
}
