class Request {
  DateTime created;
  String status;

  Request({
    required this.created,
    required this.status,
  });

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
