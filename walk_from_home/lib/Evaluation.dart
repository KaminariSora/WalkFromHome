// ignore: file_names
// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:walk_from_home/providers/user_data_provider.dart';

class EvaluationPage extends StatefulWidget {
  const EvaluationPage({super.key});

  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);
    final userData = userDataProvider.userData;

    double distance = userData.distance;
    String gender = userData.gender;
    int age = 22; // default age
    double weight = userData.weight;
    double height = userData.height;
    double criterion = 0.0;
    late String result;

    String resultingGenderEquation() {
      if (gender == 'male') {
        criterion = (7.57 * height) - (1.76 * age) - (1.76 * weight) - 309;
      } else if (gender == 'female') {
        criterion = (2.11 * height) - (5.78 * age) - (2.29 * weight) + 667;
      } else {
        return result = 'Gender not found';
      }
      return result = (distance >= criterion) ? "Healthy" : "Unhealthy";
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 40)),
            Center(
              child: Column(
                children: [
                  const AutoSizeText(
                    'สรุปผลการทดสอบ',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'prompt',
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minFontSize: 12,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: constraints.maxHeight * 0.5,
                              child: Image.asset(
                                'assets/miniHeart.png',
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.1,
                            ),
                            const AutoSizeText(
                              'ระยะทางที่คุณทำได้อยู่ที่',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'prompt',
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              minFontSize: 12,
                            ),
                            AutoSizeText(
                              '${distance.toStringAsFixed(2)} เมตร',
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'prompt',
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              minFontSize: 12,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  AutoSizeText(
                    resultingGenderEquation(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'prompt',
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minFontSize: 12,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        bool isConnected =
                            await InternetConnection().hasInternetAccess;

                        if (!isConnected) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'กรุณาเชื่อมต่ออินเทอร์เน็ตก่อนบันทึกข้อมูล')),
                          );
                          return; // ออกจากฟังก์ชัน ไม่เรียก saveToFirebase()
                        }
                        try {
                          await userDataProvider
                              .saveToFirebase(); // Save to Firebase
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Data saved successfully!')),
                          );
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Failed to save data: $error')),
                          );
                        }
                        Navigator.pushNamed(context, '/');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      child: const Text(
                        'เสร็จสิ้น',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'prompt',
                            color: Colors.black),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
