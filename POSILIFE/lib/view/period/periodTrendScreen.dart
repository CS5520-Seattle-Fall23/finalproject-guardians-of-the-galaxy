import 'package:flutter/material.dart';
import '../bottomNavigationBar.dart';
import '../account/accountInfoScreen.dart';
import 'periodMainScreen.dart';
import '../homeScreen.dart';
import '../report/reportHomeScreen.dart';

class PeriodTrendScreen extends StatefulWidget {
  @override
  _PeriodTrendScreenState createState() => _PeriodTrendScreenState();
}

class _PeriodTrendScreenState extends State<PeriodTrendScreen> {
  // These values would typically come from user data or analytics
  // For demonstration, I'm using hardcoded values
  final String averageCycleLength = "30 Days";
  final String averagePeriodLength = "7 Days";
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
        title: Text('Period Trending'),
        backgroundColor: Colors.pink[100],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Average Cycle length:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                averageCycleLength,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Average Period Length:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                averagePeriodLength,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink),
              ),
            ),
            // Add more widgets or functionality as needed
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
