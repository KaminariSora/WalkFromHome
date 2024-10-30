import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'UI 3D flutter',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       home: const TimeCounter(title: 'Flutter Demo Page'),
//     );
//   }
// }

// class TimeCounter extends StatefulWidget {
//   const TimeCounter({super.key, required this.title});

//   final String title;

//   @override
//   State<StatefulWidget> createState() => _TimeCounterState();
// }

// class _TimeCounterState extends State<TimeCounter> {

//   O3DController o3dController = O3DController();
//   PageController mainController = PageController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           O3D(src: 'assets/grandpa.glb',
//             controller: o3dController,
//             ar: false,
//             autoPlay: true,
//             autoRotate: false,
//           ),

//           PageView(
//             controller: mainController,
//             children: [

//             ],
//           ),
//         ],
//       ),
//     );
//   }

// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI 3D flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TimeCounter(),
    );
  }
}

class TimeCounter extends StatefulWidget {
  const TimeCounter({super.key});

  @override
  State<TimeCounter> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  O3DController o3dController = O3DController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 350,
              width: 328,
              color: Colors.green,
              child: Align(
                alignment: Alignment.center, // Adjust the alignment
                child: SizedBox(
                  child: O3D(
                    src: 'assets/grandpa.glb',
                    controller: o3dController,
                    ar: false,
                    autoPlay: true,
                    autoRotate: false,
                    cameraControls: false,
                    cameraTarget: CameraTarget(0, 0, 0),
                    cameraOrbit: CameraOrbit(0, 90, 1.8),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.1, // Adjust vertical position
            left: 50.0, // Adjust horizontal position
            child: Container(
              width: 100.0, // Adjust box width
              height: 50.0, // Adjust box height
              color: Colors.blue.withOpacity(0.7), // Box color with opacity
              child: const Center(
                child: Text(
                  'Overlay Box',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
