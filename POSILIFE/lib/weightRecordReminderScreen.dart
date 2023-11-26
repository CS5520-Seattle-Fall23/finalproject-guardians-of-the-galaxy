import 'package:flutter/material.dart';


class WeightRecordReminderScreen extends StatefulWidget {
  @override
  _WeightRecordReminderScreenState createState() => _WeightRecordReminderScreenState();
}
class _WeightRecordReminderScreenState extends State<WeightRecordReminderScreen> {

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Customize Reminder:'),
            // Use a TimePicker or similar widget to let user select a time
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Remind me to record today\'s weight at: ${selectedTime.format(context)}'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Add logic to set the reminder
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}