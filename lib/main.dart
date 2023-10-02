import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

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

  final List<Duration> offsets = [
    Duration(hours: -6, minutes: 30), // UTC
    Duration(hours: -13, minutes: 30), // San Francisco
    Duration(hours: -10, minutes: 30), // New York
    Duration(hours: -5, minutes: 30), // London
    Duration(hours: -2, minutes: 30), // Dubai
    Duration(hours: 0), // Bangalore
    Duration(hours: 2, minutes: 30), // Singapore
    Duration(hours: 3, minutes: 30), // Tokyo
    Duration(hours: 5, minutes: 30), // Sydney
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
    DateTime now = DateTime.now();

    for (int i = 0; i < cities.length; i++) {
      DateTime localTime = now.add(offsets[i]);
      times[cities[i]] = DateFormat('HH:mm:ss').format(localTime);
    }

    setState(() {}); // Trigger a rebuild
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(cities[index]),
          subtitle: Text(times[cities[index]] ?? ''),
        );
      },
    );
  }
}
