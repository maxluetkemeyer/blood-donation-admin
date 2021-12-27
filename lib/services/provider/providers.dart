import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final requestTileOpenProvider = StateProvider<Appointment>((ref) {
  return EmptyAppointment();
});

final calendarOverviewSelectedAppointmentProvider = StateProvider<Appointment>((ref) {
  return EmptyAppointment();
});

final plannerUpdateProvider = StateProvider<int>((ref) {
  return 0;
});

final loggingProvider = StateProvider<int>((ref) {
  return 0;
});
