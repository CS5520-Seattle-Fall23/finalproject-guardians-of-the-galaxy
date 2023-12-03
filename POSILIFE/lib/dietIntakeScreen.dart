import 'package:complete/dietIntakeRecordScreen.dart';
import 'package:complete/dietIntakeReminderScreen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'homeScreen.dart';

class DietIntakeScreen extends StatefulWidget {
  @override
  _DietIntakeScreenState createState() => _DietIntakeScreenState();
}

class _DietIntakeScreenState extends State<DietIntakeScreen> {
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
              Navigator.of(context)
                  .pop(); // Pop the current screen off the stack
            } else {
              Navigator.of(context).pushReplacement(
                // Push the home screen onto the stack without the ability to navigate back to the current screen
                MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen()), // Replace with your home screen widget
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // The title section with "Today" and Diet intake statistics will be here
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Your calorie intake today:',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      // TODO: Add logic to display the SleepTime intake value(backend integration)
                      Text(
                        '1400 kcal',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Your calorie intake toal:',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      // TODO: Add logic to display the SleepTime intake value(backend integration)
                      Text(
                        '2000 kcal',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                percent: 0.7,
                // Assuming 70% of the goal is completed
                center: Text(
                  //TODO: Add logic to display the Diet intake percentage(backend integration)
                  "70%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: Text(
                  "70% of your goal!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.pink,
              ),
            ),

            // The button to add Diet intake record will go here
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DietIntakeReminderScreen()),
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
                        'Calories',
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
                  // Navigate to DietIntakereminderScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DietIntakeReminderScreen()),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.alarm, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Remind me to control my Diet!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // The toggle for units (oz/ml) will go here
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    isOunces
                        ? 'Your Diet intake today in cal:'
                        : 'Your Diet intake today in kcal:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: isOunces,
                    onChanged: (value) {
                      setState(() {
                        isOunces = value;
                        // TODO: Add logic to convert the Diet intake value between ml and oz
                      });
                    },
                    activeTrackColor: Colors.lightBlueAccent,
                    activeColor: Colors.blue,
                  ),
                ],
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
