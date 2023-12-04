import 'package:flutter/material.dart';
import 'dietIntakeScreen.dart';


class DietIntakeReminderScreen extends StatefulWidget {
  @override
  _DietIntakeReminderScreenState createState() => _DietIntakeReminderScreenState();
}
class _DietIntakeReminderScreenState extends State<DietIntakeReminderScreen> {
  final TextEditingController _calorieController = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/CalorieIntakeScreen');
        break;
      case 1:
        Navigator.pushNamed(context, '/periodRecordScreen');
        break;
      case 2:
        Navigator.pushNamed(context, '/reportHomeScreen');
        break;
      case 3:
        Navigator.pushNamed(context, '/accountInfoScreen');
        break;
    }
  }
  void _sendCaloriesToBackend(int calories) async {
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
    //       'calories': calories,
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

    print('CalorieIntake sent to the backend: $calories');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Customize Reminder:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Remind me when the total calorie intake reaches:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _calorieController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your Calorie Intake goal',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate and send the calories to the backend
                int? calories = int.tryParse(_calorieController.text);
                if (calories != null) {
                  _sendCaloriesToBackend(calories);
                } else {
                  // Show error or validation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid number.')),
                  );
                }
              },
              child: Text('Confirm'),
            ),
            SwitchListTile(
              title: Text('Kcal'),
              subtitle: Text('KJ'),
              value: true,
              onChanged: (bool value) {
              },
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