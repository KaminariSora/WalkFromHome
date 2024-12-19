class GlobalVariable {
  static String? firstName;
  static String? lastName;
  static int? exhaustion;
  static double? heartRate;
  static double? bloodOxygen;
  static double? bloodPress;
  // static String? gender;
  static String gender = 'male';
  static int step = 0;
  static double height = 0.0;
  static double weight = 0.0;
  static String strideLength = "normal_stride";
  static String walkingInformation = "normal_walk";
  static int walkId = 0;
  static double walkingDistance = 0.0;
  static bool loginCheck = false;
  static double strideLengthCalibrate = 0.0;
  static bool calibrateCheck = false;
}

// ใส่ static เพื่อจะได้สามารถเรียกใช้งาน member ใน class โดยที่ไม่ต้องสร้าง instance หรือ Object