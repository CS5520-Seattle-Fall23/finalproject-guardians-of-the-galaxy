import 'package:flutter/material.dart';
// Import any additional packages you might need for HTTP requests, such as 'package:http/http.dart' as http.

class WaterIntakeReminderScreen extends StatefulWidget {
  @override
  _WaterIntakeReminderScreenState createState() => _WaterIntakeReminderScreenState();
}

class _WaterIntakeReminderScreenState extends State<WaterIntakeReminderScreen> {
  final TextEditingController _waterController = TextEditingController();
  int _selectedIndex = 0;
  bool isOunces = false; // State variable to track unit toggle
  @override
  void dispose() {
    _waterController.dispose();
    super.dispose();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/waterIntakeScreen');
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
  void _sendwatersToBackend(int waters) async {
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
    //       'waters': waters,
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

    print('WaterIntake sent to the backend: $waters');
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
              'Remind me when the total water intake reaches:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _waterController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your waterIntake goal',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate and send the waters to the backend
                int? waters = int.tryParse(_waterController.text);
                if (waters != null) {
                  _sendwatersToBackend(waters);
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
              title: Text('oz'),
              subtitle: Text('ml'),
              value: true,
              onChanged: (bool value) {
              },
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
class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(4, (index) {
          return InkWell(
            onTap: () => onItemTapped(index),
            splashColor: Colors.transparent, // Remove splash effect
            highlightColor: Colors.transparent, // Remove highlight effect
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: kBottomNavigationBarHeight,
              width: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                color: selectedIndex == index ? Colors.pink.shade200 : Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                getIcon(index),
                color: selectedIndex == index ? Colors.white : Colors.grey,
              ),
            ),
          );
        }),
      ),
      color: Colors.white,
    );
  }

  IconData getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.calendar_view_day;
      case 1:
        return Icons.calendar_month;
      case 2:
        return Icons.bar_chart;
      case 3:
        return Icons.account_box;
      default:
        return Icons.error;
    }
  }
}
