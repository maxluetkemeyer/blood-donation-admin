import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blooddonation_admin/services/provider/providers.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';

import 'request_tile_closed_widget.dart';
import 'request_tile_open_widget.dart';

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
          ref.watch(requestTileOpenProvider.state).state = EmptyAppointment();
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
          crossFadeState: isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(
            milliseconds: 200,
          ),
        ),
      ),
    );
  }
}

Widget genderIcon(String gender) {
  switch (gender) {
    case "male":
      return const Icon(
        Icons.male,
        size: 20,
      );
    case "female":
      return const Icon(
        Icons.female,
        size: 20,
      );
    default:
      return Text(gender);
  }
}
