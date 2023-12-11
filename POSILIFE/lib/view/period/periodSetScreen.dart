import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete/model/period.dart';
import 'package:flutter/material.dart';
import '../bottomNavigationBar.dart';
import '../account/accountInfoScreen.dart';
import 'periodMainScreen.dart';
import '../homeScreen.dart';
import '../report/reportHomeScreen.dart';
import '../../controller/date_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PeriodSetScreen extends StatefulWidget {
  @override
  _PeriodSetScreenState createState() => _PeriodSetScreenState();
}

class _PeriodSetScreenState extends State<PeriodSetScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  int _selectedIndex = 1;

  void _updatePeriodData() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String documentId = DateFormat('yyyy-MM').format(DateTime.now()); // Assuming the document ID is the current year-month

  int? startDate;
  int? endDate;

  // Parse the user input. If the input is not valid (e.g., not a number), use a default value of 1.
  try {
    startDate = int.parse(_startDateController.text.trim());
  } catch (e) {
    startDate = 1; // Default value if parsing fails
  }
  try {
    endDate = int.parse(_endDateController.text.trim());
  } catch (e) {
    endDate = 1; // Default value if parsing fails
  }

  DocumentReference periodRecordRef = FirebaseFirestore.instance
      .collection('Period')
      .doc(userId)
      .collection('periodRecord')
      .doc(documentId);

  // Fetch the user's current period document
  DocumentSnapshot periodSnapshot = await periodRecordRef.get();

  if (periodSnapshot.exists) {
    // Update the current period document
    await periodRecordRef.update({
      'startDate': startDate,
      'endDate': endDate,
    });
  } else {
    // Create a new period document for the user if it doesn't exist
    await periodRecordRef.set({
      'startDate': startDate,
      'endDate': endDate,
    });
  }

  // Clear the input fields after submitting
  _startDateController.clear();
  _endDateController.clear();

  // Show confirmation message
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Period data updated successfully.'),
  ));
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

String _getCurrentMonth() {
  return DateFormat('MMMM').format(DateTime.now());
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Your Period"),
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
              _getCurrentMonth(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _startDateController,
              decoration: InputDecoration(
                labelText: 'Start Date',
                labelStyle: TextStyle(color: Colors.pink), // Adjust the color as needed
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink, width: 2.0), // Adjust the color and width as needed
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink, width: 2.0), // Adjust the color and width as needed
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black), // Adjust the text color as needed
            ),
            SizedBox(height: 16),
            TextField(
              controller: _endDateController,
              decoration: InputDecoration(
                labelText: 'End Date',
                labelStyle: TextStyle(color: Colors.pink), // Adjust the color as needed
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink, width: 2.0), // Adjust the color and width as needed
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink, width: 2.0), // Adjust the color and width as needed
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black), // Adjust the text color as needed
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _updatePeriodData();
                Navigator.push(context, MaterialPageRoute(builder: (context) => PeriodCalendarPage()));
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
