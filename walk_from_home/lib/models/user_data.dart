class UserData {
  String name;
  String email;
  int age;
  int weight;
  int height;

  UserData(
      {required this.name,
      required this.email,
      required this.age,
      required this.weight,
      required this.height});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'weight': weight,
      'height': height
    };
  }
}
