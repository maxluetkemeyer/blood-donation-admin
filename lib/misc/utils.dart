DateTime getMonday(DateTime dateTime) => extractDay(dateTime).add(
      Duration(
        days: -(extractDay(dateTime).weekday - 1),
      ),
    );

DateTime extractDay(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

