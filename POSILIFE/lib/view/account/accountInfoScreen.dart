import 'package:flutter/material.dart';
import '../login/auth_gate.dart';
import 'changePasswordScreen.dart';
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';

class AccountInfoPage extends StatefulWidget {
  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  // Placeholder for user data
  String userName = ""; // Fetch from Firebase
  String userEmail = ""; // Fetch from Firebase
  String userBirth = ""; // Fetch from Firebase
  String userHeight = "None"; // Fetch from Firebase or default to 'None'
  String userWeight = "None"; // Fetch from Firebase or default to 'None'
  String cycleLength = "None"; // Fetch from Firebase or default to 'None'
  String periodLength = "None"; // Fetch from Firebase or default to 'None'
  String medicalConditions = "None"; // Fetch from Firebase or default to 'None'

  int _selectedIndex = 3;
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
  // Fetch user data from Firebase
  void _fetchUserData() {
    // TODO: Implement Firebase fetch logic
    // After fetching, call setState() to update the UI
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'POSI LIFE',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _userInfoTile('User Name', userName),
            _userInfoTile('User ID', userEmail),
            _userInfoTile('Birth', userBirth),
            _userInfoTile('Height', userHeight),
            _userInfoTile('Weight', userWeight),
            _userInfoTile('Cycle Length', cycleLength),
            _userInfoTile('Period Length', periodLength),
            _userInfoTile('Medical Conditions', medicalConditions),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthGate()));
              },
              child: Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[100],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
              },
              child: Text('Change Password'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.pink[100],
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation bar can be added here if needed
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
    ),
    );
  }

  Widget _userInfoTile(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              data.isNotEmpty ? data : 'None',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

