import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart'; // For file storage
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:csv/csv.dart'; // For CSV file handling

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  double x = 0.0, y = 0.0, z = 0.0;
  Timer? dataTimer; // List to hold CSV data
  int timeElapsed = 0;
  List<List<dynamic>> csvData = [];
  final Dio dio = Dio();

  bool loading = false;

  Future<bool> saveFile(List<List<dynamic>> csvData, String fileName) async {
  Directory? directory;
  try {
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage)) {
        directory = await getExternalStorageDirectory();

        // Modify the path as needed for your app
        String newPath = "";
        List<String> folders = directory!.path.split('/');
        for (int x = 1; x < folders.length; x++) {
          String folder = folders[x];
          if (folder != "Android" && folder != "data" && folder != "com.example.walk_from_home" && folder != "files") {
            newPath += "/$folder";
          }
        }
        newPath = '$newPath/WalkFromHome';
        directory = Directory(newPath);
      } else {
        return false;
      }
    } else {
      directory = await getTemporaryDirectory();
    }

    // Ensure the directory exists
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    if (await directory.exists()) {
      // Convert the CSV data to a CSV string
      String csvString = const ListToCsvConverter().convert(csvData);

      // Create the file in the directory and write the CSV string to it
      File saveFile = File(directory.path + '/$fileName.csv');
      await saveFile.writeAsString(csvString); // Write the CSV data to the file

      return true;
    }
  } catch (e) {
    print(e); // Handle any errors
  }
  return false; // Return false if there was an error
}



  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  downloadFile() async {
    setState(() {
      loading = false;
    });

    bool downloaded = await saveFile(csvData, "accelerometer_data");
    if (downloaded) {
      print("File downloaded");
    } else {
      print("Problem downloading file.");
    }

    setState(() {
      loading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    csvData.add(["Time (s)", "X", "Y", "Z"]);

    // Listen to accelerometer events
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
      csvData.add([timeElapsed, x, y, z]);
    });

    // Timer to collect data every second
    dataTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeElapsed++;
      });
    });
  }

  @override
  void dispose() {
    dataTimer?.cancel(); // Cancel timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Current Values: X=${x.toStringAsFixed(2)}, ',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Current Values: , Y=${y.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Current Values: Z=${z.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: downloadFile, child: const Text('Save File'))
      ],
    );
  }
}
