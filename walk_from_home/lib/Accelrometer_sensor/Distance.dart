import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() => runApp(StepCounterApp());

class StepCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StepCounterScreen(),
    );
  }
}

class StepCounterScreen extends StatefulWidget {
  @override
  _StepCounterScreenState createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends State<StepCounterScreen> {
  double accelerationX = 0.0;
  double accelerationY = 0.0;
  double accelerationZ = 0.0;
  double threshold = 1.5; // เกณฑ์สำหรับการตรวจจับก้าว
  int stepCount = 0;
  double previousMagnitude = 0.0;

  // เก็บค่าเฉลี่ยในแต่ละแกน
  List<double> recentX = [];
  List<double> recentY = [];
  List<double> recentZ = [];
  int averageWindow = 20; // จำนวนข้อมูลสำหรับการคำนวณค่าเฉลี่ย

  @override
  void initState() {
    super.initState();

    // ฟังข้อมูลจาก accelerometer
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        // อัปเดตค่าการเร่งดิบ
        accelerationX = event.x;
        accelerationY = event.y;
        accelerationZ = event.z;

        // เก็บข้อมูลใน buffer
        _addToBuffer(recentX, event.x);
        _addToBuffer(recentY, event.y);
        _addToBuffer(recentZ, event.z);

        // คำนวณค่าเฉลี่ยในแต่ละแกน
        double avgX = _calculateAverage(recentX);
        double avgY = _calculateAverage(recentY);
        double avgZ = _calculateAverage(recentZ);

        // ลบค่าเฉลี่ยออกจากค่าการเร่งดิบ
        double correctedX = accelerationX - avgX;
        double correctedY = accelerationY - avgY;
        double correctedZ = accelerationZ - avgZ;

        // คำนวณค่าเวกเตอร์การเร่งรวมที่ลบแรงโน้มถ่วงแล้ว
        double magnitude = sqrt(
            correctedX * correctedX +
            correctedY * correctedY +
            correctedZ * correctedZ);

        // ตรวจจับพีคและเปรียบเทียบกับเกณฑ์
        if ((magnitude - previousMagnitude).abs() > threshold) {
          stepCount++;
        }

        previousMagnitude = magnitude;
      });
    });
  }

  // ฟังก์ชันเพิ่มค่าใหม่ใน buffer
  void _addToBuffer(List<double> buffer, double value) {
    buffer.add(value);
    if (buffer.length > averageWindow) {
      buffer.removeAt(0); // ลบค่าที่เก่าออก
    }
  }

  // ฟังก์ชันคำนวณค่าเฉลี่ย
  double _calculateAverage(List<double> buffer) {
    if (buffer.isEmpty) return 0.0;
    return buffer.reduce((a, b) => a + b) / buffer.length;
  }

  void resetValue() {
    stepCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Step Count:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$stepCount',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Acceleration (X, Y, Z):',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'X: ${accelerationX.toStringAsFixed(2)}\n'
              'Y: ${accelerationY.toStringAsFixed(2)}\n'
              'Z: ${accelerationZ.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(onPressed: resetValue, child: Text('reset'))
          ],
        ),
      ),
    );
  }
}
