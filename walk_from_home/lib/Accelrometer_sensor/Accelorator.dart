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
  double prevNorm = 0.0;
  double walkingDistance = 0.0;
  String walkingInformation = 'Stop';
  final double slowWalkThreshold = 3.7;
  final double normalWalkThreshold = 6;
  final double fastWalkThreshold = 7;
  int stepCount = 0;
  final double strideLength = 0.78;

  Timer? timer;

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
//  ต้องอัพเดท norm ทุกๆ .25 วิให้ได้ ตอนนี้ norm ไท้อัพเดทเพราะติด timer == null
        if (timer == null) {
          print('start timer');
          print(norm);
          startPeriodicTimer(norm);
        }
      });
    });
  }
  void startPeriodicTimer(double norm) {
    timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      _checkState(norm);
    });
  }

  void _checkState(double norm) {
    if (norm < slowWalkThreshold) {
      walkingInformation = "Stop";
      // print("Stop");
    } else if (norm > slowWalkThreshold && norm < normalWalkThreshold && norm < fastWalkThreshold) {
      walkingInformation = 'Slow_walk';
      prevNorm = norm;
      print("Slow : ${norm.toStringAsFixed(2)}");
      if (norm == prevNorm) {
        print("Reach second threshold for Slow walk at ${prevNorm.toStringAsFixed(2)}.");
        prevNorm = 0;
      }
    } else if (norm > normalWalkThreshold && norm < fastWalkThreshold) {
      walkingInformation = 'Normal_walk';
      prevNorm = norm;
      print("Normal : ${norm.toStringAsFixed(2)}");
      if (norm == prevNorm) {
        print("Reach second threshold for Normal walk at ${prevNorm.toStringAsFixed(2)}.");
        prevNorm = 0;
      }
    } else if (norm > fastWalkThreshold) {
      walkingInformation = "Fast_walk";
      prevNorm = norm;
      print("Fast : ${norm.toStringAsFixed(2)}");
      if (norm == prevNorm) {
        print("Reach second threshold for Fast walk at ${prevNorm.toStringAsFixed(2)}.");
        prevNorm = 0;
      }
    }
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
