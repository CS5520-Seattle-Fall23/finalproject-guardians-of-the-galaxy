import 'package:complete/sleepTimeRecordScreen.dart';
import 'package:complete/sleepTimeReminderScreen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'homeScreen.dart';

class SleepTimeScreen extends StatefulWidget {
  @override
  _SleepTimeScreenState createState() => _SleepTimeScreenState();
}
class _SleepTimeScreenState extends State<SleepTimeScreen> {
  bool isOunces = false; // State variable to track unit toggle
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0, // Remove the drop shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
          // Check if the current screen can be popped
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Pop the current screen off the stack
          } else {
            Navigator.of(context).pushReplacement(
          // Push the home screen onto the stack without the ability to navigate back to the current screen
            MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your home screen widget
            );
          }
        },
      ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // The title section with "Today" and SleepTime intake statistics will be here
                        Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Your SleepTime today:',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      // TODO: Add logic to display the SleepTime intake value(backend integration)
                      Text(
                        '7.5 h',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Your SleepTime goal:',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      // TODO: Add logic to display the SleepTime intake value(backend integration)
                      Text(
                        '10 h',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // The pie chart will go here
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: 0.7, // Assuming 70% of the goal is completed
                center: Text(
                  //TODO: Add logic to display the SleepTime intake percentage(backend integration)
                  "75%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: Text(
                  "75% of your goal!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.pink,
              ),
            ),

            // The button to add SleepTime intake record will go here
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SleepTimeRecordScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue, // 背景色
                  border: Border.all(
                    color: Colors.black, // 边框颜色
                    width: 2.0, // 边框宽度
                  ),
                  borderRadius: BorderRadius.circular(18.0), // 圆角
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Record Sleep Time',
                        style: TextStyle(
                          color: Colors.black, // 文本颜色
                          fontWeight: FontWeight.bold,
                        ),
                      ), // 标签
                      Icon(Icons.add), // 图标
                    ],
                  ),
                ),
              ),
            ),

            // The reminder section will go here
                        Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: InkWell(
                onTap: () {
                  // Navigate to SleepTimeIntakereminderScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SleepTimeReminderScreen()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.alarm, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Remind me to go to bed!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // The bottom navigation bar will be added here
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'TODAY',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.invert_colors),
            label: 'PERIOD',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'REPORT',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'ACCOUNT',
            backgroundColor: Colors.black,
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 238, 107, 151),
      ),
    );
  }
}
