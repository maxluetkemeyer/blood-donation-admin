import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return const BarChartSample1();
    return const SizedBox(
      width: double.infinity,
      child: Image(
        fit: BoxFit.fill,
        image: AssetImage("assets/images/dashboard.png"),
      ),
    );
  }
}
