import 'package:flutter/material.dart';

class PassPage extends StatelessWidget {
  const PassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ไอคอนเครื่องหมายถูก
            Icon(
              Icons.check_circle_outline,
              size: 320.0,
              color: Colors.black,
            ),
            SizedBox(height: 40),
            // ข้อความ

            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ร่างกายของคุณปกติ\nสามารถทำการทดสอบได้',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontFamily: 'prompt'),
              ),
            ),
            SizedBox(height: 120),

            // ปุ่ม "เริ่มทดสอบ"
            ElevatedButton(
              onPressed: () {
                // เริ่มทดสอบ
              },
              child: Text(
                'เริ่มการทดสอบ',
                style: TextStyle(fontSize: 28, fontFamily: 'prompt'),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white, // กำหนดสีข้อความบนปุ่ม
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    // กำหนดเส้นกรอบ
                    color: Colors.black, // สีของเส้นกรอบ
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // ปุ่ม "ย้อนกลับ"
            TextButton(
              onPressed: () {
                // ย้อนกลับ
              },
              child: Text(
                'ย้อนกลับ',
                style: TextStyle(fontSize: 28, fontFamily: 'prompt'),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white, // กำหนดสีข้อความบนปุ่ม
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    // กำหนดเส้นกรอบ
                    color: Colors.black, // สีของเส้นกรอบ
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
