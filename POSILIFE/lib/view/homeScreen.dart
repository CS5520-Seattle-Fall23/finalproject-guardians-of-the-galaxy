
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For using Cupertino icons

import 'waterIntake/waterIntakeScreen.dart';
import 'sleep/sleepTimeScreen.dart';
import 'wellness/wellnessTodayScreen.dart';
import 'diet/dietIntakeScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
   // a variable to track the selected button index
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POSI LIFE', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 238, 139, 200),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Hello, Sweet Angel! 🌻',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  _buildFeatureButton(context, 'Water', Icons.local_drink, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WaterIntakeScreen()));
                  }),
                  _buildFeatureButton(context, 'Sleep', Icons.nights_stay, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SleepTimeScreen()));
                  }),
                  _buildFeatureButton(context, 'Diet', Icons.restaurant_menu, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DietIntakeScreen()));
                  }),
                  _buildFeatureButton(context, 'Wellness', Icons.spa, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WellnessTodayScreen()));
                  }),
                ],
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

  Widget _buildFeatureButton(BuildContext context, String label, IconData icon, Function onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: ElevatedButton.icon(
      icon: Icon(icon, color: Color.fromARGB(255, 247, 243, 243)),
      label: Text(label, style: TextStyle(color: Color.fromARGB(255, 247, 243, 243))),
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 254, 99, 151),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: TextStyle(fontSize: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
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
        return Icons.check_circle_outline;
      case 1:
        return Icons.invert_colors;
      case 2:
        return Icons.bar_chart;
      case 3:
        return Icons.account_circle;
      default:
        return Icons.error;
    }
  }
}


