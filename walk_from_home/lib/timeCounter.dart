import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Accelrometer_sensor/Accelorator.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TimeCounter extends StatefulWidget {
  const TimeCounter({super.key});

  @override
  State<TimeCounter> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  int _start = 360;
  final int _initialCountdown =
      360;
  Timer? _timer;
  bool _isRunning = false;
  double _progress = 1.0;
  final FlutterTts _flutterTts = FlutterTts();
  bool _ttsTriggered = false;
  bool isTimerRunning = false;

  void handleTimerStatusChange(bool status) {
    setState(() {
      isTimerRunning = !isTimerRunning;
    });
  }

  void toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
        isTimerRunning = true;
      });
    } else {
      _isRunning = true;
      _ttsTriggered = false;
      isTimerRunning = false;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_start > 0) {
          setState(() {
            _start--;
            progressCalculated();
          });
        } else {
          _timer?.cancel();
          setState(() {
            _isRunning = false;
            isTimerRunning = false;
          });
        }
        if (_start == 359) {
          _ttsTriggered = true;
          _flutterTts.speak("การทดสอบจะเริ่มในอีก 5 วินาที");
          _ttsTriggered = false;
        } else if(_start == 353) {
          _ttsTriggered = true;
          _flutterTts.speak("เริ่มการทดสอบได้");
          _ttsTriggered = false;
        } else if(_start == 60) {
          _ttsTriggered = true;
          _flutterTts.speak("เหลือเวลาอีก 1 นาที");
          _ttsTriggered = false;
        } else if (_start == 0) {
          _ttsTriggered = true;
          _flutterTts.speak("ยินดีด้วย คุณเดินครบเวลาที่กำหนดแล้ว");
          _ttsTriggered = false;
        }
      });
    }
  }

  void progressCalculated() {
    setState(() {
      _progress = _start / _initialCountdown;
    });
  }

  String get timeFormatted {
    final minutes = (_start ~/ 60).toString().padLeft(2, '0');
    final seconds = (_start % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    Wakelock.enable(); 
  }

  @override
  void dispose() {
    _timer?.cancel();
    Wakelock.disable();
    super.dispose();
  }

  void resetTimer() {
    setState(() {
      _start = 360;
      _progress = 1.0;
      _isRunning = false;
      isTimerRunning = false;
      _timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomProgressBar(
              width: 322,
              height: 31,
              progress: _progress,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40)),
            Center(
              child: Container(
                width: 328,
                height: 360,
                color: const Color(0xFFD9D9D9),
                child: AcceloratorFunction(isTimerRunning: isTimerRunning), 
              ),
            ),
            Text(
              timeFormatted,
              style: const TextStyle(fontSize: 48),
            ),
            ElevatedButton(
              onPressed: () {
                toggleTimer();
                handleTimerStatusChange(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: const Color.fromARGB(0, 86, 82, 82),
              ),
              child: Icon(
                _isRunning ? Icons.pause : Icons.play_arrow,
                size: 50,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _start = _initialCountdown;
                  _progress = 1.0; // Reset progress
                  _timer?.cancel();
                  _isRunning = false;
                  isTimerRunning = false;
                  handleTimerStatusChange(true);
                });
                Navigator.pushNamed(context, '/EvaluationPage');
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: const Text(
                'สิ้นสุดการทดสอบ',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: resetTimer,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: const Text('Reset',
                  style: TextStyle(fontSize: 24, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double height;
  final double width;

  const CustomProgressBar({
    Key? key,
    required this.progress,
    required this.height,
    required this.width,
    this.backgroundColor = Colors.white,
    this.progressColor = const Color(0xFF008000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: Stack(children: [
        Container(
          width: width * progress,
          decoration: BoxDecoration(
            color: progressColor,
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ]),
    );
  }
}
