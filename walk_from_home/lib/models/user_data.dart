class UserHealthData {
  String firstName;
  String lastName;
  String gender;
  double weight;
  double height;
  int heartRate;
  double oxygenLevel;
  String bloodPressure;
  String triedLevel;
  double distance;

  UserHealthData({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.weight,
    required this.height,
    required this.heartRate,
    required this.oxygenLevel,
    required this.bloodPressure,
    required this.triedLevel,
    required this.distance,
  });

  Map<String, dynamic> toJson() {
    return {
      'heartRate': heartRate,
      'oxygenLevel': oxygenLevel,
      'bloodPressure': bloodPressure,
      'triedLevel': triedLevel,
      'firstName': firstName,
      'lastName': lastName,
      'weight': weight,
      'height': height,
      'gender': gender,
      'distance': distance,
    };
  }
}
