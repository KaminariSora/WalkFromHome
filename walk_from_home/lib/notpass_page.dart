// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class notPassPage extends StatelessWidget {
  const notPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cancel_outlined,
              size: 320.0,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            // ข้อความ

            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'ร่างกายของคุณไม่ปกติ\nไม่สามารถทำการทดสอบได้\nในขณะนี้ กรุณารอสักครู่',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontFamily: 'prompt'),
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
                    // กำหนดเส้นกรอบ
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
    );
  }
}
