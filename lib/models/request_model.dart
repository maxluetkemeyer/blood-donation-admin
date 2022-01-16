class Request {
  DateTime created;
  String status;

  Request({
    required this.created,
    required this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        created: DateTime.parse(json["created"]),
        status: json["status"],
      );

  Request copyWith({
    DateTime? created,
    String? status,
  }) {
    return Request(
      created: created ?? this.created,
      status: status ?? this.status,
    );
  }
}
