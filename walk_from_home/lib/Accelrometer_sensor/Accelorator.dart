// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AcceloratorFunction extends StatefulWidget {
  const AcceloratorFunction({super.key});

  @override
  State<AcceloratorFunction> createState() => _AcceloratorFunctionState();
}

class _AcceloratorFunctionState extends State<AcceloratorFunction> {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  double normData = 0.0;
  double walkingDistance = 0.0;
  String walkingInformation = 'Stop';
  int stepCount = 0;
  final double strideLength = 0.78;

  Timer? _debounceTimer;
  @override
  void initState() {
    super.initState();

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;

        double norm = sqrt(x * x + y * y + z * z) * 5;
        normData = norm;

        if (normData > 30) { // ไม่รู้ว่า norm ต้องเท่าไหร่
          walkingInformation = 'Fast_walk';
          if (_debounceTimer?.isActive ?? false) {
            _debounceTimer?.cancel();
          }
          Timer(const Duration(milliseconds: 250), () {
            distanceCalculate(walkingInformation);
          });
        } else if (normData > 10) { // ไม่รู้ว่า norm ต้องเท่าไหร่
          walkingInformation = 'Normal_walk';
          if (_debounceTimer?.isActive ?? false) {
            _debounceTimer?.cancel();
          }
          // 1 nanosecond = 0.001 microseconds
          Timer(const Duration(milliseconds: 250), () {
            distanceCalculate(walkingInformation);
          });
        } else {
          walkingInformation = 'Stop';
        }
      });
    });
  }

  void resetToDefault() {
    walkingDistance = 0.0;
    stepCount = 0;
  }

  void distanceCalculate(String walkingInformation) async {
    switch (walkingInformation) {
      case 'Slow_walk':
        print('slow');
        walkingDistance += strideLength * 0.5;
        break;
      case 'Normal_walk':
        print('normal');
        walkingDistance += strideLength;
        break;
      case 'Fast_walk':
        print('fast');
        walkingDistance += strideLength * 1.2;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Current X: ${x.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          'Current Y: ${y.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          'Current Z: ${z.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          'Current Norm: ${normData.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 20),
        Text(
          'Status: $walkingInformation',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Text(
          'Walking Distance: ${walkingDistance.toStringAsFixed(2)} meters',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Step Count: $stepCount',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(onPressed: resetToDefault, child: const Text('Reset'))
      ],
    );
  }
}
