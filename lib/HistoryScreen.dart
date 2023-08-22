import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class HistoryScreen extends StatelessWidget {
  final List<TimeEntry> timeEntries;

  HistoryScreen({required this.timeEntries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: ListView.builder(
        itemCount: timeEntries.length,
        itemBuilder: (context, index) {
          final entry = timeEntries[index];
          return ListTile(
            title: Text('User: ${entry.userName}'),
            subtitle: Text('Time: ${entry.time}'),
          );
        },
      ),
    );
  }
}
