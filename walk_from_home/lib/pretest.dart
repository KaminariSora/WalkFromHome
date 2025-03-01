// ignore_for_file: file_names, unused_element

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:walk_from_home/providers/user_data_provider.dart';
import 'ButtonSwapExample.dart';
import 'NavigationButton.dart';

class Pretest extends StatefulWidget {
  const Pretest({super.key});

  @override
  State<Pretest> createState() => _PretestState();
}

class _PretestState extends State<Pretest> {
  final heartRateController = TextEditingController();
  final oxygenLevelController = TextEditingController();
  final bloodPressureController = TextEditingController();

  String currentTriedLevel =
      'ไม่เหนื่อยเลย'; // เก็บค่าล่าสุดของ buttonInfo[0].text
  int currentTriedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    double screenHeight = (MediaQuery.of(context).size.height) - 50;
    final userDataProvider = Provider.of<UserDataProvider>(context);

    void dispose() {
      // ล้าง memory ของ controller
      heartRateController.dispose();
      oxygenLevelController.dispose();
      bloodPressureController.dispose();
      super.dispose();
    }

    void showAlert(BuildContext context, String message,
        {TextStyle textStyle = const TextStyle()}) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("แจ้งเตือน"),
            content: Text(
              message,
              style: textStyle, // ใช้ style ที่ได้รับเป็นพารามิเตอร์
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("ตกลง"),
              ),
            ],
          );
        },
      );
    }

    void onNextButtonPressed() {
      String heart = heartRateController.text.trim();
      String oxegen = oxygenLevelController.text.trim();
      String blood = bloodPressureController.text.trim();

      if (heart.isEmpty || oxegen.isEmpty || blood.isEmpty) {
        showAlert(context, "กรุณากรอกข้อมูลให้ครบถ้วน");
      } else if (heart.isNotEmpty && oxegen.isNotEmpty || blood.isNotEmpty) {
        int heartRate = int.parse(heartRateController.text);
        double oxygenLevel = double.parse(heartRateController.text);

        if ((heartRate >= 101) ||
            (oxygenLevel <= 59) ||
            (currentTriedIndex >= 2)) {
          Navigator.pushNamed(context, '/NotPasspage');
        } else {
          userDataProvider.updateHeartRate(heartRate);
          userDataProvider.updateOxygenLevel(oxygenLevel);
          userDataProvider.updateBloodPressure(bloodPressureController.text);
          userDataProvider.updateTriedLevel(currentTriedLevel);
          Navigator.pushNamed(context, '/Passpage');
        }
      }
    }

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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
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
                                controller: heartRateController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
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
                    inputbox("ปริมาณออกซิเจน", oxygenLevelController),
                    inputbox("ความดันโลหิต", bloodPressureController)
                  ],
                ),
                ButtonSwapExample(
                  onMainButtonChanged: (Map<String, dynamic> value) {
                    setState(() {
                      currentTriedLevel = value['text'];
                      currentTriedIndex = value['index'];
                    });
                  },
                ),
                // Text('ค่าความรู้สึกปัจจุบัน: $currentTriedLevel'),
                Navigationbutton(
                  onForwardPressed: onNextButtonPressed,
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

Widget inputbox(String title, TextEditingController controller) {
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
        SizedBox(
          width: 130,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              hintText: '',
            ),
          ),
        )
      ],
    ),
  );
}
