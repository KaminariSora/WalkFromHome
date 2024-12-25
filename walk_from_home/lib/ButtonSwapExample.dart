// ignore_for_file: file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ButtonInfo {
  final String text;
  final String path;
  int index;

  ButtonInfo({required this.text, required this.path, required this.index});
}

class ButtonSwapExample extends StatefulWidget {
  final Function(String)? onMainButtonChanged; // Callback สำหรับส่งค่ากลับ

  const ButtonSwapExample({super.key, this.onMainButtonChanged});

  @override
  // ignore: library_private_types_in_public_api
  _ButtonSwapExampleState createState() => _ButtonSwapExampleState();
}

class _ButtonSwapExampleState extends State<ButtonSwapExample> {
  // รายการของ ButtonInfo
  List<ButtonInfo> buttonInfo = [
    ButtonInfo(text: 'ไม่เหนื่อยเลย', path: 'assets/feeling/1.png', index: 0),
    ButtonInfo(text: 'เหนื่อยเล็กน้อย', path: 'assets/feeling/2.png', index: 1),
    ButtonInfo(text: 'เหนื่อยปานกลาง', path: 'assets/feeling/3.png', index: 2),
    ButtonInfo(text: 'เหนื่อยมาก', path: 'assets/feeling/4.png', index: 3),
    ButtonInfo(text: 'เหนื่อยจนหมดแรง', path: 'assets/feeling/5.png', index: 4),
  ];

  void swapMainButton(int index) {
    setState(() {
      // สลับข้อมูลใน buttonInfo
      final tempInfo = buttonInfo[0];
      buttonInfo[0] = buttonInfo[index];
      buttonInfo[index] = tempInfo;

      // แยกส่วน buttonInfo ตั้งแต่ตำแหน่งที่ 1 (ไม่รวม index 0)
      List<ButtonInfo> sortedList = buttonInfo.sublist(1);

      // จัดเรียง sortedList ตามค่า index
      sortedList.sort((a, b) => a.index.compareTo(b.index));

      // รวม buttonInfo[0] กับ sortedList ที่จัดเรียงแล้ว
      buttonInfo = [buttonInfo[0], ...sortedList];

      // เรียก Callback เมื่อ main button เปลี่ยน
      if (widget.onMainButtonChanged != null) {
        widget.onMainButtonChanged!(buttonInfo[0].text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 340,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main button (center)
          Positioned(
            top: 0,
            child: SizedBox(
              width: 120,
              height: 120,
              child: Column(
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: IconButton(
                      onPressed: null, // Disabled by default
                      icon: Image.asset(
                        buttonInfo[0].path,
                        fit: BoxFit.cover,
                      ),
                      iconSize: 100,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      buttonInfo[0].text,
                      style: const TextStyle(
                        fontSize: 26, // Maximum font size
                        fontFamily: 'prompt',
                      ),
                      maxLines: 1, // Maximum number of lines
                      minFontSize: 10, // Minimum font size
                      textAlign: TextAlign.center, // Center-align text
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Surrounding buttons
          Positioned(
            left: 0,
            top: 70,
            child: buildCircleButton(1),
          ),
          Positioned(
            bottom: 0,
            left: 60,
            child: buildCircleButton(2),
          ),
          Positioned(
            bottom: 0,
            right: 60,
            child: buildCircleButton(3),
          ),
          Positioned(
            right: 0,
            top: 70,
            child: buildCircleButton(4),
          ),
        ],
      ),
    );
  }

  Widget buildCircleButton(int index) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: IconButton(
              onPressed: () => swapMainButton(index),
              icon: Image.asset(
                buttonInfo[index].path,
                fit: BoxFit.cover,
              ),
              iconSize: 100,
              padding: EdgeInsets.zero,
            ),
          ),
          Expanded(
            child: AutoSizeText(
              buttonInfo[index].text, // ข้อความตรงกับ index ของปุ่ม
              style: const TextStyle(
                fontSize: 15, // Maximum font size
                fontFamily: 'prompt',
              ),
              maxLines: 1, // Maximum number of lines
              minFontSize: 10, // Minimum font size
              textAlign: TextAlign.center, // Center-align text
            ),
          ),
        ],
      ),
    );
  }
}
