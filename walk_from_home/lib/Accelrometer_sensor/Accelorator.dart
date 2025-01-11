// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/FAQBeforeTest_provider.dart';
import 'package:flutter_application_1/providers/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AcceloratorFunction extends StatefulWidget {
  final bool isTimerRunning; // Receive timer status

  const AcceloratorFunction({Key? key, required this.isTimerRunning})
      : super(key: key);

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
  int stepCount = 0;
  String walkingInformation = 'Stop';
  final double slowWalkThreshold = 26;
  final double normalWalkThreshold = 30;
  final double fastWalkThreshold = 36;
  bool calibrateCheck = false;
  String gender = 'male';
  double height = 180;
  double stepDistanceMale = 0.40541373;
  double stepDistanceFemale = 0.39418646;

  Timer? timer;
  StreamSubscription? _accelerometerSubscription;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();

    // Start listening to accelerometer data
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;

        double x5 = event.x * 2.5;
        double y5 = event.y * 2.5;
        double z5 = event.z * 2.5;

        double norm = sqrt(x5 * x5 + y5 * y5 + z5 * z5);
        normData = norm;

        if (widget.isTimerRunning && timer == null) {
          startPeriodicTimer();
        }

        if (!widget.isTimerRunning && timer != null) {
          stopPeriodicTimer();
        }
      });
    });
  }

  void startPeriodicTimer() {
    if (timer == null || !timer!.isActive) {
      Future.delayed(const Duration(seconds: 5), () {
        if (timer == null || !timer!.isActive) {
          timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
            _checkState(normData);
          });
        }
      });
    }
  }

  void stopPeriodicTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  void _checkState(double norm) {
    if (norm < slowWalkThreshold) {
      walkingInformation = "Stop";
    } else if (norm > slowWalkThreshold && norm < normalWalkThreshold) {
      walkingInformation = 'Slow_walk';
      prevNorm = norm;
      if (norm == prevNorm) {
        prevNorm = 0;
        stepCount++;
        calibrateCheckFunction();
      }
    } else if (norm > normalWalkThreshold && norm < fastWalkThreshold) {
      walkingInformation = 'Normal_walk';
      prevNorm = norm;
      if (norm == prevNorm) {
        prevNorm = 0;
        stepCount++;
        calibrateCheckFunction();
      }
    } else if (norm > fastWalkThreshold) {
      walkingInformation = "Fast_walk";
      prevNorm = norm;
      if (norm == prevNorm) {
        prevNorm = 0;
        stepCount++;
        calibrateCheckFunction();
      }
    }
  }

  void calibrateCheckFunction() {
    final faqProvider = Provider.of<FAQBeforeTestProvider>(context, listen: false);
    final faq = faqProvider.faq;
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final userData = userDataProvider.userData;
    gender = userData.gender;
    height = userData.height;

    if (calibrateCheck == true && gender == "male") {
      switch (faq.walkingStride) {
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
          print('default');
          stepDistanceMale = 0.40541373;
      }
      walkingDistance =
          calculateCalibrateDistanceMale(stepDistanceMale, stepCount);
    } else if (calibrateCheck == true && gender == "female") {
      switch (faq.walkingStride) {
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
      walkingDistance =
          calculateCalibrateDistanceFemale(stepDistanceFemale, stepCount);
    } else if (calibrateCheck == false && gender == 'male') {
      walkingDistance = calculateDistanceMale(stepDistanceMale, stepCount);
    } else if (calibrateCheck == false && gender == "female") {
      walkingDistance = calculateDistanceFemale(stepDistanceFemale, stepCount);
    }
  }

  double calculateDistanceMale(double stepDistanceMale, int stepCount) {
    return (height * stepDistanceMale * stepCount) / 100;
  }

  double calculateDistanceFemale(double stepDistanceFemale, int stepCount) {
    return (height * stepDistanceFemale * stepCount) / 100;
  }

  double calculateCalibrateDistanceMale(
      double stepDistanceMale, int stepCount) {
    double distanceCalibrate = stepDistanceMale * stepCount;
    return distanceCalibrate;
  }

  double calculateCalibrateDistanceFemale(
      double stepDistanceFemale, int stepCount) {
    double distanceCalibrate = stepDistanceFemale * stepCount;
    return distanceCalibrate;
  }

  void resetToDefault() {
    walkingDistance = 0.0;
    stepCount = 0;
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final faqProvider = Provider.of<FAQBeforeTestProvider>(context);
    final faq = faqProvider.faq;
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final userData = userDataProvider.userData;
    gender = userData.gender;
    height = userData.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'WalkingType: ${faq.walkingType}',
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          'WalkingStride: ${faq.walkingStride}',
          style: const TextStyle(fontSize: 15),
        ),
        Text(
          'Gender: $gender',
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
