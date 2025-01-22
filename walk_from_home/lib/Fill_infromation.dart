// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'NavigationButton.dart';
import 'CalibratePopup.dart';
import 'models/Calibrate_data.dart';

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

  // late CalibrateData calibrateData;

  void _onButton1Pressed() {
    setState(() {
      currentGender = 'male';
      isPressedButton1 = true;
      isPressedButton2 = false;
    });
  }

  void _onButton2Pressed() {
    setState(() {
      currentGender = 'female';
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
    // Get the height of the screen
    double screenHeight = (MediaQuery.of(context).size.height) - 50;
    final userDataProvider = Provider.of<UserDataProvider>(context);

    void dispose() {
      // ล้าง memory ของ controller
      firstNameController.dispose();
      lastNameController.dispose();
      weightController.dispose();
      heightController.dispose();
      super.dispose();
    }

    void showAlert(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("แจ้งเตือน"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("ตกลง"),
              ),
            ],
          );
        },
      );
    }

    void onNextButtonPressed() {
      String firstName = firstNameController.text.trim();
      String lastName = lastNameController.text.trim();
      String weight = weightController.text.trim();
      String height = heightController.text.trim();

      if (firstName.isEmpty ||
          lastName.isEmpty ||
          weight.isEmpty ||
          height.isEmpty) {
        showAlert(context, "กรุณากรอกข้อมูลให้ครบถ้วน");
      } else if (currentGender == 'ไม่ระบุ') {
        showAlert(context, "กรุณาระบุเพศ");
      } else {
        userDataProvider.updateFirstName(firstNameController.text);
        userDataProvider.updateLastName(lastNameController.text);
        userDataProvider
            .updateWeight(double.tryParse(weightController.text) ?? 0.0);
        userDataProvider
            .updateHeight(double.tryParse(heightController.text) ?? 0.0);
        userDataProvider.updateGender(currentGender);
        showCalibratePopup(context);
      }
    }

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: screenHeight, // Set the height to screen height
              alignment: Alignment
                  .topCenter, // กำหนดให้ element อยู่ตรงกลางด้านบนของ Container
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // SizedBox(height: 70.h),
                  const Text(
                    "กรุณากรอกข้อมูล",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'prompt',
                    ),
                  ),
                  // SizedBox(height: 50.h),
                  buildTextField('ชื่อ : ', firstNameController),
                  // SizedBox(height: 25.h),
                  buildTextField('นามสุกล : ', lastNameController),
                  // SizedBox(height: 44.h),
                  buildWeightHeightFields(),
                  // SizedBox(height: 44.h),
                  buildGenderSelection(),
                  Navigationbutton(
                    onForwardPressed: onNextButtonPressed,
                    onBackPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return SizedBox(
      // height: 80.h,
      width: 331.w,
      child: TextField(
        controller: controller,
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
        buildMeasurementField("น้ำหนัก", weightController),
        SizedBox(width: 25.w),
        buildMeasurementField("ส่วนสูง", heightController),
      ],
    );
  }

  Widget buildMeasurementField(String label, TextEditingController controller) {
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
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
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
