// ignore_for_file: file_names

import 'dart:math';

class SensorFilter {
  SensorFilter._(); // Private constructor to prevent instantiation.

  static double sum(List<double> array) {
    return array.reduce((value, element) => value + element); // สร้างผลบวกข้อมูลทั้งหมดใน array
  }

  static List<double> cross(List<double> arrayA, List<double> arrayB) {
    // คำนวน cross product ของ array a,b
    return [
      arrayA[1] * arrayB[2] - arrayA[2] * arrayB[1],
      arrayA[2] * arrayB[0] - arrayA[0] * arrayB[2],
      arrayA[0] * arrayB[1] - arrayA[1] * arrayB[0],
    ];
  }

  static double norm(List<double> array) {
    // calculates the magnitude (or norm) of a 3D vector
    // sqrt(a1^2 + a2^2 + a3^2)
    return sqrt(array.fold(0, (sum, value) => sum + value * value));
  }

  static double dot(List<double> a, List<double> b) {
    // คำนวน dot product 
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
  }

  static List<double> normalize(List<double> array) {
    // Normalize ให้มีค่าน้อยกว่า 1 
    double normValue = norm(array);
    return array.map((value) => value / normValue).toList();
  }
}
