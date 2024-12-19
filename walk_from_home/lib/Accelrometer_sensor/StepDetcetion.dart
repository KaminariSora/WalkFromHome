import 'dart:math';

import 'GlobalVariable.dart';
import 'SensorFilter.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

typedef StepListener = void Function(int timeNs);

class StepDetector {
  int _accelRingSize = 50;
  int _velRingSize = 10;
  double _velCont = 0;

  double _stepThreshold = 23.439;
  static const int _stepDelayNs = 250000000;
  static const double _stepLength = 0.8;  // Average step length in meters

  int _accelRingCounter = 0;
  List<double> _accelRingX = [];
  List<double> _accelRingY = [];
  List<double> _accelRingZ = [];
  List<double> _velRing = [];
  int _velRingCounter = 0;
  int _lastStepTimeNs = 0;
  double _oldVelocityEstimate = 0;

  int _stepCount = 0;  // Variable to track steps

  StepListener? _listener;

  StepDetector() {
    _accelRingX = List.filled(_accelRingSize, 0);
    _accelRingY = List.filled(_accelRingSize, 0);
    _accelRingZ = List.filled(_accelRingSize, 0);
    _velRing = List.filled(_velRingSize, 0);
  }

  void registerListener(StepListener listener) {
    _listener = listener;
  }

  void updateAccel(int timeNs, double x, double y, double z) {
    switch (GlobalVariable.walkingInformation) {
      case "slow_walk":
        _accelRingSize = 50;
        _velRingSize = 60;
        _stepThreshold = 23.439;
        break;
      case "normal_walk":
        _accelRingSize = 50;
        _velRingSize = 10;
        _stepThreshold = 23.439;
        break;
      case "fast_walk":
        break;
      default:
        _accelRingSize = 50;
        _velRingSize = 50;
        _stepThreshold = 23.439;
    }

    if (_accelRingX.length != _accelRingSize) {
      _accelRingX = List.filled(_accelRingSize, 0);
      _accelRingY = List.filled(_accelRingSize, 0);
      _accelRingZ = List.filled(_accelRingSize, 0);
    }

    if (_velRing.length != _velRingSize) {
      _velRing = List.filled(_velRingSize, 0);
    }

    List<double> currentAccel = [x, y, z];

    _accelRingCounter++;
    _accelRingX[_accelRingCounter % _accelRingSize] = currentAccel[0];
    _accelRingY[_accelRingCounter % _accelRingSize] = currentAccel[1];
    _accelRingZ[_accelRingCounter % _accelRingSize] = currentAccel[2];

    List<double> worldZ = [
      SensorFilter.sum(_accelRingX) / min(_accelRingCounter, _accelRingSize),
      SensorFilter.sum(_accelRingY) / min(_accelRingCounter, _accelRingSize),
      SensorFilter.sum(_accelRingZ) / min(_accelRingCounter, _accelRingSize)
    ];

    double normalizationFactor = SensorFilter.norm(worldZ);

    worldZ = worldZ.map((e) => e / normalizationFactor).toList();

    double currentZ =
        SensorFilter.dot(worldZ, currentAccel) - normalizationFactor;
    _velRingCounter++;
    _velRing[_velRingCounter % _velRingSize] = currentZ;

    double velocityEstimate = SensorFilter.sum(_velRing);
    if (GlobalVariable.walkingInformation == "slow_walk") {
      _velCont = 8.25;
      velocityEstimate += _velCont;
    } else if (GlobalVariable.walkingInformation == "normal_walk") {
      _velCont = 0;
      velocityEstimate += _velCont;
    } else {
      _velCont = 0;
      velocityEstimate += _velCont;
    }

    if (velocityEstimate > _stepThreshold &&
        _oldVelocityEstimate <= _stepThreshold &&
        (timeNs - _lastStepTimeNs > _stepDelayNs)) {
      _listener?.call(timeNs);
      _lastStepTimeNs = timeNs;
      
      // Increment step count when a step is detected
      _stepCount++;
    }

    _oldVelocityEstimate = velocityEstimate;
  }

  // Method to return the walking distance
  double getWalkingDistance() {
    return _stepCount * _stepLength;  // Distance = number of steps * step length
  }
}