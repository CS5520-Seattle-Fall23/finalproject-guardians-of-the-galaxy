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
  int quantity = 7;
  int _selectedIndex = 0;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _confirmSleepTime() async {
    try{
      int sleepTime = int.parse(_sleepTimeController.text.trim());


      //Fetch the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      //Fetch the user's current sleep document
      DocumentReference sleepRef = FirebaseFirestore.instance.collection('Sleep').doc(userId);
      DocumentSnapshot sleepSnap = await sleepRef.get();

      if (sleepSnap.exists) {
        // update the current sleep document
        await sleepRef.update({
          'sleepTimeMap.current': FieldValue.increment(sleepTime), // increment the current sleep time
        });
      } else {
        // Create a new diet document for the user if it doesn't exist
        await sleepRef.set({
          'sleepTimeMap': {
            'current': sleepTime,
            'date': Timestamp.fromDate(DateTime.now()),
            'goal': 8, // default
          },
          'reminderTime': Timestamp.now(),
        });
      }

      //Clear the input field after submitting
      _sleepTimeController.clear();

      //Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sleep time of $sleepTime h recorded.'),
      ));

    } catch(e) {
      print('Error confirming calories intake: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to record sleep time.'),
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
        title: Text("Today's Sleep Time", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0, // Remove the drop shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Check if the current screen can be popped
            if (Navigator.of(context).canPop()) {
              Navigator.of(context)
                  .pop(); // Pop the current screen off the stack
            } else {
              Navigator.of(context).pushReplacement(
                // Push the home screen onto the stack without the ability to navigate back to the current screen
                MaterialPageRoute(
                    builder: (context) =>
                        SleepTimeScreen()), // Replace with your home screen widget
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // record today's sleep time
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Record Sleep Time: ',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // edit sleep time
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_upward),
                  onPressed: incrementQuantity,
                ),
                Text(
                  '$quantity hours',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_downward),
                  onPressed: decrementQuantity,
                ),
              ],
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _confirmSleepTime();
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

            // The reminder section will go here
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

