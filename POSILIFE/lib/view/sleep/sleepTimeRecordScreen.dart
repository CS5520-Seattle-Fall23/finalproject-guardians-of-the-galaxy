import 'package:complete/controller/date_controller.dart';
import 'package:flutter/material.dart';
import 'sleepTimeScreen.dart';
import "../account/accountInfoScreen.dart";
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SleepTimeRecordScreen extends StatefulWidget {
  @override
  _SleepTimeRecordScreenState createState() => _SleepTimeRecordScreenState();
}

class _SleepTimeRecordScreenState extends State<SleepTimeRecordScreen> {
  final TextEditingController _sleepTimeController = TextEditingController();
  int _selectedIndex = 0;
  void _confirmSleepTime() async {
    try{
      int sleepTime = int.parse(_sleepTimeController.text.trim());

      // Fetch the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;
      Timestamp now = Timestamp.now();
      DateTime dateOnly = DateTime(now.toDate().year, now.toDate().month, now.toDate().day);
      String dateId = formatDateOnly(dateOnly);

      //Fetch the user's current sleep document
      DocumentReference sleepRef = FirebaseFirestore.instance.collection('Sleep').doc(userId).collection('sleepRecord').doc(dateId);
      DocumentSnapshot sleepSnap = await sleepRef.get();

      if (sleepSnap.exists) {
        // update the current sleep document
        await sleepRef.update({
          'current': FieldValue.increment(sleepTime), // increment the current sleep time
        });
      } else {
        // Create a new diet document for the user if it doesn't exist
        await sleepRef.set({
            'current': sleepTime,
            'date': Timestamp.fromDate(DateTime.now()),
            'goal': 8, // default
        });
      }

      //Clear the input field after submitting
      _sleepTimeController.clear();

      Navigator.push(context, MaterialPageRoute(builder: (context) => SleepTimeScreen()));

      //Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sleep time of $sleepTime h recorded.'),
      ));

    } catch(e) {
      print('Error confirming sleep time: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to record sleep time.'),
      ));
    }
  }
  @override
  void dispose() {
    _sleepTimeController.dispose();
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
        title: Text("Today's Sleep Time"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),// Remove the drop shadow
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add Sleep Time:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _sleepTimeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter time',
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
              onPressed: () {
                // Call the confirm sleep time function when the button is pressed
                _confirmSleepTime();
                // navigate to the sleepTimeScreen again
                Navigator.push(context, MaterialPageRoute(builder: (context) => SleepTimeScreen()));
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50), // specify the height of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
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

