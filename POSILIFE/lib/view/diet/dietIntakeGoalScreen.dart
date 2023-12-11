import 'package:flutter/material.dart';
import "../account/accountInfoScreen.dart";
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dietIntakeScreen.dart';
import '../../controller/date_controller.dart';


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

  void _confirmDietIntakeGoal() async {
  try {
    int dietIntakeGoal = int.parse(_calorieAmountController.text.trim());
    String unit = isKJ ? 'kJ' : 'kcal';

    // Convert to kcal if the input is in kJ
    if (unit == 'kJ') {
      dietIntakeGoal = (dietIntakeGoal / 4.184).round(); 
      unit = 'kcal'; // Store only in 'kcal' in the database
    }

    // Fetch the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Timestamp now = Timestamp.now();
    DateTime dateOnly = DateTime(now.toDate().year, now.toDate().month, now.toDate().day);
    String dateId = formatDateOnly(dateOnly);

    // Fetch the user's current water document
    DocumentReference dietRef = FirebaseFirestore.instance.collection('Diet').doc(userId).collection('dietRecord').doc(dateId);
    DocumentSnapshot dietSnap = await dietRef.get();

    if (dietSnap.exists) {
      // Update the current water document
      await dietRef.update({
      'goal': dietIntakeGoal,
      'goalUnit': unit,
    });
    } else {
      // Create a new water document for the user if it does not exist
      await dietRef.set({
          'current': 0,
          'goal': dietIntakeGoal, // Set a default goal or fetch from user preferences
          'currentUnit': 'kcal',
          'goalUnit': unit, // Set a default goal unit or fetch from user preferences
      });
    }
    
    // Clear the input field after submitting
    _calorieAmountController.clear();

    Navigator.push(context, MaterialPageRoute(builder: (context) => DietIntakeScreen()));
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Calorie intake goal of $dietIntakeGoal $unit recorded'),
    ));

    // Optionally, navigate to a different screen or perform other actions upon success
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SomeOtherScreen()));

  } catch (e) {
    print('Error confirming calorie intake goal: $e');
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to record calorie intake Goal'),
    ));
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
              onPressed: _confirmDietIntakeGoal,
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
                  'Kcal',
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
                  'KJ',
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
