
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For using Cupertino icons

import 'waterIntake/waterIntakeScreen.dart';
import 'sleep/sleepTimeScreen.dart';
import 'wellness/wellnessTodayScreen.dart';
import 'diet/dietIntakeScreen.dart';
import 'account/accountInfoScreen.dart';
import 'period/periodMainScreen.dart';
import 'report/reportHomeScreen.dart';
import 'bottomNavigationBar.dart' as BottomNavigationBar;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  String userName = ""; // Fetch from Firebase
  int _selectedIndex = 0;
   // a variable to track the selected button index
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

  // fetch user data from Firebase
  // get userName from User collection with doc(userId)

  void fetch_UserName() async{
    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();

        if (userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

          setState(() {
            userName = userData['UserName'] ?? '';
            });
        }
      } catch (e) {
        print('Error fetching user data: $e');
        // Handle errors or show a message to the user
      }
    }
  @override
  void initState() {
    super.initState();
    fetch_UserName();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POSI LIFE', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 238, 139, 200),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
              'Hello, ${userName.isNotEmpty ? userName : "Sweet Angel"}! 🌻',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  _buildFeatureButton(context, 'Water', Icons.local_drink, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WaterIntakeScreen()));
                  }),
                  _buildFeatureButton(context, 'Sleep', Icons.nights_stay, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SleepTimeScreen()));
                  }),
                  _buildFeatureButton(context, 'Diet', Icons.restaurant_menu, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DietIntakeScreen()));
                  }),
                  _buildFeatureButton(context, 'Wellness', Icons.spa, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WellnessTodayScreen()));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar.CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }

  Widget _buildFeatureButton(BuildContext context, String label, IconData icon, Function onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: ElevatedButton.icon(
      icon: Icon(icon, color: Color.fromARGB(255, 247, 243, 243)),
      label: Text(label, style: TextStyle(color: Color.fromARGB(255, 247, 243, 243))),
      onPressed: () => onTap(),
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


