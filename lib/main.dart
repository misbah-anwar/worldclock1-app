import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('World Clock 1'),
        ),
        body: WorldClock(),
      ),
    );
  }
}

class WorldClock extends StatefulWidget {
  @override
  _WorldClockState createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClock> {
  final List<String> cities = [
    'UTC',
    'San Francisco',
    'New York',
    'London',
    'Dubai',
    'Bangalore',
    'Singapore',
    'Tokyo',
    'Sydney'
  ];
  String date1 = "11-Oct-2023";

  final List<Duration> offsets = [
    Duration(hours: 0), // UTC
    Duration(hours: -7), // San Francisco
    Duration(hours: -4), // New York
    Duration(hours: 1), // London
    Duration(hours: 4), // Dubai
    Duration(hours: 5, minutes: 30), // Bangalore
    Duration(hours: 8), // Singapore
    Duration(hours: 9), // Tokyo
    Duration(hours: 10), // Sydney
  ];

  Map<String, String> times = {};

  @override
  void initState() {
    super.initState();

    // Initial call to update times
    updateTimes();

    // Setup a timer to update times every 1 second
    Timer.periodic(Duration(seconds: 1), (timer) {
      updateTimes();
    });
  }

  void updateTimes() {
    DateTime utcTime = DateTime.now().toUtc();

    for (int i = 0; i < cities.length; i++) {
      DateTime localTime = utcTime.add(offsets[i]);
      times[cities[i]] = DateFormat('HH:mm').format(localTime);
    }

    setState(() {}); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(cities[index] + ": " + times[cities[index]]!),
          subtitle: Text(date1),
        );
      },
    );
  }
}
