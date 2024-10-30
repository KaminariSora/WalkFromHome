// ignore: file_names
import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

class TimeCounter extends StatefulWidget {
  const TimeCounter({super.key});

  @override
  State<TimeCounter> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  O3DController o3dController = O3DController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.blue.shade50,
        body: SafeArea(
          child: Stack(
            children: [
              const SizedBox(height: 80),
              Positioned(
                top: 130, // Adjust this value based on how high you want it from the top
                left: (MediaQuery.of(context).size.width - 322) / 2, // Center it horizontally
                child: const CustomProgressBar(
                  width: 322,
                  height: 31,
                  progress: 0.1,
                ),
              ),
              Center(
                child: Container(
                  width: 328,
                  height: 360,
                  color: const Color(0xFFD9D9D9),
                  child: Transform.translate(
                    offset: const Offset(-40, -90),
                    child: Transform.scale(
                      scale: 1.5,
                      child: O3D(
                        src: 'assets/grandpa.glb',
                        controller: o3dController,
                        ar: false,
                        autoPlay: true,
                        autoRotate: false,
                        cameraControls: false,
                        cameraTarget: CameraTarget(-.25, 1.5, 1.5),
                        cameraOrbit: CameraOrbit(0, 90, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Container()
            ],
          ),
        ));
  }
}

class CustomProgressBar extends StatelessWidget {
  final double progress; // Progress from 0.0 to 1.0
  final Color backgroundColor;
  final Color progressColor;
  final double height;
  final double width;

  const CustomProgressBar({
    Key? key,
    required this.progress,
    required this.height,
    required this.width,
    this.backgroundColor = Colors.white,
    this.progressColor = const Color(0xFF008000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0
        )
      ),
      child: Stack(children: [
        Container(
          width: width * progress,
          decoration: BoxDecoration(
            color: progressColor,
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ]),
    );
  }
}
