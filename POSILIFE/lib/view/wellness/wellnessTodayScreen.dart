import 'package:flutter/material.dart';
import 'weightRecordReminderScreen.dart';
import 'weightRecordScreen.dart';
import 'weightComparisonScreen.dart';
import '../homeScreen.dart';
import"../account/accountInfoScreen.dart";
import '../bottomNavigationBar.dart';



class WellnessTodayScreen extends StatefulWidget {
  @override
  _WellnessTodayScreen createState() => _WellnessTodayScreen();
}
class _WellnessTodayScreen extends State<WellnessTodayScreen> {
  bool isKg = true; // State variable to track unit toggle for weight
  int _selectedIndex = 0;

  String getBmiLabel(double bmi) {
    // BMI lable logic 
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
        Navigator.pushNamed(context, '/waterIntakeScreen');
        break;
      case 1:
        Navigator.pushNamed(context, '/periodRecordScreen');
        break;
      case 2:
        Navigator.pushNamed(context, '/reportHomeScreen');
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
                'Today‘s Weight: 50.3 Kg',
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
                      '19.6',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Healthy Weight',
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
                      '1586 KCals',
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Ibs',
                    style: TextStyle(
                      fontSize: 16,
                      color: isKg ? Colors.grey : Colors.black,
                    ),
                  ),
                  Switch(
                    value: isKg,
                    onChanged: (value) {
                      setState(() {
                        isKg = value;
                        // TODO: Implement unit conversion if needed
                      });
                    },
                    activeTrackColor: Colors.pink.shade200,
                    activeColor: Colors.pink,
                  ),
                  Text(
                    'Kg',
                    style: TextStyle(
                      fontSize: 16,
                      color: isKg ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
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
