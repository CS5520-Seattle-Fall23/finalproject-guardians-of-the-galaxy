import 'package:complete/view/diet/dietIntakeRecordScreen.dart';
import 'package:complete/view/diet/dietIntakeReminderScreen.dart';
import 'package:complete/view/diet/dietIntakeCalendarScreen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../homeScreen.dart';
import"../account/accountInfoScreen.dart";
import '../bottomNavigationBar.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import 'dietIntakeGoalScreen.dart';


class DietIntakeScreen extends StatefulWidget {
  @override
  _DietIntakeScreenState createState() => _DietIntakeScreenState();
}

class _DietIntakeScreenState extends State<DietIntakeScreen> {
  int _selectedIndex = 0;
  List<bool> _selections = [true, false];
  bool isKcal = false; // State variable to track unit toggle
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
        builder: (context) => DietIntakeCalendarScreen(), // Navigate to the calendar screen
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
            // The title section with "Today" and calorie intake statistics will be here
                        Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Your calorie intake today:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // TODO: Add logic to display the calorie intake value(backend integration)
                      Text(
                        '1400 kcal',
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
                  //TODO: Add logic to display the calorie intake percentage(backend integration)
                  "70%",
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
                      builder: (context) => DietIntakeRecordScreen(), // Replace with your actual water intake record screen widget
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
                  // Navigate to DietIntakeGoalScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DietIntakeGoalScreen()),
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
            // calorie Intake Calendar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton.icon(
                onPressed: _navigateToCalendar,
                icon: Icon(Icons.calendar_today, color: Colors.white),
                label: Text("My calorie Calendar", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Button color
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
                  // Navigate to DietIntakereminderScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DietIntakeReminderScreen()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.alarm, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Remind me to control my diet!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ),
            ),
            
            // The toggle for units (KJ/Kcal) will go here
            Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Center( // This will center the ToggleButtons horizontally
              child: ToggleButtons(
                borderColor: Colors.grey,
                fillColor: Colors.pink.shade200,
                borderWidth: 2,
                selectedBorderColor: Colors.pink,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(0),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Kcal'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('KJ'),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _selections.length; i++) {
                      _selections[i] = i == index;
                    }
                    // TODO: Add logic to handle unit change
                  });
                },
                isSelected: _selections,
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

