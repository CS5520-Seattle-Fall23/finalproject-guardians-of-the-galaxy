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



class SleepTimeScreen extends StatefulWidget {
  @override
  _SleepTimeScreenState createState() => _SleepTimeScreenState();
}
class _SleepTimeScreenState extends State<SleepTimeScreen> {
  int _selectedIndex = 0;
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
          // Check if the current screen can be popped
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Pop the current screen off the stack
          } else {
            Navigator.of(context).pushReplacement(
          // Push the home screen onto the stack without the ability to navigate back to the current screen
            MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your home screen widget
            );
          }
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
                      // TODO: Add logic to display the water intake value(backend integration)
                      Text(
                        '7.5 h',
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
                percent: 0.7, // Assuming 70% of the goal is completed
                center: Text(
                  //TODO: Add logic to display the water intake percentage(backend integration)
                  "75%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: Text(
                  "of your goal!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
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
