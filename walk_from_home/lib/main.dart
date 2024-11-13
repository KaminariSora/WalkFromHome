import 'package:flutter/material.dart';
import 'package:flutter_application_1/Fill_infromation.dart';
import 'timeCounter.dart';
import 'Description_Pass.dart';
import 'CalibratePopup.dart';

void main() {
  runApp(const MyApp()); // Ensure this wraps with MaterialApp in MyApp
}

void showCalibratePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        child: Calibratepopup(),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: fillinfrom(),
    );
  }
}
