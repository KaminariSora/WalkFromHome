// ignore_for_file: file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'ButtonSwapExample.dart';
import 'NavigationButton.dart';
import 'Fill_infromation.dart';

class Pretest extends StatefulWidget {
  const Pretest({super.key});

  @override
  State<Pretest> createState() => _PretestState();
}

class _PretestState extends State<Pretest> {
  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    double screenHeight = (MediaQuery.of(context).size.height) - 50;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight, // Set the height to screen height
          alignment: Alignment
              .topCenter, // กำหนดให้ element อยู่ตรงกลางด้านบนของ Container
          margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // จัดให้องค์ประกอบใน Column อยู่กลางแนวนอน
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "ข้อมูลก่อนการทดสอบ",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'prompt',
                  ),
                ),
                //ช่องกรอกน้ำหนักและส่วนสูง
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
                            Expanded(
                              child: AutoSizeText(
                                "อัตราการเต้นหัวใจ",
                                style: TextStyle(
                                  fontSize: 26, // Maximum font size
                                  fontFamily: 'prompt',
                                ),
                                maxLines: 1, // Maximum number of lines
                                minFontSize: 10, // Minimum font size
                                textAlign:
                                    TextAlign.center, // Center-align text
                              ),
                            ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    inputbox("ปริมาณออกซิเจน"),
                    inputbox("ความดันโลหิต")
                  ],
                ),
                const ButtonSwapExample(),
                Navigationbutton(
                  onForwardPressed: () {
                    Navigator.pushNamed(context, '/Fillinfrom');
                  },
                  onBackPressed: () {
                    Navigator.pop(context);
                  },
                )
              ]),
        ),
      ),
    );
  }
}

Widget inputbox(String title) {
  return Container(
    width: 150,
    height: 140,
    padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        )),
    child: Column(
      children: [
        Expanded(
          child: AutoSizeText(
            title,
            style: const TextStyle(
              fontSize: 20, // Maximum font size
              fontFamily: 'prompt',
            ),
            maxLines: 1, // Maximum number of lines
            minFontSize: 10, // Minimum font size
            textAlign: TextAlign.center, // Center-align text
          ),
        ),
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
