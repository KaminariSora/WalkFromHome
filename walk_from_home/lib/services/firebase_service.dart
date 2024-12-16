import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_data.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(UserData userData) async {
    await _firestore.collection('users').add(userData.toJson());
  }
}
