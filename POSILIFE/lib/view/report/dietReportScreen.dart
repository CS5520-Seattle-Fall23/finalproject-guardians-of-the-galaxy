import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import '../account/accountInfoScreen.dart';

class DietReportScreen extends StatefulWidget {
  @override
  _DietReportScreenState createState() => _DietReportScreenState();
}

class _DietReportScreenState extends State<DietReportScreen> {
  final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final calorieData = [2000, 1800, 2200, 2100, 1900, 1950, 2000]; // Example data for calorie intake
  int _selectedIndex = 2; // Assumed you have a bottom navigation with index

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
        title: Text('Diet', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink[200],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image
          Image.asset(
            'assets/dietReport.png',
            fit: BoxFit.contain,
          ),
          // Back button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReportHomeScreen()));// Navigate back to the previous screen
              },
            ),
          ),
          // Your original bottom navigation bar
          Expanded(
            child: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
