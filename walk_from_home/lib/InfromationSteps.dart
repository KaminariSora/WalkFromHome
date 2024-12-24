// ignore: file_names
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'NavigationButton.dart';
import 'TestBeforeStart.dart';

class Infromationsteps extends StatefulWidget {
  const Infromationsteps({super.key});

  @override
  State<Infromationsteps> createState() => _InfromationstepsState();
}

class _InfromationstepsState extends State<Infromationsteps> {
  bool isPressedButton1 = false;
  bool isPressedButton2 = false;
  bool isPressedButton3 = false;

  void _onButton1Pressed() {
    setState(() {
      isPressedButton1 = true;
      isPressedButton2 = false;
      isPressedButton3 = false;
    });
  }

  void _onButton2Pressed() {
    setState(() {
      isPressedButton1 = false;
      isPressedButton2 = true;
      isPressedButton3 = false;
    });
  }

  void _onButton3Pressed() {
    setState(() {
      isPressedButton1 = false;
      isPressedButton2 = false;
      isPressedButton3 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ระยะทางที่ได้",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'prompt',
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
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
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '',
                              ),
                            ),
                          ),
                          AutoSizeText(
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "จำนวนก้าวที่นับได้",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'prompt',
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              "ในการตั้งค่าระยะก้าว",
                              style: TextStyle(
                                fontSize: 26, // Maximum font size
                                fontFamily: 'prompt',
                              ),
                              maxLines: 1, // Maximum number of lines
                              minFontSize: 12, // Minimum font size
                              textAlign: TextAlign.center, // Center-align text
                            ),
                          ),
                          SizedBox(width: 17),
                          SizedBox(
                            width: 85,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '',
                              ),
                            ),
                          ),
                          SizedBox(width: 17),
                          Text(
                            "เมตร",
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
                    onPressed: _onButton1Pressed,
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
                    onPressed: _onButton2Pressed,
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
                    onPressed: _onButton3Pressed,
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
              onForwardPressed: () {
                Navigator.pushNamed(context, '/Testbeforestart');
              },
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
