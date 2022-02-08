import 'package:blooddonation_admin/services/capacity_service.dart';

void deleteThisWeek(DateTime monday) {
  for (int i = 0; i < 7; i++) {
    DateTime day = monday.add(Duration(days: i));
    CapacityService().clearDay(day);
  }
}
