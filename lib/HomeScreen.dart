import 'package:flutter/material.dart';

import 'HistoryScreen.dart';
import 'TimerScreen.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();


}

class _HomeScreenState extends State<HomeScreen> {
  List<TimeEntry> _timeEntries = [];

  void _addTimeEntry(TimeEntry entry) {
    setState(() {
      _timeEntries.add(entry);
    });
  }
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stopwatch App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: 250,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final TimeEntry? entry = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimerScreen(userName: _nameController.text,)),
                );
                if (entry != null) {
                  _addTimeEntry(entry);
                }
              },
              child: Text('Continue'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(timeEntries: _timeEntries),
                  ),
                );
              },
              child: Text('View History'),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeEntry {
  final String userName;
  final String time;

  TimeEntry({required this.userName, required this.time});
}
