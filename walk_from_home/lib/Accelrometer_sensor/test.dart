import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:path_provider/path_provider.dart'; // For file system access
import 'dart:async';
import 'dart:io'; // For file operations
import 'dart:convert'; // For JSON encoding

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  double x = 0.0, y = 0.0, z = 0.0;
  double maxX = 0.0, maxY = 0.0, maxZ = 0.0;
  StreamSubscription<AccelerometerEvent>? _subscription;
  final List<Map<String, double>> accelerometerData = []; // List to store readings

  @override
  void initState() {
    super.initState();

    // Subscribe to accelerometer events
    _subscription = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;

        // Update max values
        if (x.abs() > maxX) maxX = x.abs();
        if (y.abs() > maxY) maxY = y.abs();
        if (z.abs() > maxZ) maxZ = z.abs();

        // Store the current reading
        accelerometerData.add({'x': x, 'y': y, 'z': z});
      });
    });
  }

  void resetMaxValues() {
    setState(() {
      maxX = 0.0;
      maxY = 0.0;
      maxZ = 0.0;
    });
  }

  Future<void> exportToJSON() async {
    try {
      // Get the directory for storing the file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/accelerometer_data.json');

      // Write the data as JSON
      await file.writeAsString(jsonEncode(accelerometerData));

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved to ${file.path}')),
      );
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  Future<void> exportToCSV() async {
    try {
      // Get the directory for storing the file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/accelerometer_data.csv');

      // Convert the data to CSV format
      final csvData = StringBuffer();
      csvData.writeln('x,y,z'); // Header
      for (var reading in accelerometerData) {
        csvData.writeln('${reading['x']},${reading['y']},${reading['z']}');
      }

      // Write the CSV data to the file
      await file.writeAsString(csvData.toString());

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved to ${file.path}')),
      );
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  @override
  void dispose() {
    // Cancel the subscription to avoid memory leaks
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current X: ${x.toStringAsFixed(2)}'),
            Text('Current Y: ${y.toStringAsFixed(2)}'),
            Text('Current Z: ${z.toStringAsFixed(2)}'),
            Text(
              'Max X: ${maxX.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              'Max Y: ${maxY.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              'Max Z: ${maxZ.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetMaxValues,
              child: const Text('Reset Max Values'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: exportToJSON,
              child: const Text('Export to JSON'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: exportToCSV,
              child: const Text('Export to CSV'),
            ),
          ],
    );
  }
}
