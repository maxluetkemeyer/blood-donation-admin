import 'package:flutter/material.dart';

Color requestColor(String status) {
  switch (status) {
    case "pending":
      return Colors.amber.shade200;
    case "accepted":
      return Colors.lightGreen.shade200;
    case "declined":
      return Colors.deepOrange;
    default:
      return Colors.white;
  }
}

//appointment
BoxDecoration appointmentDecoration = BoxDecoration(
  color: const Color.fromRGBO(11, 72, 116, 1),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    width: 1,
    color: Colors.black26,
  ),
);
BoxDecoration appointmentDecorationHover = BoxDecoration(
  color: const Color.fromRGBO(90, 160, 213, 1),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    width: 1,
    color: Colors.white,
  ),
);

//declined
BoxDecoration appointmentDeclinedDecoration = BoxDecoration(
  color: requestColor("declined"),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    width: 1,
    color: Colors.black26,
  ),
);
BoxDecoration appointmentDeclinedDecorationHover = BoxDecoration(
  color: const Color.fromRGBO(90, 160, 213, 1),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    width: 1,
    color: Colors.white,
  ),
);

//pending
BoxDecoration appointmentPendingDecoration = BoxDecoration(
  color: requestColor("pending"),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    width: 1,
    color: Colors.black26,
  ),
);
BoxDecoration appointmentPendingDecorationHover = BoxDecoration(
  color: const Color.fromRGBO(90, 160, 213, 1),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    width: 1,
    color: Colors.white,
  ),
);

//selected appointment
BoxDecoration appointmentSelectedDecoration = BoxDecoration(
  color: Colors.green,
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    width: 1,
    color: Colors.black26,
  ),
);
BoxDecoration appointmentSelectedDecorationHover = BoxDecoration(
  color: Colors.greenAccent,
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    width: 1,
    color: Colors.white,
  ),
);

//empty
BoxDecoration appointmentEmptyDecoration = BoxDecoration(
  color: const Color.fromRGBO(242, 249, 250, 0.1),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    width: 1,
    color: Colors.black26,
  ),
);
BoxDecoration appointmentEmptyDecorationHover = BoxDecoration(
  color: const Color.fromRGBO(242, 249, 250, 0.8),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    width: 2,
    color: Colors.white,
  ),
);
