class Capacity {
  DateTime start;
  Duration duration;
  int slots;

  Capacity({
    required this.start,
    required this.duration,
    required this.slots,
  });

  Capacity copyWith({
    DateTime? start,
    Duration? duration,
    int? slots,
  }) =>
      Capacity(
        start: start ?? this.start,
        duration: duration ?? this.duration,
        slots: slots ?? this.slots,
      );

  factory Capacity.fromJson(Map<String, dynamic> json) => Capacity(
        start: _removeTimeZone(DateTime.parse(json["start"])),
        duration: Duration(minutes: json["duration"]),
        slots: json["slots"],
      );

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "start": _removeTimeZone(start).toString(),
        "duration": duration.inMinutes,
        "slots": slots,
      };
}

DateTime _removeTimeZone(DateTime dateTime) {
  //TODO: Not pretty when send to Server
  return dateTime.toLocal().subtract(dateTime.timeZoneOffset);
}
