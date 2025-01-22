
import 'package:flutter/material.dart';
import '../models/Calibrate_data.dart';
// ignore_for_file: prefer_final_fields

class CalibrateProvider extends ChangeNotifier {
  CalibrateData _calibrate = CalibrateData(
    calibrateCheck: false,
    calibrateDistance: 0.0,
    calibrateStepCount: 0
  );

  CalibrateData get calibrate => _calibrate;

  void updateCalibrateCheck(bool check) {
      _calibrate.calibrateCheck = check;
      notifyListeners();
    }

  void updateCalibrateDistance(double distance) {
    _calibrate.calibrateDistance = distance;
    notifyListeners();
  }

  void updateStepCount(int steps) {
    _calibrate.calibrateStepCount = steps;
    notifyListeners();
  }
}

