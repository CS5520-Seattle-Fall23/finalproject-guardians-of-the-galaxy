import 'package:complete/view/sleep/sleepTimeRecordScreen.dart';
import 'package:complete/view/sleep/sleepTimeReminderScreen.dart';
import 'package:complete/view/sleep/sleepTimeCalendarScreen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../homeScreen.dart';
import"../account/accountInfoScreen.dart";
import '../bottomNavigationBar.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import 'sleepTimeGoalScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/sleep.dart';
import '../../model/sleepRecord.dart';
import '../../controller/date_controller.dart';

class SleepTimeScreen extends StatefulWidget {
  @override
  _SleepTimeScreenState createState() => _SleepTimeScreenState();
}
class _SleepTimeScreenState extends State<SleepTimeScreen> {
  int _selectedIndex = 0;

  int _currentSleepTime = 0; // State variable to track current sleep time
  SleepRecord ? _sleepData; // Holds the fetched sleep data


    // Update the current water intake value with unit conversion
  void _updateDisplaySleepTime() {
    setState(() {
      if (_sleepData != null) {
        _currentSleepTime = _sleepData!.current;
      }
    });
  }

  @override
  void initState(){
    super.initState();
    _fetchSleepData();
  }

  Future<void> _fetchSleepData() async {
    // Assuming the user is already authenticated and you have their user ID
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Timestamp now = Timestamp.now();
    DateTime dateOnly = DateTime(now.toDate().year, now.toDate().month, now.toDate().day);
    String dateId = formatDateOnly(dateOnly);

    try {
      DocumentSnapshot sleepDocSnapshot =
        await FirebaseFirestore.instance.collection('Sleep').doc(userId).collection('sleepRecord').doc(dateId).get();
    
      if (sleepDocSnapshot.exists) {
        setState(() {
          _sleepData = SleepRecord.fromDocument(sleepDocSnapshot);
          _updateDisplaySleepTime();
        });
      } 
    } catch(e) {
      print('Error fetching sleep data: $e');
      // Handle errors or show a message to the user
    }
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
  void _navigateToCalendar() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SleepTimeCalendarScreen(), // Navigate to the calendar screen
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0, // Remove the drop shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
          // Push the home screen onto the stack without the ability to navigate back to the current screen
            MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your home screen widget
            );
        },
      ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // The title section with "Today" and water intake statistics will be here
                        Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Your Sleep Time today:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _sleepData != null ? '${_currentSleepTime.toStringAsFixed(0)} h' : '0 h',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // The pie chart will go here
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: _sleepData != null ? _sleepData!.current / _sleepData!.goal : 0.0, 
                center: Text(
                  _sleepData != null ? '${(_sleepData!.current / _sleepData!.goal * 100).toStringAsFixed(0)}%' : "0%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.pink,
              ),
            ),

            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SleepTimeRecordScreen(), // Replace with your actual water intake record screen widget
                    ),
                  );
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text("Sleep Time", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to SleepTimeGoalScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SleepTimeGoalScreen()),
                  );
                },
                icon: Icon(Icons.flag, color: Colors.white), // Use an appropriate icon
                label: Text('Sleep Time Goal', style: TextStyle(color: Colors.white)), // Replace with appropriate text
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ],
          ),
            // Water Intake Calendar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton.icon(
                onPressed: _navigateToCalendar,
                icon: Icon(Icons.calendar_today, color: Colors.white),
                label: Text("My Sleep Time Calendar", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[100], // Button color
                  foregroundColor: Colors.white, // Text color
                ),
              ),
            ),
            // The reminder section will go here
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Center(
                child: InkWell(
                onTap: () {
                  // Navigate to SleepTimereminderScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SleepTimeReminderScreen()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.alarm, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Remind me to go Sleep!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ),
            ),
          ],
        ),
      ),
      // The bottom navigation bar will be added here
     bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}
