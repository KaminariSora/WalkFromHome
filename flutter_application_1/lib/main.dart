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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  O3DController o3dController = O3DController();
  PageController mainPageController = PageController();
  PageController textsPageController = PageController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: SafeArea(
            child: Stack(children: [
          const Text('3D'),
          // O3D(
          //   src: 'assets/disney_style_character.glb',
          //   controller: o3dController,
          //   ar: false,
          //   autoPlay: true,
          //   autoRotate: false,
          //   cameraControls: false,
          //   cameraTarget: CameraTarget(-.25, 1.5, 1.5),
          //   cameraOrbit: CameraOrbit(0, 90, 1),
          // ),
          const O3D.network(
              src:
                  'https://modelviewer.dev/shared-assets/models/Astronaut.glb'),
          PageView(controller: mainPageController)
        ])));
  }
}
