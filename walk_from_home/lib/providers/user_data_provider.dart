// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../models/user_data.dart';
import '../services/firebase_service.dart';

class UserDataProvider extends ChangeNotifier {
  UserHealthData _userData = UserHealthData(
    firstName: '',
    lastName: '',
    gender: '',
    heartRate: 0,
    oxygenLevel: 0.0,
    bloodPressure: '',
    triedLevel: '',
    weight: 0.0,
    height: 0.0,
    distance: 0.0,
  );

  UserHealthData get userData => _userData;

  // ฟังก์ชันสำหรับอัปเดตตัวแปรแต่ละตัว
  void updateFirstName(String firstName) {
    _userData.firstName = firstName;
    notifyListeners();
  }

  void updateLastName(String lastName) {
    _userData.lastName = lastName;
    notifyListeners();
  }

  void updateGender(String gender) {
    _userData.gender = gender;
    notifyListeners();
  }

  void updateHeartRate(int heartRate) {
    _userData.heartRate = heartRate;
    notifyListeners();
  }

  void updateOxygenLevel(double oxygenLevel) {
    _userData.oxygenLevel = oxygenLevel;
    notifyListeners();
  }

  void updateBloodPressure(String bloodPressure) {
    _userData.bloodPressure = bloodPressure;
    notifyListeners();
  }

  void updateTriedLevel(String triedLevel) {
    _userData.triedLevel = triedLevel;
    notifyListeners();
  }

  void updateWeight(double weight) {
    _userData.weight = weight;
    notifyListeners();
  }

  void updateHeight(double height) {
    _userData.height = height;
    notifyListeners();
  }

  void updateDistance(double distance) {
    _userData.distance = distance;
    notifyListeners();
  }

  // ฟังก์ชันสำหรับอัปเดตหลายตัวแปรพร้อมกัน
  void updateUserData({
    String? firstName,
    String? lastName,
    String? gender,
    int? heartRate,
    double? oxygenLevel,
    String? bloodPressure,
    String? triedLevel,
    double? weight,
    double? height,
    double? distance,
  }) {
    if (firstName != null) _userData.firstName = firstName;
    if (lastName != null) _userData.lastName = lastName;
    if (gender != null) _userData.gender = gender;
    if (heartRate != null) _userData.heartRate = heartRate;
    if (oxygenLevel != null) _userData.oxygenLevel = oxygenLevel;
    if (bloodPressure != null) _userData.bloodPressure = bloodPressure;
    if (triedLevel != null) _userData.triedLevel = triedLevel;
    if (weight != null) _userData.weight = weight;
    if (height != null) _userData.height = height;
    if (distance != null) _userData.distance = distance;

    notifyListeners();
  }

  Future<void> saveToFirebase() async {
    final firebaseService = FirebaseService();
    await firebaseService.saveUserData(_userData);
  }
}
