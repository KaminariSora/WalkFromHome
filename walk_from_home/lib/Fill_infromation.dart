// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'NavigationButton.dart';
import 'CalibratePopup.dart';

class FillinForm extends StatefulWidget {
  const FillinForm({super.key});

  @override
  State<FillinForm> createState() => _FillinFormState();
}

class _FillinFormState extends State<FillinForm> {
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
      isPressedButton2 = false;
    });
  }

  void _onButton2Pressed() {
    setState(() {
      currentGender = 'หญิง';
      isPressedButton1 = false;
      isPressedButton2 = true;
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
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 70.h),
                    const Text(
                      "กรุณากรอกข้อมูล",
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'prompt',
                      ),
                    ),
                    SizedBox(height: 50.h),
                    buildTextField('ชื่อ : '),
                    SizedBox(height: 25.h),
                    buildTextField('นามสุกล : '),
                    SizedBox(height: 44.h),
                    buildWeightHeightFields(),
                    SizedBox(height: 44.h),
                    buildGenderSelection(),
                    Navigationbutton(
                      onForwardPressed: () {
                        showCalibratePopup(context);
                      },
                      onBackPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField(String label) {
    return SizedBox(
      height: 80.h,
      width: 331.w,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 22,
            fontFamily: 'prompt',
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWeightHeightFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildMeasurementField("น้ำหนัก"),
        SizedBox(width: 25.w),
        buildMeasurementField("ส่วนสูง"),
      ],
    );
  }

  Widget buildMeasurementField(String label) {
    return Container(
      width: 140.w,
      height: 140.h,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 22,
              fontFamily: 'prompt',
            ),
          ),
          SizedBox(height: 10.h),
          const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGenderSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildGenderButton(
          'ชาย',
          'assets/icons/men.png',
          isPressedButton1,
          _onButton1Pressed,
          BorderRadius.only(
            topLeft: Radius.circular(20.r),
            bottomLeft: Radius.circular(20.r),
          ),
        ),
        // SizedBox(width: 16.w),
        buildGenderButton(
          'หญิง',
          'assets/icons/female.png',
          isPressedButton2,
          _onButton2Pressed,
          BorderRadius.only(
            topRight: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
      ],
    );
  }

  Widget buildGenderButton(
    String label,
    String iconPath,
    bool isPressed,
    VoidCallback onPressed,
    BorderRadius borderRadius,
  ) {
    return SizedBox(
      width: 160.w,
      height: 64.h,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isPressed ? Colors.grey : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 30.w, height: 30.h),
            SizedBox(width: 25.w),
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                fontFamily: 'prompt',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
