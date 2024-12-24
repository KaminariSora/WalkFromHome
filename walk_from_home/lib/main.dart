import 'package:flutter/material.dart';
import 'package:flutter_application_1/Description_Pass.dart';
import 'package:flutter_application_1/Evaluation.dart';
import 'package:flutter_application_1/Fill_infromation.dart';
import 'package:flutter_application_1/InfromationSteps.dart';
import 'package:flutter_application_1/TestBeforeStart.dart';
import 'package:flutter_application_1/pass_page.dart';
import 'package:flutter_application_1/pretest.dart';
import 'package:flutter_application_1/timeCounter.dart';
import 'package:provider/provider.dart';
import 'providers/user_data_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ทำให้ Flutter เตรียมพร้อมสำหรับ async code
  await Firebase
      .initializeApp(); // เรียกใช้ Firebase.initializeApp() ก่อน runApp()
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserDataProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const DescriptionPass(),
        '/Pretest': (context) => const Pretest(),
        '/Fillinfrom': (context) => const fillinfrom(),
        '/infromatoinStep': (context) => const Infromationsteps(),
        '/Testbeforestart': (context) => const Testbeforestart(),
        '/Passpage': (context) => const PassPage(),
        '/TimeCounter': (context) => const TimeCounter(),
        '/EvaluationPage': (context) => const EvaluationPage(),
      },
    );
  }
}
