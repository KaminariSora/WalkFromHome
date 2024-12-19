// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'GlobalVariable.dart';
import 'SensorFilter.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AcceloratorFunction extends StatefulWidget {
  const AcceloratorFunction({super.key});

  @override
  State<AcceloratorFunction> createState() => _AcceloratorFunctionState();
}

class _AcceloratorFunctionState extends State<AcceloratorFunction> {
  double x = 0.0, y = 0.0, z = 0.0;
  double maxX = 0.0, maxY = 0.0, maxZ = 0.0;
  int stepCount = 0;
  double walkingDistance = 0.0;

  // Update step count and walking distance
  void _updateWalkingDistance(int timeNs) {
    int steps = stepCount;

    double stepRatioMale = 0.40541373;
    double stepRatioFemale = 0.39418646;
    if (GlobalVariable.strideLength == "short_stride") {
      stepRatioMale = 0.3266194883;
      stepRatioFemale = 0.3266194883;
    } else if (GlobalVariable.strideLength == "normal_stride") {
      stepRatioMale = 0.3850267;
      stepRatioFemale = 0.374;
    } else if (GlobalVariable.strideLength == "long_stride") {
      stepRatioMale = 0.438089;
      stepRatioFemale = 0.417;
    }

    if (GlobalVariable.gender == "male") {
      walkingDistance = (GlobalVariable.height * stepRatioMale * steps) / 100;
    } else if (GlobalVariable.gender == "female") {
      walkingDistance = (GlobalVariable.height * stepRatioFemale * steps) / 100;
    }

    setState(() {
      // Update UI with the current walking distance
    });
  }

  @override
  void initState() {
    super.initState();

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;

        if (x.abs() > maxX) maxX = x.abs();
        if (y.abs() > maxY) maxY = y.abs();
        if (z.abs() > maxZ) maxZ = z.abs();
      });
    });
  }

  void resetMaxValues() {
    setState(() {
      maxX = 0.0;
      maxY = 0.0;
      maxZ = 0.0;
    });
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
        const SizedBox(height: 20),
        Text(
          'Status : ${GlobalVariable.walkingInformation}',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          'Max X: ${maxX.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          'Max Y: ${maxY.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          'Max Z: ${maxZ.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Text(
          'Walking Distance: ${walkingDistance.toStringAsFixed(2)} meters',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: resetMaxValues,
          child: const Text('Reset Max Values'),
        ),
      ],
    );
  }
}
