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
  String walkingStride = 'normal_stride';
  bool calibrateCheck = false;
  String gender = "male";
  double height = 181.0;
  // มั่วตัวเลขแต่ 26 ใกล้เคียงขึ้น เทสเดิน 50 ก้าว นับได้ 42 ก้าว
  final double slowWalkThreshold = 26;
  final double normalWalkThreshold = 30;
  final double fastWalkThreshold = 36;
  int stepCount = 0;
  final double strideLength = 0.78;
  double stepDistanceMale = 0.40541373;
  double stepDistanceFemale = 0.39418646;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;

        double x5 = event.x * 2.5;
        double y5 = event.y * 2.5;
        double z5 = event.z * 2.5;

        // double norm = sqrt(x * x + y * y + z * z) * 5;
        double norm = sqrt(x5 * x5 + y5 * y5 + z5 * z5);
        normData = norm;
        // print("Norm : $normData");
        if (timer == null) {
          print('start timer');
          // print(normData);
          startPeriodicTimer();
        }
      });
    });
  }

  void startPeriodicTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      // print(normData);
      _checkState(normData);
    });
  }

  void _checkState(double norm) {
    if (norm < slowWalkThreshold) {
      walkingInformation = "Stop";
      print("Stop");
    } else if (norm > slowWalkThreshold &&
        norm < normalWalkThreshold &&
        norm < fastWalkThreshold) {
      walkingInformation = 'Slow_walk';
      prevNorm = norm;
      print("Slow : ${norm.toStringAsFixed(2)}");
      if (norm == prevNorm) {
        print(
            "Reach second threshold for Slow walk at ${prevNorm.toStringAsFixed(2)}.");
        prevNorm = 0;
        stepCount++;
        calibrateCheckFunction();
      }
    } else if (norm > normalWalkThreshold && norm < fastWalkThreshold) {
      walkingInformation = 'Normal_walk';
      prevNorm = norm;
      print("Normal : ${norm.toStringAsFixed(2)}");
      if (norm == prevNorm) {
        print(
            "Reach second threshold for Normal walk at ${prevNorm.toStringAsFixed(2)}.");
        prevNorm = 0;
        stepCount++;
        calibrateCheckFunction();
      }
    } else if (norm > fastWalkThreshold) {
      walkingInformation = "Fast_walk";
      prevNorm = norm;
      print("Fast : ${norm.toStringAsFixed(2)}");
      if (norm == prevNorm) {
        print(
            "Reach second threshold for Fast walk at ${prevNorm.toStringAsFixed(2)}.");
        prevNorm = 0;
        stepCount++;
        calibrateCheckFunction();
      }
    }
  }

  void calibrateCheckFunction() {
    if (calibrateCheck == true && gender == "male") {
      switch (walkingStride) {
        case "short_stride":
          stepDistanceMale = 0.3266194883;
          break;
        case "normal_stride":
          stepDistanceMale = 0.3850267;
          break;
        case "long_stride":
          stepDistanceMale = 0.438089;
          break;
        default:
          stepDistanceMale = 0.40541373;
      }
      walkingDistance = calculateCalibrateDistanceMale(stepDistanceMale, stepCount);
    } else if(calibrateCheck == true && gender == "female"){
      switch (walkingStride) {
        case "short_stride":
          stepDistanceFemale = 0.3266194883;
          break;
        case "normal_stride":
          stepDistanceFemale = 0.374;
          break;
        case "long_stride":
          stepDistanceFemale = 0.417;
          break;
        default:
          stepDistanceFemale = 0.39418646;
      }
      walkingDistance = calculateCalibrateDistanceFemale(stepDistanceFemale, stepCount);
    } else if(gender == 'male') {
      walkingDistance = calculateDistanceMale(stepDistanceMale, stepCount);
    } else if (gender == "female") {
      walkingDistance = calculateDistanceFemale(stepDistanceFemale, stepCount);
    }
  }

  double calculateDistanceMale(double stepDistanceMale, int stepCount) {
    double stepLength = 60.52;
    double stepLengthMax = 60.52+11.57;
    double stepLengthMin = 60.52-11.57;
    double stepLengthAverage = ((stepLengthMax + stepLengthMin)/2);
    double distance = (stepCount * stepLength)/100;
    double distanceMax = (stepCount * stepLengthMax)/100;
    double distanceMin = (stepCount * stepLengthMin)/100;
    double distanceAverage = (stepCount * stepLengthAverage)/100;

    double distanceUsingRatioMale = (height*stepDistanceMale*stepCount)/100;
    return distanceUsingRatioMale;
  }

  double calculateDistanceFemale(double stepDistanceFemale, int stepCount) {
    double stepLength = 56.52;
    double stepLengthMax = 56.52+5.45;
    double stepLengthMin = 56.52-5.45;
    double stepLengthAverage = ((stepLengthMax + stepLengthMin)/2);
    double distance = (stepCount * stepLength)/100;
    double distanceMax = (stepCount * stepLengthMax)/100;
    double distanceMin = (stepCount * stepLengthMin)/100;
    double distanceAverage = (stepCount * stepLengthAverage)/100;

    double distanceUsingRatioFemale = (height*stepDistanceFemale*stepCount)/100;
    return distanceUsingRatioFemale;
  }

  double calculateCalibrateDistanceMale(double walkingStride, int stepCount) {
    double distanceCalibrate = stepDistanceMale*stepCount;
    return distanceCalibrate;
  }

  double calculateCalibrateDistanceFemale(double walkingStride, int stepCount) {
    double distanceCalibrate = stepDistanceFemale*stepCount;
    return distanceCalibrate;
  }

  void resetToDefault() {
    walkingDistance = 0.0;
    stepCount = 0;
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
