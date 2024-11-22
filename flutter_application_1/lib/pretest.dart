// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Pretest extends StatefulWidget {
  const Pretest({super.key});

  @override
  State<Pretest> createState() => _PretestState();
}

class _PretestState extends State<Pretest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment
            .topCenter, // กำหนดให้ element อยู่ตรงกลางด้านบนของ Container
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .center, // จัดให้องค์ประกอบใน Column อยู่กลางแนวนอน
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "ข้อมูลก่อนการทดสอบ",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'prompt',
              ),
            ),
            const SizedBox(height: 44),
            //ช่องกรอกน้ำหนักและส่วนสูง
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  height: 116,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("อัตราการเต้นหัวใจ",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'prompt',
                                )),
                            SizedBox(
                              width: 170,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: '',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/icons/heart-pulse.png',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    inputbox("ปริมาณออกซิเจน"),
                    inputbox("ความดันโลหิต")
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget inputbox(String title) {
  return Container(
    width: 165,
    height: 151,
    padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        )),
    child: Column(
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'prompt',
            )),
        const SizedBox(height: 10.0),
        const SizedBox(
          width: 130,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
            ),
          ),
        )
      ],
    ),
  );
}
