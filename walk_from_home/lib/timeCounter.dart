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
        backgroundColor: Colors.blue.shade50,
        body: SafeArea(
          child: Stack(
            children: [
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
        )
      );
  }
}