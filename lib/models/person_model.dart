class Person {
  String? name;
  DateTime? birthday;
  String? gender;
  bool? firstDonation;
  String? telephoneNumber;

  Person({
    this.name,
    this.birthday,
    this.gender,
    this.firstDonation,
    this.telephoneNumber,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        name: json["name"],
        birthday: json["birthday"],
        gender: json["gender"],
        firstDonation: json["firstDonation"],
        telephoneNumber: json["telephoneNumber"],
      );
}
