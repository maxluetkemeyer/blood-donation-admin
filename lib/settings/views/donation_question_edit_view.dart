import 'package:flutter/material.dart';

class DonationQuestionEditView extends StatelessWidget {
  const DonationQuestionEditView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Question Settings"),
      ),
      body: const Center(
        child: Text("Donation Question Settings")
      ),
    );
  }
}