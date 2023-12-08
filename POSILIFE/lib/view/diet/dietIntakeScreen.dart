import 'package:complete/controller/date_controller.dart';
import 'package:complete/model/dietRecord.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/diet.dart';



class DietIntakeScreen extends StatefulWidget {
  @override
  _DietIntakeScreenState createState() => _DietIntakeScreenState();
}

class _DietIntakeScreenState extends State<DietIntakeScreen> {
  int _selectedIndex = 0;
  List<bool> _selections = [true, false];
  bool isKJ = false; // State variable to track unit toggle

  final double _kcalToKj = 4.184;
  final double _kjTokcal = 0.239;
  double _currentCalorieIntake = 0.0;
  DietRecord ? _dietData; // Holds the fetched diet data

  void _updateDisplayIntake(){
    setState(() {
      if (_dietData != null) {
        _currentCalorieIntake = isKJ
          ? _dietData!.current * _kjTokcal // conver kj to kcal
          : _dietData!.current.toDouble(); // keep it as kcal
      }
    });
  }

  @override
  void initState(){
    super.initState();
    _fetchDietData();
  }

  Future<void> _fetchDietData() async {
    // Assuming the user is already authenticated and you have their user ID
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Timestamp now = Timestamp.now();
    DateTime dateOnly = DateTime(now.toDate().year, now.toDate().month, now.toDate().day);
    String dateId = formatDateOnly(dateOnly);

    try {
      DocumentSnapshot dietDocSnapshot =
        await FirebaseFirestore.instance.collection('Diet').doc(userId).collection('dietRecord').doc(dateId).get();
    
      if (dietDocSnapshot.exists) {
        setState(() {
          _dietData = DietRecord.fromDocument(dietDocSnapshot);
          _updateDisplayIntake();
        });
      } 
    } catch(e) {
      print('Error fetching diet data: $e');
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
                      Text(
                        isKJ
                          ? '${_currentCalorieIntake.toStringAsFixed(2)} kJ'
                          : '${_currentCalorieIntake.toStringAsFixed(0)} kcal',
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
                percent: _dietData != null ? _dietData!.current / _dietData!.goal : 0.0, 
                center: Text(
                  _dietData != null ? '${(_dietData!.current / _dietData!.goal * 100).toStringAsFixed(0)}%' : "0%",
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
                label: Text("Calorie", style: TextStyle(color: Colors.white)),
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
                label: Text('Calorie Goal', style: TextStyle(color: Colors.white)), // Replace with appropriate text
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
                    child: Text('kcal'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('kJ'),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    isKJ = index == 1;
                    _updateDisplayIntake();
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

