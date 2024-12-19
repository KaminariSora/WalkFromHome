// ignore_for_file: await_only_futures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class Test01 extends StatefulWidget {
  const Test01({super.key});

  @override
  State<Test01> createState() => _Test01State();
}

class _Test01State extends State<Test01> {
  String _stepCountValue = 'Unknown';
  late StreamSubscription<StepCount> _subscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();  // Request permission on start
  }

  // Request activity recognition permission
  Future<void> _requestPermission() async {
    // Request the permission for step counting (only on Android)
    var status = await Permission.activityRecognition.request();

    if (status.isGranted) {
      initPlatformState();  // Initialize the pedometer if permission is granted
    } else {
      setState(() {
        _stepCountValue = 'Permission Denied';
      });
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Initialize the pedometer plugin
    _subscription = Pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);

    if (!mounted) return;
  }

  void _onData(StepCount stepCountValue) {
    print(stepCountValue.steps);

    setState(() {
      _stepCountValue = "${stepCountValue.steps}";
    });
  }

  void _onDone() {
    print('Stream has completed.');
  }

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  @override
  void dispose() {
    // Dispose the subscription when the widget is disposed to prevent memory leaks
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pedometer Example'),
        ),
        body: Center(
          child: Text('Steps taken: $_stepCountValue\n'),
        ),
      ),
    );
  }
}
