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
            Icon(
              Icons.cancel_outlined,
              size: 320.0,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            // ข้อความ

            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ร่างกายของคุณไม่ปกติ\nไม่สามารถทำการทดสอบได้\nในขณะนี้ กรุณารอสักครู่',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontFamily: 'prompt'),
              ),
            ),

            SizedBox(height: 30),
            // ปุ่ม "ย้อนกลับ"
            TextButton(
              onPressed: () {},
              child: Text(
                'ย้อนกลับ',
                style: TextStyle(fontSize: 28, fontFamily: 'prompt'),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    // กำหนดเส้นกรอบ
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
