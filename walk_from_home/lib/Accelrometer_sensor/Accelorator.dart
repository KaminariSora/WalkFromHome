// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Calibrate_data.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/providers/FAQBeforeTest_provider.dart';
import 'package:flutter_application_1/providers/calibrate_provider.dart';
import 'package:flutter_application_1/providers/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:o3d/o3d.dart';

class AcceloratorFunction extends StatefulWidget {
  final bool isTimerRunning; // Receive timer status

  const AcceloratorFunction({Key? key, required this.isTimerRunning})
      : super(key: key);

  @override
  State<AcceloratorFunction> createState() => _AcceloratorFunctionState();
}

class _AcceloratorFunctionState extends State<AcceloratorFunction> {
  O3DController o3dController = O3DController();
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
  String gender = '';
  // String gender = UserHealthData(firstName: firstName, lastName: lastName, gender: gender, weight: weight, height: height, heartRate: heartRate, oxygenLevel: oxygenLevel, bloodPressure: bloodPressure, triedLevel: triedLevel, distance: distance)
  double height = 0;
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
        calibrateCheckFunction(context);
      }
    } else if (norm > normalWalkThreshold && norm < fastWalkThreshold) {
      walkingInformation = 'Normal_walk';
      prevNorm = norm;
      if (norm == prevNorm) {
        prevNorm = 0;
        stepCount++;
        calibrateCheckFunction(context);
      }
    } else if (norm > fastWalkThreshold) {
      walkingInformation = "Fast_walk";
      prevNorm = norm;
      if (norm == prevNorm) {
        prevNorm = 0;
        stepCount++;
        calibrateCheckFunction(context);
      }
    }
  }

  void calibrateCheckFunction(BuildContext context) {
    final faqProvider = Provider.of<FAQBeforeTestProvider>(context, listen: false);
    final faq = faqProvider.faq;
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    final userData = userDataProvider.userData;
    final calibrateProvider = Provider.of<CalibrateProvider>(context, listen: false);
    final CalibrateData = calibrateProvider.calibrate;
    final stepDistance = CalibrateData.calibrateDistance/CalibrateData.calibrateStepCount;
    gender = userData.gender;
    height = userData.height;

    if (CalibrateData.calibrateCheck == true && gender == "male") {
      walkingDistance = calculateCalibrateDistanceMale(stepDistance, stepCount);
      userData.distance = walkingDistance;
    } else if (CalibrateData.calibrateCheck == true && gender == "female") {
      walkingDistance = calculateCalibrateDistanceFemale(stepDistance, stepCount);
      userData.distance = walkingDistance;
    } else if (CalibrateData.calibrateCheck == false && gender == 'male') {
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
          stepDistanceMale = 0.40541373;
      }
      walkingDistance = calculateDistanceMale(stepDistanceMale, stepCount);
      userData.distance = walkingDistance;
    } else if (CalibrateData.calibrateCheck == false && gender == "female") {
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
      walkingDistance = calculateDistanceFemale(stepDistanceFemale, stepCount);
      userData.distance = walkingDistance;
    }
  }

  double calculateDistanceMale(double stepDistanceMale, int stepCount) {
    print('calculated male');
    print(stepDistanceMale);
    return (height * stepDistanceMale * stepCount) / 100;
  }

  double calculateDistanceFemale(double stepDistanceFemale, int stepCount) {
    print('calculated female');
    return (height * stepDistanceFemale * stepCount) / 100;
  }

  double calculateCalibrateDistanceMale(double stepDistanceMale, int stepCount) {
    double distanceCalibrate = stepDistanceMale * stepCount;
    print(' calibrate calculated male');
    return distanceCalibrate;
  }

  double calculateCalibrateDistanceFemale(double stepDistanceFemale, int stepCount) {
    double distanceCalibrate = stepDistanceFemale * stepCount;
    print(' calibrate calculated female');
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
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
    final userData = userDataProvider.userData;
    final calibrateProvider = Provider.of<CalibrateProvider>(context, listen: false);
    final CalibrateData = calibrateProvider.calibrate;
    gender = userData.gender;
    height = userData.height;

    return Transform.translate(
                  offset: const Offset(-40, -90),
                  child: Transform.scale(
                    scale: 1.5,
                    child: O3D(
                      src: 'assets/grandpa.glb',
                      controller: o3dController,
                      ar: false,
                      autoPlay: true,
                      autoRotate: false,
                      cameraControls: false,
                      cameraTarget: CameraTarget(-.25, 1.5, 1.5),
                      cameraOrbit: CameraOrbit(0, 90, 1),
                    ),
                  ),
                );
  }
}
