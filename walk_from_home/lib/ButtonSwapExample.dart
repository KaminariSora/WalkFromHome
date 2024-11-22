// ignore_for_file: file_names

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
    'assets/feeling/1.png', // ใช้ภาพสำหรับ Button 1
    'assets/feeling/2.png', // ใช้ภาพสำหรับ Button 2
    'assets/feeling/3.png', // ใช้ภาพสำหรับ Button 3
    'assets/feeling/4.png', // ใช้ภาพสำหรับ Button 4
    'assets/feeling/5.png', // ใช้ภาพสำหรับ Button 5
  ];

  void swapMainButton(int index) {
    setState(() {
      // สลับตำแหน่งระหว่าง main button กับปุ่มที่กด
      final temp = imagePaths[0];
      imagePaths[0] = imagePaths[index];
      imagePaths[index] = temp;

      // จัดเรียงปุ่มที่เหลือ
      imagePaths = [
        imagePaths[0],
        ...imagePaths.sublist(1)..sort((a, b) => a.compareTo(b)),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dynamic Button Swap")),
      body: Center(
        child: SizedBox(
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
                      const Text(
                        'ไม่เหนื่อยเลย',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight
                                .bold), // Customize text style as needed
                      ),
                    ],
                  ),
                ),
              ),
              // Surrounding buttons
              Positioned(
                left: 5,
                top: 110,
                child: buildCircleButton(1, "เหนื่อยเล็กน้อย"),
              ),
              Positioned(
                bottom: 0,
                left: 70,
                child: buildCircleButton(2, "เหนื่อยปานกลาง"),
              ),
              Positioned(
                bottom: 0,
                right: 70,
                child: buildCircleButton(3, "เหนื่อยมาก"),
              ),
              Positioned(
                right: 5,
                top: 110,
                child: buildCircleButton(4, "เหนื่อยจนหมดแรง"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircleButton(int index, String levettired) {
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
          Text(
            levettired,
            style:
                const TextStyle(fontSize: 12), // Customize text style as needed
          ),
        ],
      ),
    );
  }
}
