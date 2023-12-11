import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'weightRecordReminderScreen.dart';
import 'weightRecordScreen.dart';
import 'weightComparisonScreen.dart';
import '../homeScreen.dart';
import "../account/accountInfoScreen.dart";
import '../bottomNavigationBar.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';


class WellnessTodayScreen extends StatefulWidget {
  @override
  _WellnessTodayScreen createState() => _WellnessTodayScreen();
}

class _WellnessTodayScreen extends State<WellnessTodayScreen> {
  int _selectedIndex = 0;
  double weight = 0; // Fetched from Firebase
  double height = 0; // Fetched from Firebase
  int age = 0; // Fetched from Firebase

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

 void _fetchUserData() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  // Always fetch Age from Users collection
  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      setState(() {
        age = _parseInt(userData['Age']);
      });
    }
  } catch (e) {
    print('Error fetching age from Users: $e');
  }

  // Attempt to fetch Weight and Height from the Wellness collection
  try {
    DocumentSnapshot wellnessDoc = await FirebaseFirestore.instance.collection('Wellness').doc(userId).get();
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    if (wellnessDoc.exists) {
      Map<String, dynamic> wellnessData = wellnessDoc.data() as Map<String, dynamic>;
      setState(() {
        weight = _parseToDouble(wellnessData['Weight']);
        height = _parseToDouble(wellnessData['Height']);
      });
    } else {
      // If no Wellness data, fetch Weight and Height from Users
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          weight = _parseToDouble(userData['Weight']);
          height = _parseToDouble(userData['Height']);
        });
      }
    }
  } catch (e) {
    print('Error fetching data from Wellness: $e');
  }
}

double _parseToDouble(dynamic value) {
  return (value is String) ? double.tryParse(value) ?? 0.0 : (value?.toDouble() ?? 0.0);
}

int _parseInt(dynamic value) {
  return (value is String) ? int.tryParse(value) ?? 0 : (value ?? 0);
}

  double calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }

  double calculateBMR(int age, double weight, double height) {
    return (9.99 * weight) + (6.25 * height) - (4.92 * age) - 161;
  }

  String getBmiLabel(double bmi) {
    if (bmi < 18.5) {
      return 'Below Normal Weight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Healthy Weight';
    } else {
      return 'Above Healthy Weight';
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

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI(weight, height);
    double bmr = calculateBMR(age, weight, height);

    return Scaffold(
      appBar: AppBar(
        title: Text('Today', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Adjust the color to match your design
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Today's Weight: ${weight.toStringAsFixed(1)} ${'Kg'}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                color: Colors.pink.shade100, // Light pink background
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Body Mass Index',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                     " ${bmi.toStringAsFixed(1)}",
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      getBmiLabel(bmi),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                color: Colors.pink.shade100, // Light pink background
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Basic Metabolism Rate',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      bmr.toStringAsFixed(0) + ' KCals',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WeightRecordScreen()));
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text("Update Weight", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.alarm, color: Colors.blue),
              title: Text('Remind me to track my weight', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WeightRecordReminderScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.compare_arrows, color: Colors.blue),
              title: Text('Comparison with last record', style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WeightComparisonScreen()));
              },
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
