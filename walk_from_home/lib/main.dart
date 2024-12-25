import 'package:flutter/material.dart';
import 'package:flutter_application_1/Accelrometer_sensor/Distance.dart';
import 'Accelrometer_sensor/Accelorator.dart';
import 'Description_Pass.dart';
import 'timeCounter.dart';
import 'Accelrometer_sensor/accelrometer_graph.dart';

void main() {
  runApp(const MyApp()); // Ensure this wraps with MaterialApp in MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AccelerometerGraph(),
    );
  }
}
