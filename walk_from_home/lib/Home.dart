import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight; // ความสูงของหน้าจอ
          double screenWidth = constraints.maxWidth; // ความกว้างของหน้าจอ

          return SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight *
                        0.2, // ระยะห่างด้านบน 10% ของความสูงหน้าจอ
                  ),
                  child: Image.asset(
                    'assets/icons/icon.png', // ใส่ path ไฟล์รูปภาพ
                    width: screenWidth *
                        0.85, // ขนาดกว้างรูปภาพ 60% ของความกว้างหน้าจอ
                    height:
                        screenWidth * 0.8, // ขนาดสูงรูปภาพสัมพันธ์กับความกว้าง
                  ),
                ),
                const Spacer(), // เว้นระยะตรงกลาง
                Padding(
                  padding: EdgeInsets.only(
                    bottom: screenHeight *
                        0.2, // ระยะห่างปุ่มจากด้านล่าง 10% ของความสูงหน้าจอ
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Description');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFD9D9D9),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth *
                            0.1, // Padding แนวนอน 10% ของความกว้างหน้าจอ
                        vertical: screenHeight *
                            0.02, // Padding แนวตั้ง 2% ของความสูงหน้าจอ
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      'เริ่มต้นใช้งาน',
                      style: TextStyle(
                        fontSize: screenWidth *
                            0.05, // ขนาดตัวอักษร 5% ของความกว้างหน้าจอ
                        fontFamily: 'prompt',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
