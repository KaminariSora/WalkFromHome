// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerGraph extends StatefulWidget {
  const AccelerometerGraph({super.key});

  @override
  _AccelerometerGraphState createState() => _AccelerometerGraphState();
}

class _AccelerometerGraphState extends State<AccelerometerGraph> {
  List<FlSpot> xData = [];
  List<FlSpot> yData = [];
  List<FlSpot> zData = [];
  List<FlSpot> normData = [];
  double time = 0;

  @override
  void initState() {
    super.initState();
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        // Limit the number of data points to avoid performance issues
        if (xData.length > 100) {
          xData.removeAt(0);
          yData.removeAt(0);
          zData.removeAt(0);
          normData.removeAt(0);
        }

        double norm = sqrt(event.x * event.x + event.y * event.y + event.z * event.z) * 5;

        xData.add(FlSpot(time, event.x));
        yData.add(FlSpot(time, event.y));
        zData.add(FlSpot(time, event.z));
        normData.add(FlSpot(time, norm));
        time += 0.1; // Increment time for X-axis
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: true),
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
            borderData: FlBorderData(show: true),
            minX: time - 10, // Show the last 10 seconds of data
            maxX: time,
            minY: -20,
            maxY: 20,
            lineBarsData: [
              LineChartBarData(
                spots: xData,
                isCurved: true,
                color: Colors.red,
                barWidth: 2,
                dotData: const FlDotData(show: false),
              ),
              LineChartBarData(
                spots: yData,
                isCurved: true,
                color: Colors.green,
                barWidth: 2,
                dotData: const FlDotData(show: false),
              ),
              LineChartBarData(
                spots: zData,
                isCurved: true,
                color: Colors.blue,
                barWidth: 2,
                dotData: const FlDotData(show: false),
              ),
              LineChartBarData(
                spots: normData,
                isCurved: true,
                color: Colors.black,
                barWidth: 2,
                dotData: const FlDotData(show: false),
              ),
            ],
            )    ),
    );
  }
}
