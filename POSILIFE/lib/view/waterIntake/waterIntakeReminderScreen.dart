import 'package:flutter/material.dart';
import '../account/accountInfoScreen.dart';
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'waterIntakeScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';


// Import any additional packages you might need for HTTP requests, such as 'package:http/http.dart' as http.
class WaterIntakeReminderScreen extends StatefulWidget {
  @override
  _WaterIntakeReminderScreenState createState() => _WaterIntakeReminderScreenState();
}

class _WaterIntakeReminderScreenState extends State<WaterIntakeReminderScreen> {
  int _selectedIndex = 0;
  TimeOfDay selectedTime = TimeOfDay.now();
  Timer? _timer;


  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

void _setReminder() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  DateTime reminderDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    selectedTime.hour,
    selectedTime.minute,
  );

  if (reminderDateTime.isBefore(DateTime.now())) {
    reminderDateTime = reminderDateTime.add(Duration(days: 1));
  }

  await FirebaseFirestore.instance.collection('Water').doc(userId).update({
    'reminderTime': Timestamp.fromDate(reminderDateTime),
  });

  _startReminderTimer(reminderDateTime);

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WaterIntakeScreen()));
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('You have successfully set your reminder.'),
  ));
}

void _startReminderTimer(DateTime reminderTime) {
  _timer?.cancel(); // Cancel any existing timer

  _timer = Timer.periodic(Duration(minutes: 1), (Timer t) {
    var now = DateTime.now();
    if (now.hour == reminderTime.hour && now.minute == reminderTime.minute) {
      // Show in-app notification
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Time to drink some water!'),
      ));

      t.cancel(); // Cancel the timer after showing notification
    }
  });
}

@override
void dispose() {
  _timer?.cancel();
  super.dispose();
}

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => PeriodCalendarPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReportHomeScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AccountInfoPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Customize Reminder:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () => _selectTime(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Remind me to drink water at:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${selectedTime.format(context)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
           Center(
              child: ElevatedButton(
              onPressed: _setReminder, // Call the _setReminder method here
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 230, 183, 199), // Button background color
                foregroundColor: Colors.white, // Button text color
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}
