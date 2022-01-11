import 'package:flutter/material.dart';

class ChairEdit extends StatefulWidget {
  final int chairs;

  const ChairEdit({
    Key? key,
    required this.chairs,
  }) : super(key: key);

  @override
  _ChairEditState createState() => _ChairEditState();
}

class _ChairEditState extends State<ChairEdit> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.chairs.toString() + " Stühle");
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: controller,
        //enabled: true,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        textAlign: TextAlign.center,
      ),
    );

    /*return TextField(
      controller: controller,
    );
    
    Text(
        widget.chairs.toString() + " Stühle",
      ),
    */
  }
}
