import 'package:flutter/material.dart';
import '../account/accountInfoScreen.dart';
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';

class WaterIntakeGoalScreen extends StatefulWidget {
  @override
  _WaterIntakeGoalScreenState createState() => _WaterIntakeGoalScreenState();
}
class _WaterIntakeGoalScreenState extends State<WaterIntakeGoalScreen> {
  final TextEditingController _waterAmountController = TextEditingController();
  bool isOunces = false; // State variable to track unit toggle
  int _selectedIndex = 0;
  @override
  void dispose() {
    _waterAmountController.dispose();
    super.dispose();
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
  void _confirmWaterIntake() {
    // Logic to confirm water intake goes here
    // Convert to ounces if necessary and send to backend or local storage
    int waterIntake = int.parse(_waterAmountController.text);
    if (isOunces) {
      // Convert to ml if needed
      waterIntake = (waterIntake * 29.5735).round(); // 1oz = 29.5735ml
    }
    print('Water Intake: $waterIntake ml'); // Replace with actual logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Water Intake Goal"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Set Your Today's Goal:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _waterAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                filled: true,
                fillColor: Colors.pink[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixText: isOunces ? 'oz' : 'ml',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _confirmWaterIntake,
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50), // specify the height of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ml',
                  style: TextStyle(
                    fontSize: 16,
                    color: isOunces ? Colors.grey : Colors.black,
                  ),
                ),
                Switch(
                  value: isOunces,
                  onChanged: (value) {
                    setState(() {
                      isOunces = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
                Text(
                  'oz',
                  style: TextStyle(
                    fontSize: 16,
                    color: isOunces ? Colors.black : Colors.grey,
                  ),
                ),
              ],
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