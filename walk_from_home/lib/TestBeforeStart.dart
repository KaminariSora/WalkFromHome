// ignore: file_names
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/NavigationButton.dart';
import 'pass_page.dart';

class Testbeforestart extends StatefulWidget {
  const Testbeforestart({super.key});

  @override
  State<Testbeforestart> createState() => _TestbeforestartState();
}

class _TestbeforestartState extends State<Testbeforestart> {
  int selectedSpeedButton = 0;
  int selectedStepButton = 0;

  void _onButtonPressedSpeed(int buttonIndex) {
    setState(() {
      selectedSpeedButton = buttonIndex;
    });
  }

  void _onButtonPressedStep(int Index) {
    setState(() {
      selectedStepButton = Index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                width: 104,
                height: 150,
                child: TextButton(
                  onPressed: () => _onButtonPressedSpeed(1),
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
              Container(
                width: 104,
                height: 150,
                child: TextButton(
                  onPressed: () => _onButtonPressedSpeed(2),
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
              Container(
                width: 104,
                height: 150,
                child: TextButton(
                  onPressed: () => _onButtonPressedSpeed(3),
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
            margin: EdgeInsets.only(left: 40),
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
              Container(
                width: 104,
                height: 64,
                child: TextButton(
                  onPressed: () => _onButtonPressedStep(1),
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
              SizedBox(width: 17),
              Container(
                width: 104,
                height: 64,
                child: TextButton(
                  onPressed: () => _onButtonPressedStep(2),
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
              SizedBox(width: 17),
              Container(
                width: 104,
                height: 64,
                child: TextButton(
                  onPressed: () => _onButtonPressedStep(3),
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
            onForwardPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PassPage()));
            },
            onBackPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
