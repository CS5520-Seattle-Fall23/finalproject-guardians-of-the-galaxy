import 'package:complete/view/period/periodMainScreen.dart';
import 'package:flutter/material.dart';
import '../bottomNavigationBar.dart';
import '../account/accountInfoScreen.dart';
import '../homeScreen.dart';
import '../report/reportHomeScreen.dart';

class PeriodReminderScreen extends StatefulWidget {
  @override
  _PeriodReminderScreenState createState() => _PeriodReminderScreenState();
}

class _PeriodReminderScreenState extends State<PeriodReminderScreen> {
  int _daysBeforePeriod = 3; // Default value for the reminder
  int _selectedIndex = 1;
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
        backgroundColor: Colors.pink, // Set this to match your theme
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Customize Reminder:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text(
                  'Remind me ',
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton<int>(
                  value: _daysBeforePeriod,
                  icon: Icon(Icons.arrow_downward, color: Colors.pink),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.pink, fontSize: 18),
                  underline: Container(
                    height: 2,
                    color: Colors.pinkAccent,
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      _daysBeforePeriod = newValue!;
                    });
                  },
                  items: <int>[1, 2, 3, 4, 5, 6, 7]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                Text(
                  ' days before my next menstrual cycle begins.',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement save reminder logic
                  
                  // After saving the reminder, navigate back to the previous screen
                  Navigator.pop(context);
                },
                child: Text('Confirm'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Button color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}
