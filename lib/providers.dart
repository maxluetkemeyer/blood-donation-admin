import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final requestTileOpenProvider = StateProvider<Appointment>((ref) {
  return Appointment(id: "-1", start: DateTime(0), duration: const Duration());
});

final calendarOverviewSelectedAppointmentProvider = StateProvider<Appointment?>((ref) {
  return;
});
