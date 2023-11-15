import 'package:flutter/material.dart';
import 'package:posilife_1/WeightRecordReminderScreen.dart';
import 'package:posilife_1/weightRecordScreen.dart';
import 'package:posilife_1/weightComparisonScreen.dart';

class WellnessTodayScreen extends StatefulWidget {
  @override
  _WellnessTodayScreen createState() => _WellnessTodayScreen();
}
class _WellnessTodayScreen extends State<WellnessTodayScreen> {
  bool isLbs = false; // State variable to track unit togglr
  double bmi = 19.6; // Example BMI
  double bmr = 1586; // Example BMR

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

  int _selectedIndex = 0; // a variable to track the selected button index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // update index when selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              // Check if the current screen can be popped
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(); // Pop the current screen off the stack
              } else {
                // Navigator.of(context).pushReplacement(
                // // TODO: Push the home screen onto the stack without the ability to navigate back to the current screen
                // MaterialPageRoute(builder: (context) => HomeScreen()),
                // );
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SwitchListTile(
              title: Text(isLbs ? 'lbs' : 'kg'),
              value: isLbs, 
              onChanged: (bool value){
                setState(() {
                  isLbs = value;
                  //TODO: Convert weight values between kg and lbs
                });
              },
            secondary: const Icon(Icons.scale),
            ),
            // widges for BMI and BMR
            const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Today\'s Weight:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // TODO: Add logic to display the weight(backend integration)
                      Text(
                        '50.3',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'kg',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            Container(
              color: Colors.pink[100], // Adjust the color to match your UI design
              child: ListTile(
                leading: const Icon(Icons.fitness_center), // Replace with your BMI icon
                title: Text('${bmi.toStringAsFixed(1)}'),
                subtitle: Text(getBmiLabel(bmi)),
              ),
            ),
            Container(
              color: Colors.pink[200], // Adjust the color to match your UI design
              child: ListTile(
                leading: const Icon(Icons.local_fire_department), // Replace with your BMR icon
                title: Text('${bmr.toInt()} Kcals'),
              ),
            ),
            
            // record today's weight
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to weightrecordreminderScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeightRecordScreen()),
                  );
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text("Update Weight", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
              ),
            ),
            
            // reminder lable
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: InkWell(
                onTap: () {
                  // Navigate to weightrecordreminderScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeightRecordReminderScreen()),
                  );
                },
                child: const Row(
                  children: <Widget>[
                    Icon(Icons.alarm, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Remind me to track my weight',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // comparison lable
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: InkWell(
                onTap: () {
                  // Navigate to weightrecordScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeightComparisonScreen()),
                  );
                },
                child: const Row(
                  children: <Widget>[
                    Icon(Icons.alarm, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Comparison with last record',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],)
        ),
        // The bottom navigation bar will be added here
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline),
              label: 'TODAY',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.invert_colors),
              label: 'PERIOD',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'REPORT',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'ACCOUNT',
              backgroundColor: Colors.black,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 238, 107, 151),
          onTap: _onItemTapped, 
        ),
    );
  }
}