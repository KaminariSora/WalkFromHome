// ignore: file_names
import 'package:flutter/material.dart';
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

  void _onButton1Pressed() {
    setState(() {
      isPressedButton1 = true;
      isPressedButton2 = false;
    });
  }

  void _onButton2Pressed() {
    setState(() {
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

  @override
  Widget build(BuildContext context) {
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
