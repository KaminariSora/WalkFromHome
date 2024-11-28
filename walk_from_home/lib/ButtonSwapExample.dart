// ignore_for_file: file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ButtonSwapExample extends StatefulWidget {
  const ButtonSwapExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ButtonSwapExampleState createState() => _ButtonSwapExampleState();
}

class _ButtonSwapExampleState extends State<ButtonSwapExample> {
  // รายการของภาพที่ใช้ในปุ่ม
  List<String> imagePaths = [
    'assets/feeling/1.png',
    'assets/feeling/2.png',
    'assets/feeling/3.png',
    'assets/feeling/4.png',
    'assets/feeling/5.png',
  ];

  // รายการของข้อความที่สัมพันธ์กับภาพ
  List<String> buttonTexts = [
    'ไม่เหนื่อยเลย', // สำหรับ Button 1
    'เหนื่อยเล็กน้อย', // สำหรับ Button 2
    'เหนื่อยปานกลาง', // สำหรับ Button 3
    'เหนื่อยมาก', // สำหรับ Button 4
    'เหนื่อยจนหมดแรง', // สำหรับ Button 5
  ];

  void swapMainButton(int index) {
    setState(() {
      // สลับภาพ
      final tempImage = imagePaths[0];
      imagePaths[0] = imagePaths[index];
      imagePaths[index] = tempImage;

      // สลับข้อความ
      final tempText = buttonTexts[0];
      buttonTexts[0] = buttonTexts[index];
      buttonTexts[index] = tempText;

      // จัดเรียงใหม่ตามลำดับตัวอักษร (เลือกกรณีนี้หากต้องการ)
      imagePaths = [
        imagePaths[0],
        ...imagePaths.sublist(1)..sort((a, b) => a.compareTo(b)),
      ];
      buttonTexts = [
        buttonTexts[0],
        ...buttonTexts.sublist(1)..sort((a, b) => a.compareTo(b)),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 340,
        height: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main button (center)
            Positioned(
              top: 20,
              child: SizedBox(
                width: 120,
                height: 160,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: null, // Disabled by default
                      icon: Image.asset(
                        imagePaths[0],
                        fit: BoxFit.cover,
                      ),
                      iconSize: 100,
                      padding: EdgeInsets.zero,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        buttonTexts[0],
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
              left: 5,
              top: 110,
              child: buildCircleButton(1),
            ),
            Positioned(
              bottom: 0,
              left: 70,
              child: buildCircleButton(2),
            ),
            Positioned(
              bottom: 0,
              right: 70,
              child: buildCircleButton(3),
            ),
            Positioned(
              right: 5,
              top: 110,
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
            height: 70,
            width: 70,
            child: IconButton(
              onPressed: () => swapMainButton(index),
              icon: Image.asset(
                imagePaths[index],
                fit: BoxFit.cover,
              ),
              iconSize: 60,
              padding: EdgeInsets.zero,
            ),
          ),
          Expanded(
            child: AutoSizeText(
              buttonTexts[index], // ข้อความตรงกับ index ของปุ่ม
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

