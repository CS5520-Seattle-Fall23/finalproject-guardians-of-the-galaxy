import 'package:complete/view/wellness/wellnessTodayScreen.dart';
import 'package:flutter/material.dart';
import '../account/accountInfoScreen.dart';
import '../bottomNavigationBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';



class WeightRecordScreen extends StatefulWidget {
  @override
  _WeightRecordScreenState createState() => _WeightRecordScreenState();
}
class _WeightRecordScreenState extends State<WeightRecordScreen> {
  int _selectedIndex = 0;
  final TextEditingController _weightAmountController = TextEditingController();
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
   void _confirmWeight() async {
  try {
    int newWeight = int.parse(_weightAmountController.text);
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Fetch existing weight and height data
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    int lastWeight = 0;
    int height = 0; // Initialize height
    bool hasWellnessRecord = false;

    if (userDoc.exists) {
      lastWeight = _parseInt(userDoc['Weight']);
      height = _parseInt(userDoc['Height']); // Fetch height from Users collection
    }

    DocumentSnapshot wellnessDoc = await FirebaseFirestore.instance.collection('Wellness').doc(userId).get();
    hasWellnessRecord = wellnessDoc.exists;

    if (hasWellnessRecord) {
      // If there's existing data in Wellness, use it as lastWeight
      lastWeight = _parseInt(wellnessDoc['Weight']);
    }

    // Update weight and height in Wellness collection
    await FirebaseFirestore.instance.collection('Wellness').doc(userId).set({
      'Weight': newWeight,
      'lastWeight': lastWeight,
      'Height': height, // Set height in Wellness
    }, SetOptions(merge: true));

    // Update weight in Users collection
    await FirebaseFirestore.instance.collection('Users').doc(userId).set({
      'Weight': newWeight,
    }, SetOptions(merge: true));

    // Clear the input field and navigate
    _weightAmountController.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) => WellnessTodayScreen()));

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Weight updated to $newWeight kg'),
    ));
  } catch (e) {
    print('Error updating weight: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to update weight'),
    ));
  }
}

int _parseInt(dynamic value) {
  return (value is String) ? int.tryParse(value) ?? 0 : (value ?? 0);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's weight"),
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
              'Add weight:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _weightAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                filled: true,
                fillColor: Colors.pink[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixText: 'kg',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _confirmWeight,
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
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}
