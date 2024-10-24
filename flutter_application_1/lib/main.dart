import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/time_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI 3D flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TimeCounter(title: 'Flutter Demo Page'),
    );
  }
}

class TimeCounter extends StatefulWidget {
  const TimeCounter({super.key, required this.title});

  final String title;
  
  @override
  State<StatefulWidget> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}