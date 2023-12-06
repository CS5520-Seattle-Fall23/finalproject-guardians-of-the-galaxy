import 'package:flutter/material.dart';

import 'waterReportScreen.dart';
import 'sleepReportScreen.dart';
import 'dietReportScreen.dart';
import 'wellnessReportScreen.dart';
import '../account/accountInfoScreen.dart';
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';

class ReportHomeScreen extends StatefulWidget {
  @override
  _ReportHomeScreenState createState() => _ReportHomeScreenState();
}

class _ReportHomeScreenState extends State<ReportHomeScreen> {
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
        title: Text('Report'),
        backgroundColor: Colors.pink[200], // Set this to match your theme
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                _buildFeatureButton(context, 'Water', Icons.local_drink, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WaterReportScreen()));
                }),
                _buildFeatureButton(context, 'Sleep', Icons.nights_stay, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SleepReportScreen()));
                }),
                _buildFeatureButton(context, 'Diet', Icons.restaurant_menu, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DietReportScreen()));
                }),
                _buildFeatureButton(context, 'Wellness', Icons.spa, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WellnessReportScreen()));
                }),
              ],
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

  Widget _buildFeatureButton(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Color.fromARGB(255, 247, 243, 243)),
        label: Text(label, style: TextStyle(color: Color.fromARGB(255, 247, 243, 243))),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 254, 99, 151),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          textStyle: TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
