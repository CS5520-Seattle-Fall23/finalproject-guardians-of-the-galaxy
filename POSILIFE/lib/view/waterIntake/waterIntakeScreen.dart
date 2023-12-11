import 'package:complete/view/waterIntake/waterIntakeRecordScreen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../homeScreen.dart';
import 'waterIntakeCalendarScreen.dart';
import 'waterIntakeReminderScreen.dart';
import '../account/accountInfoScreen.dart';
import '../bottomNavigationBar.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import 'waterIntakeGoalScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/water.dart';
import '../../model/waterRecord.dart';
import '../../controller/date_controller.dart';


class WaterIntakeScreen extends StatefulWidget {
  @override
  _WaterIntakeScreenState createState() => _WaterIntakeScreenState();
}
class _WaterIntakeScreenState extends State<WaterIntakeScreen> {
  int _selectedIndex = 0;
  List<bool> _selections = [true, false];
  bool isOunces = false; // State variable to track unit toggle
  // Conversion constants
  final double _mlToOz = 0.033814;
  final double _ozToMl = 29.5735;
  double _currentWaterIntake = 0.0; // State variable to track current water intake
  WaterRecord? _waterData; // Holds the fetched water data

  // Update the current water intake value with unit conversion
  void _updateDisplayIntake() {
    setState(() {
      if (_waterData != null) {
        _currentWaterIntake = isOunces
            ? _waterData!.current * _mlToOz // Convert ml to oz
            : _waterData!.current.toDouble(); // Keep it as ml
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchWaterData();
  }

  Future<void> _fetchWaterData() async {
    // Assuming the user is already authenticated and you have their user ID
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Timestamp now = Timestamp.now();
    DateTime dateOnly = DateTime(now.toDate().year, now.toDate().month, now.toDate().day);
    String dateId = formatDateOnly(dateOnly);

    try {
      DocumentSnapshot waterDocSnapshot = 
        await FirebaseFirestore.instance.collection('Water').doc(userId).collection('waterRecord').doc(dateId).get();

      if (waterDocSnapshot.exists) {
        setState(() {
          _waterData = WaterRecord.fromDocument(waterDocSnapshot);
          _updateDisplayIntake();
        });
      }
    } catch (e) {
      print('Error fetching water data: $e');
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
        builder: (context) => WaterIntakeCalendarScreen(), // Navigate to the calendar screen
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
                    'Your water intake today:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                              isOunces
                                  ? '${_currentWaterIntake.toStringAsFixed(2)} oz' // Display in oz if isOunces is true
                                  : '${_currentWaterIntake.toStringAsFixed(0)} ml', // Display in ml if isOunces is false
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
                percent: _waterData != null ? _waterData!.current / _waterData!.goal : 0.0,
                center: Text(
                  _waterData != null ? '${(_waterData!.current / _waterData!.goal * 100).toStringAsFixed(0)}%' : "0%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.pink[300],
              ),
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WaterIntakeRecordScreen(), // Replace with your actual water intake record screen widget
                    ),
                  );
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text("Water", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to waterIntakeGoalScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WaterIntakeGoalScreen()),
                  );
                },
                icon: Icon(Icons.flag, color: Colors.white), // Use an appropriate icon
                label: Text('Goal', style: TextStyle(color: Colors.white)), // Replace with appropriate text
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
                label: Text("My Water Calendar", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[200], // Button color
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
                  // Navigate to waterIntakereminderScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WaterIntakeReminderScreen()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.alarm, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Remind me to drink water!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ),
            ),
            
            // The toggle for units (oz/ml) will go here
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
                    child: Text('ml'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('oz'),
                  ),
                ],
                onPressed: (int index) {
                        setState(() {
                          isOunces = index == 1; // if index is 1, then isOunces is true
                          _updateDisplayIntake(); // Update the display intake after toggling
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

