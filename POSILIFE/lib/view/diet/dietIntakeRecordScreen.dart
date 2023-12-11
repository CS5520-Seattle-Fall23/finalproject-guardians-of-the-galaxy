import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete/controller/date_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "../account/accountInfoScreen.dart";
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';


class DietIntakeRecordScreen extends StatefulWidget {
  @override
  _DietIntakeRecordScreenState createState() => _DietIntakeRecordScreenState();
}
class _DietIntakeRecordScreenState extends State<DietIntakeRecordScreen> {
  final TextEditingController _calorieAmountController = TextEditingController();
  int _selectedIndex = 0;
  bool isKJ = false; // State variable to track unit toggle

  void _confirmCalorieIntake() async {
    try{
      int calorieIntake = int.parse(_calorieAmountController.text.trim());
      String unit = isKJ ? 'kJ' : 'kcal';

      //Convert to kcal if the input is in kJ
      if (unit == 'kJ') {
        calorieIntake = (calorieIntake / 4.184).round(); // 1kcal = 4.184kj
        unit = 'kcal';
      }

      //Fetch the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;
      Timestamp now = Timestamp.now();
      DateTime dateOnly = DateTime(now.toDate().year, now.toDate().month, now.toDate().day);
      String dateId = formatDateOnly(dateOnly);

      //Fetch the user's current diet document
      DocumentReference dietRef = FirebaseFirestore.instance.collection('Diet').doc(userId).collection('dietRecord').doc(dateId);;
      DocumentSnapshot dietSnap = await dietRef.get();

      if (dietSnap.exists) {
        // update the current diet document
        await dietRef.update({
          'current': FieldValue.increment(calorieIntake), // increment the current calorie intake
          'currentUnit': unit, //update the current unit
        });
      } else {
        // Create a new diet document for the user if it doesn't exist
        await dietRef.set({
            'current': calorieIntake,
            'goal': 2000, // default
            'currentUnit': unit,
            'goalUnit':'kcal',
        });
      }

      //Clear the input field after submitting
      _calorieAmountController.clear();

      Navigator.push(context, MaterialPageRoute(builder: (context) => DietIntakeScreen()));

      //Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Calories inkate of $calorieIntake $unit recorded.'),
      ));

    } catch(e) {
      print('Error confirming calories intake: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to record calories inkate.'),
      ));
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's calorie Intake"),
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
              'Add calorie:',
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
              onPressed: () {
                _confirmCalorieIntake();
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),  
              )
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
                      _calorieAmountController.text = '';
                    });
                  },
                  activeColor: Colors.green,
                ),
                Text(
                    'kJ',
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
