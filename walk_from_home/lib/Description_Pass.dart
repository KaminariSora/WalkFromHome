// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NavigationButton.dart';
import 'pretest.dart';

class DescriptionPass extends StatefulWidget {
  const DescriptionPass({super.key});

  @override
  State<DescriptionPass> createState() => DescriptionPassState();
}

class DescriptionPassState extends State<DescriptionPass> {
  bool isChecked = false; // ตัวแปรเก็บสถานะของ Checkbox

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("แจ้งเตือน"),
          content: Text("กรุณาอ่านคำอธิบายทั้งหมด"),
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
    if (!isChecked) {
      // ถ้า Checkbox ไม่ถูกเลือก ให้แสดง Popup
      showAlert(context);
    } else {
      // ถ้า Checkbox ถูกเลือก ให้ไปหน้าถัดไป
      Navigator.pushNamed(context, '/Pretest');
    }
  }

  String description = '''ขั้นตอนการใช้งานแอปพลิเคชัน
  1.  กรอกข้อมูลก่อนการทดสอบ
  1.1. อัตราการเต้นของหัวใจและปริมาณออกซิเจนในเลือด วัดโดยใช้ Oximeter
  1.2. ค่าความดันโลหิต วัดโดยใช้เครื่องวัดความดันโลหิต
  1.3. ระดับความเหนื่อยสามารถกดดูระดับความเหนื่อยได้เพื่อประกอบการตัดสินใจ
  1.4. กรอกค่าน้ำหนัก ส่วนสูง และเพศ
  1.4.1. หากไม่สะดวกที่จะทำการ Calibrate ให้กดปุ่มถัดไป จะเข้าสู่หน้าเลือกเงื่อนไขการเดิน
  1.4.2. หากสะดวกที่จะทำการ Calibrate ให้กดปุ่ม Calibrate โดยที่การ Calibrate ทำโดยให้กำหนดระยะทางที่ชัดเจน(แนะนำ 6 เมตรขึ้นไป) จากนั้นนำระยะทางที่ได้กับจำนวนก้าวมากรอกในแอปพลิเคชันเพื่อคำนวณระยะก้าว
  2.  การทำการทดสอบ
  2.1. เมื่อเข้าสู่หน้าทำการทดสอบ จะเห็นเวลา 6.10 นาที
  2.2. เมื่อพร้อมทำการทดสอบแล้ว ให้กดปุ่มเริ่ม  แอปพลิเคชันจะทำการนับเวลาถอยหลัง 10 วินาที ก่อนเริ่มจับเวลา 6 นาที
  2.3. ให้ผู้ทำการทดสอบนำโทรศัพติดไว้ที่บริเวณหลังก่อนเริ่มเดิน เมื่อครบ 10 วินาที แอปพลิเคชันจะแจ้งเตือนเสียงให้ทราบ และเริ่มการทดสอบได้ 
  2.4. ทุกๆ1นาทีแอปพลิเคชันจะแจ้งเตือนเพื่อให้ผู้ทำการทดสอบทราบเวลาว่าเดินไปแล้วกี่นาที เมื่อเดินครบเวลาแล้ว ให้กดปุ่มสิ้นสุดการทดสอบ
  2.5. ในกรณีที่ไม่สามารถเดินครบเวลา 6 นาทีได้ ให้กดหยุดเวลาและกดสิ้นสุดการทดสอบ
  2.6. หน้าสรุปผลการทดสอบ ตรวจสอบชื่อ-นามสกุล ข้อมูลจากการทดสอบว่าถูกต้องหรือไม่ และการปุ่มบันทึกข้อมูล เป็นอันสิ้นสุดการทดสอบ
  คำแนะนำในการทำการทดสอบ
    ในระหว่างการทดสอบผู้ทดสอบสามารถพักได้โดยไม่ต้องหยุดเวลา เมื่อพักเรียบร้อยแล้วก็สามารถทำการทดสอบได้จนครบกำหนดเวลา     
  ข้อควรระวังในการทำการทดสอบ
  1.ผู้ที่ควรห้ามหรือควรเฝ้าระวัง ได้แก่ ผู้รับการทดสอบเคยมีอาการเจ็บหน้าอกเฉียบพลันหรือแบบไม่คงที่ (unstable angi\u0002na) หรือภาวะกล้ามเนื้อหัวใจตายบางส่วน (myocardial infarction) ในช่วงระยะเวลา 1 เดือนที่ผ่านมา 
  2.ขณะพักมีอัตราการเต้นของหัวใจมากกว่า 120ครั้ง/นาที
  3.มีความดันโลหิตช่วงหัวใจบีบตัว (systolic blood pressure)มากกว่า180มิลลิเมตรปรอทและความดันโลหิตช่วงหัวใจคลายตัว(diastolicblood pressure) มากกว่า 100 มิลลิเมตรปรอท
  4.ออกซิเจนในเลือด(SpO2)ไม่ควรต่ำกว่า 95 เปอร์เซ็นต์
  หมายเหตุ : ควรหยุดการทดสอบเมื่อมีอาการดังนี้
  เจ็บหน้าอก , เหนื่อยหอบ , ขาเป็นตะคริว , มึนงง , เดินโซเซ , เหงื่อแตกและหน้าซีด '''; // ข้อความที่จะแสดงในคำอธิบาย

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คำอธิบาย'),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              width: 352,
              height: MediaQuery.of(context).size.height * 0.74,
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      const Text('ฉันได้อ่านคำอธิบายทั้งหมดแล้ว'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Navigationbutton(
            onForwardPressed: onNextButtonPressed,
            onBackPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
