class Appointment {
  String id;
  DateTime start;
  Duration duration;

  Appointment({
    required this.id,
    required this.start,
    required this.duration,
  });

  @override
  String toString() {
    return "Appointment " + id + " " + start.toString() + " " + duration.toString();
  }
}
