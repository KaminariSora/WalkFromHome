// ignore: file_names
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walk_from_home/providers/FAQBeforeTest_provider.dart';
import 'package:walk_from_home/providers/calibrate_provider.dart';
import 'NavigationButton.dart';
import './models/Calibrate_data.dart';
import './models/FAQBeforeTest.dart';

class Infromationsteps extends StatefulWidget {
  const Infromationsteps({super.key});

  @override
  State<Infromationsteps> createState() => _InfromationstepsState();
}

class _InfromationstepsState extends State<Infromationsteps> {
  final distanceController = TextEditingController();
  final stepsCountController = TextEditingController();

  String walkingStyle = '';

  bool isPressedButton1 = false;
  bool isPressedButton2 = false;
  bool isPressedButton3 = false;

  late FAQBeforeTest faq;
  late CalibrateData calibrateData;

  @override
  Widget build(BuildContext context) {
    final faqProvider = Provider.of<FAQBeforeTestProvider>(context);
    final calibrateProvider = Provider.of<CalibrateProvider>(context);
    void onButton1Pressed() {
      setState(() {
        walkingStyle = 'ช้า';
        isPressedButton1 = true;
        isPressedButton2 = false;
        isPressedButton3 = false;
        faqProvider.updateWalkingType('slow_walk');
      });
    }

    void onButton2Pressed() {
      setState(() {
        walkingStyle = 'ปกติ';
        isPressedButton1 = false;
        isPressedButton2 = true;
        isPressedButton3 = false;
        faqProvider.updateWalkingType('normal_walk');
      });
    }

    void onButton3Pressed() {
      setState(() {
        walkingStyle = 'เร็ว';
        isPressedButton1 = false;
        isPressedButton2 = false;
        isPressedButton3 = true;
        faqProvider.updateWalkingType('fast_walk');
      });
    }

    void showAlert(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("แจ้งเตือน"),
            content: Text(message),
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
      String distance = distanceController.text.trim();
      String steps = stepsCountController.text.trim();

      if (distance.isEmpty || steps.isEmpty) {
        showAlert(context, "กรุณากรอกข้อมูลให้ครบถ้วน");
      } else if (walkingStyle.trim().isEmpty) {
        showAlert(context, "กรุณาระบุการเดิน");
      } else {
        double distance = double.parse(distanceController.text);
        calibrateProvider.updateCalibrateDistance(distance);
        int stepCount = int.parse(stepsCountController.text);
        calibrateProvider.updateStepCount(stepCount);
        calibrateProvider.updateCalibrateCheck(true);
        Navigator.pushNamed(context, '/Testbeforestart');
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: const AutoSizeText(
            'แบบสอบถามเพื่อปรับเทียบระยะก้าว',
            style: TextStyle(
              fontSize: 26,
              fontFamily: 'prompt',
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            minFontSize: 12,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 37,
            ),
            //ระยะทางที่ได้
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 349,
                  height: 127,
                  padding: const EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "ระยะทางที่ได้",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'prompt',
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: AutoSizeText(
                              "ในการตั้งค่าระยะก้าว",
                              style: TextStyle(
                                fontSize: 22, // Maximum font size
                                fontFamily: 'prompt',
                              ),
                              maxLines: 1, // Maximum number of lines
                              minFontSize: 13, // Minimum font size
                              textAlign: TextAlign.center, // Center-align text
                            ),
                          ),
                          // SizedBox(width: 17),
                          SizedBox(
                            width: 85,
                            child: TextField(
                              controller: distanceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '',
                              ),
                            ),
                          ),
                          const AutoSizeText(
                            "เมตร",
                            style: TextStyle(
                              fontSize: 20, // Maximum font size
                              fontFamily: 'prompt',
                            ),
                            maxLines: 1, // Maximum number of lines
                            minFontSize: 12, // Minimum font size
                            textAlign: TextAlign.center, // Center-align text
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 37),
            //จำนวนก้าวที่นับได้
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 349,
                  height: 127,
                  padding: const EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "จำนวนก้าวที่นับได้",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'prompt',
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: AutoSizeText(
                              "ในการตั้งค่าระยะก้าว",
                              style: TextStyle(
                                fontSize: 22, // Maximum font size
                                fontFamily: 'prompt',
                              ),
                              maxLines: 1, // Maximum number of lines
                              minFontSize: 12, // Minimum font size
                              textAlign: TextAlign.center, // Center-align text
                            ),
                          ),
                          const SizedBox(width: 17),
                          SizedBox(
                            width: 85,
                            child: TextField(
                              controller: stepsCountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '',
                              ),
                            ),
                          ),
                          const SizedBox(width: 17),
                          const Text(
                            "ก้าว",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'prompt',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 37),
            Container(
              margin: const EdgeInsets.only(left: 40),
              alignment: Alignment.centerLeft,
              child: const Text(
                "คุณเป็นคนเดินช้าหรือเร็ว",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'prompt',
                ),
              ),
            ),
            const SizedBox(height: 37),
            //ปุ่มคำถามการเดิน
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 104,
                  height: 150,
                  child: TextButton(
                    onPressed: onButton1Pressed,
                    style: TextButton.styleFrom(
                      backgroundColor:
                          isPressedButton1 ? Colors.grey : Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/walkslow.png',
                          width: 94,
                          height: 94,
                        ),
                        const Text(
                          'ช้า',
                          style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'prompt',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 17),
                //ปุ่มเดินปกติ
                SizedBox(
                  width: 104,
                  height: 150,
                  child: TextButton(
                    onPressed: onButton2Pressed,
                    style: TextButton.styleFrom(
                      backgroundColor:
                          isPressedButton2 ? Colors.grey : Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/walknormal.png',
                          width: 94,
                          height: 94,
                        ),
                        const Text(
                          'ปกติ',
                          style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'prompt',
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 17),
                //ปุ่มเดินเร็ว
                SizedBox(
                  width: 104,
                  height: 150,
                  child: TextButton(
                    onPressed: onButton3Pressed,
                    style: TextButton.styleFrom(
                      backgroundColor:
                          isPressedButton3 ? Colors.grey : Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/walkfast.png',
                          width: 94,
                          height: 94,
                        ),
                        const Text(
                          'เร็ว',
                          style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'prompt',
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Navigationbutton(
              onForwardPressed: onNextButtonPressed,
              onBackPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
