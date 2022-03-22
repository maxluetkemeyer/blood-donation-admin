import 'package:blooddonation_admin/widgets/coolcalendar/coolcalendar_widget.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainWidget());
}

/// The top widget in the widget tree of the program
class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: CoolCalendar(
          minuteHeight: 2,
          headerTitles: [
            Container(
              color: Colors.green,
              height: 50,
            ),
            Container(
              color: Colors.blue,
              height: 50,
            ),
            Container(
              color: Colors.orange,
              height: 50,
            ),
            Container(
              color: Colors.pink,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
