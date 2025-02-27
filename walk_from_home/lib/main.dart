import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walk_from_home/Evaluation.dart';
import 'package:walk_from_home/Fill_infromation.dart';
import 'package:walk_from_home/Home.dart';
import 'package:walk_from_home/InfromationSteps.dart';
import 'package:walk_from_home/TestBeforeStart.dart';
import 'package:walk_from_home/notpass_page.dart';
import 'package:walk_from_home/pass_page.dart';
import 'package:walk_from_home/pretest.dart';
import 'package:walk_from_home/timeCounter.dart';
import 'providers/user_data_provider.dart';
import 'providers/FAQBeforeTest_provider.dart';
import 'providers/calibrate_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Description_Pass.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => FAQBeforeTestProvider()),
        ChangeNotifierProvider(create: (_) => CalibrateProvider()),
      ],
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
        '/': (context) => const Home(),
        '/Description': (context) => const DescriptionPass(),
        '/Pretest': (context) => const Pretest(),
        '/Fillinfrom': (context) => const FillinForm(),
        '/infromationStep': (context) => const Infromationsteps(),
        '/Testbeforestart': (context) => const Testbeforestart(),
        '/Passpage': (context) => const PassPage(),
        '/NotPasspage': (context) => const notPassPage(),
        '/TimeCounter': (context) => const TimeCounter(),
        '/EvaluationPage': (context) => const EvaluationPage(),
      },
    );
  }
}
