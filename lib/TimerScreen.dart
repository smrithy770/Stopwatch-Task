import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class TimerScreen extends StatefulWidget {
  final String userName;

  TimerScreen({required this.userName});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  bool _isRunning = false;
  late Stopwatch _stopwatch;
  late String _formattedTime = '00:00:00';

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _toggleTimer() {
    if (_isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }


  List<Map<String, dynamic>> _savedTimes = [];

/*  void _saveTime() {
    setState(() {
      _formattedTime = _formatTime(_stopwatch.elapsed);
      _stopwatch.reset();
      _isRunning = false;
    });
    _savedTimes.add({
      'userName': widget.userName,
      'time': _formattedTime,
    });
  }*/


  Stream<String> _stopwatchStream() {
    return Stream.periodic(Duration(milliseconds: 1000), (x) {
      return _formatTime(_stopwatch.elapsed);
    });
  }
  void _saveTime() {
    final entry = TimeEntry(userName: widget.userName, time: _formatTime(_stopwatch.elapsed));
    Navigator.pop(context, entry);
  }


  String _formatTime(Duration duration) {
    return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stopwatch Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<String>(
              stream: _stopwatchStream(),
              initialData: _formattedTime,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data!,
                  style: TextStyle(fontSize: 48),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleTimer,
              child: Text(_isRunning ? 'Stop' : 'Start'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTime,
              child: Text('Save Time'),
            ),
            SizedBox(height: 20),
            Text('User: ${widget.userName}'),
            Text('Saved Times:'),
            Expanded(
              child: ListView.builder(
                itemCount: _savedTimes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_savedTimes[index]['userName']),
                    subtitle: Text(_savedTimes[index]['time']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
