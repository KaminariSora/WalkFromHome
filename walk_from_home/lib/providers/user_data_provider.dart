import 'package:flutter/material.dart';
import '../models/user_data.dart';
import '../services/firebase_service.dart';

class UserDataProvider extends ChangeNotifier {
  UserData _userData =
      UserData(name: '', email: '', age: 0, weight: 0, height: 0);

  UserData get userData => _userData;

  void updateName(String name) {
    _userData.name = name;
    notifyListeners();
  }

  void updateEmail(String email) {
    _userData.email = email;
    notifyListeners();
  }

  void updateAge(int age) {
    _userData.age = age;
    notifyListeners();
  }

  void updateWeight(int weight) {
    _userData.weight = weight;
    notifyListeners();
  }

  void updateHeight(int height) {
    _userData.height = height;
    notifyListeners();
  }

  Future<void> saveToFirebase() async {
    final firebaseService = FirebaseService();
    await firebaseService.saveUserData(_userData);
  }
}
