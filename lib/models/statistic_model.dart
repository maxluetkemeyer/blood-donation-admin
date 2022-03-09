class Statistic {
  int numberOfFirstTimeDonations;
  int totalBookedAppointments;
  int aged18to27;
  int aged28to37;
  int aged38to47;
  int aged48to57;
  int aged58to68;
  int acceptedRequests;
  int rejectedRequests;
  int cancelledRequests;

  Statistic({
    this.numberOfFirstTimeDonations = 0,
    this.totalBookedAppointments = 0,
    this.aged18to27 = 0,
    this.aged28to37 = 0,
    this.aged38to47 = 0,
    this.aged48to57 = 0,
    this.aged58to68 = 0,
    this.acceptedRequests = 0,
    this.rejectedRequests = 0,
    this.cancelledRequests = 0,
  });

  ///Following the abstract factory pattern, an object of [FaqQuestion] can be created by using the [json] formatted Map.
  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        numberOfFirstTimeDonations: json["numberOfFirstTimeDonations"],
        totalBookedAppointments: json["totalBookedAppointments"],
        aged18to27: json["aged18to27"],
        aged28to37: json["aged28to37"],
        aged38to47: json["aged38to47"],
        aged48to57: json["aged48to57"],
        aged58to68: json["aged58to68"],
        acceptedRequests: json["acceptedRequests"],
        rejectedRequests: json["rejectedRequests"],
        cancelledRequests: json["cancelledRequests"],
      );

  Statistic copyWith({
    int? numberOfFirstTimeDonations,
    int? totalBookedAppointments,
    int? aged18to27,
    int? aged28to37,
    int? aged38to47,
    int? aged48to57,
    int? aged58to68,
    int? acceptedRequests,
    int? rejectedRequests,
    int? cancelledRequests,
  }) {
    return Statistic(
      numberOfFirstTimeDonations: numberOfFirstTimeDonations ?? this.numberOfFirstTimeDonations,
      totalBookedAppointments: totalBookedAppointments ?? this.totalBookedAppointments,
      acceptedRequests: acceptedRequests ?? this.acceptedRequests,
      aged18to27: aged18to27 ?? this.aged18to27,
      aged28to37: aged28to37 ?? this.aged28to37,
      aged38to47: aged38to47 ?? this.aged38to47,
      aged48to57: aged48to57 ?? this.aged48to57,
      aged58to68: aged58to68 ?? this.aged58to68,
      cancelledRequests: cancelledRequests ?? this.cancelledRequests,
      rejectedRequests: rejectedRequests ?? this.rejectedRequests,
    );
  }
}
