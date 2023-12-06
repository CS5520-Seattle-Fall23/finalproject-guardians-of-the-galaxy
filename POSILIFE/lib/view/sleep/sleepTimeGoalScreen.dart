import 'package:flutter/material.dart';
import 'sleepTimeScreen.dart';
import "../account/accountInfoScreen.dart";
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';

class SleepTimeGoalScreen extends StatefulWidget {
  @override
  _SleepTimeGoalScreenState createState() => _SleepTimeGoalScreenState();
}

class _SleepTimeGoalScreenState extends State<SleepTimeGoalScreen> {
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
        title: Text("Today's Sleep Time Goal", style: TextStyle(color: Colors.black)),
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
            // The title section with "Today" and SleepTime intake statistics will be here
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Set Your Today's Sleep Time Goal: ",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // The pie chart will go here
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

            // The button to add SleepTime intake Goal will go here
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink[50], // 背景色
                    border: Border.all(
                      color: Colors.white, // 边框颜色
                      width: 2.0, // 边框宽度
                    ),
                    borderRadius: BorderRadius.circular(18.0), // 圆角
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0,vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.black, // 文本颜色
                            fontWeight: FontWeight.bold,
                          ),
                        ), // 标签
                      ],
                    ),
                  ),
                ),
              ),
            ),

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
