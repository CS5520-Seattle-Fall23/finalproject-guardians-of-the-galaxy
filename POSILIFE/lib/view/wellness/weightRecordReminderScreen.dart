import 'package:flutter/material.dart';
import '../account/accountInfoScreen.dart';
import '../bottomNavigationBar.dart';

import '../homeScreen.dart';
import "../period/periodMainScreen.dart";
import '../report/reportHomeScreen.dart';


class WeightRecordReminderScreen extends StatefulWidget {
  @override
  _WeightRecordReminderScreenState createState() => _WeightRecordReminderScreenState();
}
class _WeightRecordReminderScreenState extends State<WeightRecordReminderScreen> {
  int _selectedIndex = 0;
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
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
  // example code for backend
  void _sendWellnessToBackend(int Wellness) async {
    // Placeholder for sending data to the backend.
    // You would replace this with your actual HTTP request code.
    // Here's an example using the http package:
    //
    // try {
    //   final response = await http.post(
    //     Uri.parse('YOUR_BACKEND_URL'),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(<String, int>{
    //       'Wellness': Wellness,
    //     }),
    //   );
    //
    //   if (response.statusCode == 200) {
    //     // Handle the response
    //   } else {
    //     // If the server did not return a 200 OK response,
    //     // then throw an exception.
    //     throw Exception('Failed to load data');
    //   }
    // } catch (e) {
    //   // Handle any errors here
    // }

    print('Wellness stats sent to the backend: $Wellness');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Customize Reminder:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () => _selectTime(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Remind me to record my weight at:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${selectedTime.format(context)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement save reminder logic
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 230, 183, 199), // Button background color
                foregroundColor: Colors.white, // Button text color
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}