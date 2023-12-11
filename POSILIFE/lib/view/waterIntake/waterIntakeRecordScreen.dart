import 'package:flutter/material.dart';
import '../account/accountInfoScreen.dart';
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'waterIntakeScreen.dart';
import '../../controller/date_controller.dart';



class WaterIntakeRecordScreen extends StatefulWidget {
  @override
  _WaterIntakeRecordScreenState createState() => _WaterIntakeRecordScreenState();
}
class _WaterIntakeRecordScreenState extends State<WaterIntakeRecordScreen> {
  final TextEditingController _waterAmountController = TextEditingController();
  bool isOunces = false; // State variable to track unit toggle
  int _selectedIndex = 0;
  void _confirmWaterIntake() async {
  try {
    int waterIntake = int.parse(_waterAmountController.text.trim());
    String unit = isOunces ? 'oz' : 'ml';
    // Convert to ml if the input is in ounces
    if (unit == 'oz') {
      waterIntake = (waterIntake * 29.5735).round(); // 1oz = 29.5735ml
      unit = 'ml'; // Store only in 'ml' in the database
    }

    // Fetch the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Timestamp now = Timestamp.now();
    DateTime dateOnly = DateTime(now.toDate().year, now.toDate().month, now.toDate().day);
    String dateId = formatDateOnly(dateOnly);

    // Fetch the user's current water document
    DocumentReference waterRef = FirebaseFirestore.instance.collection('Water').doc(userId).collection('waterRecord').doc(dateId);
    DocumentSnapshot waterSnap = await waterRef.get();

    if (waterSnap.exists) {
      // Update the current water document
      await waterRef.update({
        'Current': FieldValue.increment(waterIntake), // Increment the current water amount
        'currentUnit': unit, // Update the current unit
      });
    } else {
      // Create a new water document for the user if it does not exist
      await waterRef.set({
          'Current': waterIntake,
          'Goal': 3000, // Set a default goal or fetch from user preferences
          'currentUnit': unit,
          'goalUnit': 'ml', // Set a default goal unit or fetch from user preferences
      });
    }
    
    // Clear the input field after submitting
    _waterAmountController.clear();

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Water intake of $waterIntake $unit recorded'),
    ));

    // Optionally, navigate to a different screen or perform other actions upon success
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SomeOtherScreen()));

  } catch (e) {
    print('Error confirming water intake: $e');
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to record water intake'),
    ));
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Water Intake"),
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
              'Add Water:',
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
              onPressed: () {
                // Call the confirm water intake function when the button is pressed
                _confirmWaterIntake();
                // navigate to the waterIntakeScreen again
                Navigator.push(context, MaterialPageRoute(builder: (context) => WaterIntakeScreen()));
              },
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


