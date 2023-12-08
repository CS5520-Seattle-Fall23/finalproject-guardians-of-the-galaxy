import 'package:flutter/material.dart';
import "../account/accountInfoScreen.dart";
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';


class DietIntakeGoalScreen extends StatefulWidget {
  @override
  _DietIntakeGoalScreenState createState() => _DietIntakeGoalScreenState();
}
class _DietIntakeGoalScreenState extends State<DietIntakeGoalScreen> {
  final TextEditingController _calorieAmountController = TextEditingController();
  bool isKJ = false; // State variable to track unit toggle
  int _selectedIndex = 0;
  @override
  void dispose() {
    _calorieAmountController.dispose();
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
  void _confirmCalorieIntake() {
    // Logic to confirm calorie intake goes here
    // Convert to Kcal if necessary and send to backend or local storage
    int calorieIntake = int.parse(_calorieAmountController.text);
    if (isKJ) {
      // Convert to kj if needed
      calorieIntake = (calorieIntake * 4.184).round(); // 1kcal = 4.184kj
    }
    print('calorie Intake: $calorieIntake KJ'); // Replace with actual logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's calorie Intake Goal"),
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
              'Set Your Calorie Intake Goal:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _calorieAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                filled: true,
                fillColor: Colors.pink[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixText: isKJ ? 'kJ' : 'kcal',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _confirmCalorieIntake,
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
                  'KJ',
                  style: TextStyle(
                    fontSize: 16,
                    color: isKJ ? Colors.grey : Colors.black,
                  ),
                ),
                Switch(
                  value: isKJ,
                  onChanged: (value) {
                    setState(() {
                      isKJ = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
                Text(
                  'Kcal',
                  style: TextStyle(
                    fontSize: 16,
                    color: isKJ ? Colors.black : Colors.grey,
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