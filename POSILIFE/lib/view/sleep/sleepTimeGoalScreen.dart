import 'package:flutter/material.dart';
import 'sleepTimeScreen.dart';
import "../account/accountInfoScreen.dart";
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import '../../controller/date_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SleepTimeGoalScreen extends StatefulWidget {
  @override
  _SleepTimeGoalScreenState createState() => _SleepTimeGoalScreenState();
}

class _SleepTimeGoalScreenState extends State<SleepTimeGoalScreen> {
  final TextEditingController _sleepGoalController = TextEditingController();
  int _selectedIndex = 0;
  @override
  void dispose() {
    _sleepGoalController.dispose();
    super.dispose();
  }

  void _confirmSleepTimeGoal() async {
  try {
    int sleepTimeGoal = int.parse(_sleepGoalController.text.trim());

    // Fetch the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Timestamp now = Timestamp.now();
    DateTime dateOnly = DateTime(now.toDate().year, now.toDate().month, now.toDate().day);
    String dateId = formatDateOnly(dateOnly);

    // Fetch the user's current sleep document
    DocumentReference sleepRef = FirebaseFirestore.instance.collection('Sleep').doc(userId).collection('sleepRecord').doc(dateId);
    DocumentSnapshot sleepSnap = await sleepRef.get();

    if (sleepSnap.exists) {
      // Update the current sleep document
      await sleepRef.update({
      'goal': sleepTimeGoal,
    });
    } else {
      // Create a new sleep document for the user if it does not exist
      await sleepRef.set({
          'current': 0,
          'goal': sleepTimeGoal, // Set a default goal or fetch from user preferences
      });
    }
    
    // Clear the input field after submitting
    _sleepGoalController.clear();

    Navigator.push(context, MaterialPageRoute(builder: (context) => SleepTimeScreen()));
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Water intake Goal of $sleepTimeGoal h recorded'),
    ));

    // Optionally, navigate to a different screen or perform other actions upon success
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SomeOtherScreen()));

  } catch (e) {
    print('Error confirming sleep time: $e');
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to record sleep time goal'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Sleep Time Goal", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0, // Remove the drop shadow
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Set Your Sleep Goal:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _sleepGoalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Goal',
                filled: true,
                fillColor: Colors.pink[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixText: 'h',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _confirmSleepTimeGoal, 
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50), // specify the height of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              )
            ),
          ],
        ),
      ),
      // The bottom navigation bar will be added here
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}

