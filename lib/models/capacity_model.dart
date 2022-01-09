class Capacity {
  DateTime start;
  Duration duration;
  int chairs;

  Capacity({
    required this.start,
    required this.duration,
    required this.chairs,
  });

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    "start": start.toString(),
    "duration": duration.inMinutes,
    "chairs": chairs,
  };
}
