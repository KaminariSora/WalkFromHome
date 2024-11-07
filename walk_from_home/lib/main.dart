import 'package:flutter/material.dart';
import 'CalibratePopup.dart';

void main() {
  runApp(const MyApp()); // Ensure this wraps with MaterialApp in MyApp
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp at the root of the widget tree
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Floating Popup Example")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showCalibratePopup(context);
            },
            child: const Text('Show Popup'),
          ),
        ),
      ),
    );
  }
}
