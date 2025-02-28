// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:walk_from_home/Accelrometer_sensor/Accelorator.dart';

class TimeCounter extends StatefulWidget {
  const TimeCounter({super.key});

  @override
  State<TimeCounter> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  int _start = 360;
  final int _initialCountdown = 360;
  Timer? _timer;
  bool _isRunning = false;
  double _progress = 1.0;
  final FlutterTts _flutterTts = FlutterTts();
  bool _ttsTriggered = false;
  bool isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    setupTTS();
  }

  @override
  void dispose() {
    _timer?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  Future<void> setupTTS() async {
    await _flutterTts.setEngine("com.google.android.tts");
    await _flutterTts.setLanguage("th-TH");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  void handleTimerStatusChange(bool status) {
    setState(() {
      isTimerRunning = !isTimerRunning;
    });
  }

  Completer<void>? _delayCompleter;

  void toggleTimer() async {
    if (_isRunning) {
      _timer?.cancel();
      _timer = null;
      _delayCompleter?.complete(); // ยกเลิกการหน่วงเวลา (ถ้ามี)
      _delayCompleter = null; // รีเซ็ตเพื่อให้ใช้งานใหม่ได้
      setState(() {
        _isRunning = false;
        isTimerRunning = false;
      });
      return;
    }

    _flutterTts.speak("การทดสอบจะเริ่มในอีก 5 วินาที");
    _isRunning = true;
    isTimerRunning = false;
    _ttsTriggered = false;

    _delayCompleter = Completer<void>(); // สร้าง Completer ใหม่ทุกครั้ง
    await Future.any([
      Future.delayed(const Duration(seconds: 5)), // หน่วงเวลา 5 วินาที
      _delayCompleter!.future, // สามารถถูกยกเลิกได้
    ]);

    if (!_isRunning) return; // ตรวจสอบอีกครั้งว่าผู้ใช้ได้หยุดไปก่อนหรือไม่

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isRunning) {
        _timer?.cancel();
        _timer = null;
        return;
      }

      if (_start > 0) {
        setState(() {
          _start--;
          progressCalculated();
        });
      } else {
        _timer?.cancel();
        _timer = null;
        setState(() {
          _isRunning = false;
          isTimerRunning = false;
        });
        Navigator.pushNamed(context, '/EvaluationPage');
      }

      checkTTSAnnouncements();
    });
  }

  Future<void> checkTTSAnnouncements() async {
    if (_start == 359) {
      await _flutterTts.speak("เริ่มการทดสอบได้");
    } else if (_start == 300) {
      await _flutterTts.speak("เหลือเวลาอีก 5 นาที");
    } else if (_start == 240) {
      await _flutterTts.speak("เหลือเวลาอีก 4 นาที");
    } else if (_start == 180) {
      await _flutterTts.speak("เหลือเวลาอีก 3 นาที");
    } else if (_start == 120) {
      await _flutterTts.speak("เหลือเวลาอีก 2 นาที");
    } else if (_start == 60) {
      await _flutterTts.speak("เหลือเวลาอีก 1 นาที");
    } else if (_start == 1) {
      await _flutterTts.speak("ยินดีด้วย คุณเดินครบเวลาที่กำหนดแล้ว");
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
                  isTimerRunning = true;
                  // handleTimerStatusChange(true);
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
            const SizedBox(
              height: 20,
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
