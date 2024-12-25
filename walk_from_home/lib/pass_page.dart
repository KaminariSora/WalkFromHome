import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/timeCounter.dart';
import 'timeCounter.dart';

class PassPage extends StatelessWidget {
  const PassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Icon(
                Icons.check_circle_outline,
                size: MediaQuery.of(context).size.width * 0.7,
                color: Colors.black,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: AutoSizeText(
                    'ร่างกายของคุณปกติ\n สามารถทำการทดสอบได้',
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'prompt',
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    minFontSize: 12,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Fillinfrom');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                child: const Text(
                  'เริ่มการทดสอบ',
                  style: TextStyle(fontSize: 28, fontFamily: 'prompt'),
                ),
              ),
              const SizedBox(height: 30),
              // ปุ่ม "ย้อนกลับ"
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                child: const Text(
                  'ย้อนกลับ',
                  style: TextStyle(fontSize: 28, fontFamily: 'prompt'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
