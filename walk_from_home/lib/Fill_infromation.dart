// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'NavigationButton.dart';
import 'CalibratePopup.dart';

// void main() {
//   runApp(MaterialApp(
//       title: "Walkfromhome", home: Scaffold(body: const fillinfrom())));
// }

class fillinfrom extends StatefulWidget {
  const fillinfrom({super.key});

  @override
  State<fillinfrom> createState() => _fillinfromState();
}

class _fillinfromState extends State<fillinfrom> {
  bool isPressedButton1 = false;
  bool isPressedButton2 = false;

  String currentGender = 'ไม่ระบุ';

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  void _onButton1Pressed() {
    setState(() {
      currentGender = 'ชาย';
      isPressedButton1 = true;
      isPressedButton2 = false; // ปิดการเลือกปุ่มอื่น
    });
  }

  void _onButton2Pressed() {
    setState(() {
      currentGender = 'หญิง';
      isPressedButton1 = false;
      isPressedButton2 = true; // ปิดการเลือกปุ่มอื่น
    });
  }

  void showCalibratePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Calibratepopup(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    void dispose() {
      // ล้าง memory ของ controller
      firstNameController.dispose();
      lastNameController.dispose();
      weightController.dispose();
      heightController.dispose();
      super.dispose();
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment
                .topCenter, // กำหนดให้ element อยู่ตรงกลางด้านบนของ Container
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .center, // จัดให้องค์ประกอบใน Column อยู่กลางแนวนอน
              children: [
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  "กรุณากรอกข้อมูล",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'prompt',
                  ),
                ),
                const SizedBox(height: 50),
                //ช่องกรอกชื่อ
                SizedBox(
                  height: 80,
                  width: 331,
                  child: TextField(
                    controller: firstNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'ชื่อ : ',
                      labelStyle: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontFamily: 'prompt',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                //ช่องกรอกนามสุกล
                SizedBox(
                  height: 80,
                  width: 331,
                  child: TextFormField(
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'นามสุกล : ',
                      labelStyle: const TextStyle(
                        fontSize: 22,
                        fontFamily: 'prompt',
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 44),
                //ช่องกรอกน้ำหนักและส่วนสูง
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              )),
                          child: Column(
                            children: [
                              const Text("น้ำหนัก",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'prompt',
                                  )),
                              const SizedBox(height: 10.0),
                              TextField(
                                controller: weightController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 31),
                        Container(
                          width: 150,
                          height: 150,
                          padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              )),
                          child: Column(
                            children: [
                              const Text("ส่วนสูง",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'prompt',
                                  )),
                              const SizedBox(height: 10.0),
                              TextField(
                                controller: heightController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: '',
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 44),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 165.5,
                      height: 64,
                      child: TextButton(
                        onPressed: _onButton1Pressed,
                        style: TextButton.styleFrom(
                          backgroundColor:
                              isPressedButton1 ? Colors.grey : Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(0),
                            ),
                            side: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/men.png',
                              width: 34,
                              height: 34,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            const Text(
                              'ชาย',
                              style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'prompt',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 165.5,
                      height: 64,
                      child: TextButton(
                        onPressed: _onButton2Pressed,
                        style: TextButton.styleFrom(
                          backgroundColor:
                              isPressedButton2 ? Colors.grey : Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(20),
                            ),
                            side: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/female.png',
                              width: 34,
                              height: 34,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            const Text(
                              'หญิง',
                              style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'prompt',
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Text('เพศ: $currentGender'),
                Navigationbutton(
                  onForwardPressed: () {
                    userDataProvider.updateFirstName(firstNameController.text);
                    userDataProvider.updateLastName(lastNameController.text);
                    userDataProvider.updateWeight(
                        double.tryParse(weightController.text) ?? 0.0);
                    userDataProvider.updateHeight(
                        double.tryParse(heightController.text) ?? 0.0);
                    userDataProvider.updateGender(currentGender);
                    showCalibratePopup(context);
                  },
                  onBackPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
