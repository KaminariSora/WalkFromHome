// ignore: file_names
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walk_from_home/NavigationButton.dart';
import 'package:walk_from_home/providers/FAQBeforeTest_provider.dart';
import 'models/FAQBeforeTest.dart';

class Testbeforestart extends StatefulWidget {
  const Testbeforestart({super.key});

  @override
  State<Testbeforestart> createState() => _TestbeforestartState();
}

class _TestbeforestartState extends State<Testbeforestart> {
  int selectedSpeedButton = 0;
  int selectedStepButton = 0;
  late FAQBeforeTest faq;

  @override
  Widget build(BuildContext context) {
    final faqProvider = Provider.of<FAQBeforeTestProvider>(context);

    void onButtonPressedSpeed(int buttonIndex) {
      setState(() {
        selectedSpeedButton = buttonIndex;
        if (buttonIndex == 1) {
          faqProvider.updateWalkingType('slow_walk');
        } else if (buttonIndex == 2) {
          faqProvider.updateWalkingType('normal_walk');
        } else if (buttonIndex == 3) {
          faqProvider.updateWalkingType('fast_walk');
        }
      });
    }

    void onButtonPressedStep(int buttonIndex) {
      setState(() {
        selectedStepButton = buttonIndex;
        if (buttonIndex == 1) {
          faqProvider.updateWalkingStride('short_stride');
        } else if (buttonIndex == 2) {
          faqProvider.updateWalkingStride('normal_stride');
        } else if (buttonIndex == 3) {
          faqProvider.updateWalkingStride('long_stride');
        }
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
      if (selectedSpeedButton == 0) {
        showAlert(context, "กรุณาระบุการเดิน");
      } else if (selectedStepButton == 0) {
        showAlert(context, "กรุณาระบุระยะก้าว");
      } else {
        Navigator.pushNamed(context, '/TimeCounter');
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: AutoSizeText(
                  "แบบสอบถามก่อนเริ่มทำการทดสอบ",
                  style: TextStyle(
                    fontSize: 26, // Maximum font size
                    fontFamily: 'prompt',
                  ),
                  maxLines: 1, // Maximum number of lines
                  minFontSize: 12, // Minimum font size
                  textAlign: TextAlign.center, // Center-align text
                ),
              ),
            ],
          ),
          const SizedBox(height: 41),
          Container(
            margin: const EdgeInsets.only(left: 40),
            alignment: Alignment.centerLeft,
            child: const Text(
              "คุณเป็นคนเดินช้าหรือเร็ว",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'prompt',
              ),
            ),
          ),
          const SizedBox(height: 24),

          //ปุ่มคำถามการเดิน
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 104,
                height: 150,
                child: TextButton(
                  onPressed: () => onButtonPressedSpeed(1),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        selectedSpeedButton == 1 ? Colors.grey : Colors.white,
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
                  onPressed: () => onButtonPressedSpeed(2),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        selectedSpeedButton == 2 ? Colors.grey : Colors.white,
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
                  onPressed: () => onButtonPressedSpeed(3),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        selectedSpeedButton == 3 ? Colors.grey : Colors.white,
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
          const SizedBox(height: 41),
          Container(
            margin: const EdgeInsets.only(left: 40),
            alignment: Alignment.centerLeft,
            child: const Text(
              "คุณเป็นคนเดินก้าวยาวหรือสั้น",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'prompt',
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 104,
                height: 64,
                child: TextButton(
                  onPressed: () => onButtonPressedStep(1),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        selectedStepButton == 1 ? Colors.grey : Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'สั้น',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'prompt',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 17),
              SizedBox(
                width: 104,
                height: 64,
                child: TextButton(
                  onPressed: () => onButtonPressedStep(2),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        selectedStepButton == 2 ? Colors.grey : Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'ปกติ',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'prompt',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 17),
              SizedBox(
                width: 104,
                height: 64,
                child: TextButton(
                  onPressed: () => onButtonPressedStep(3),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        selectedStepButton == 3 ? Colors.grey : Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'ยาว',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'prompt',
                        color: Colors.black,
                      ),
                    ),
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
    );
  }
}
