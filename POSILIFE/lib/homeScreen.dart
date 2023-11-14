import 'package:complete/dietIntakeScreen.dart';
import 'package:complete/sleepTimeScreen.dart';
import 'package:complete/waterIntakeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For using Cupertino icons

class FunctionType {
  static const FunctionTypeWater = 1;
  static const FunctionTypeSleep = 2;
  static const FunctionTypeDiet = 3;
  static const FunctionTypeWellness = 4;
}

class HomeScreen extends StatelessWidget {
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
                  _buildFeatureButton(context, 'Water', Icons.local_drink,
                      FunctionType.FunctionTypeWater),
                  _buildFeatureButton(context, 'Sleep', Icons.nights_stay,
                      FunctionType.FunctionTypeSleep),
                  _buildFeatureButton(context, 'Diet', Icons.restaurant_menu,
                      FunctionType.FunctionTypeDiet),
                  _buildFeatureButton(context, 'Wellness', Icons.spa,
                      FunctionType.FunctionTypeWellness),
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildFeatureButton(
      BuildContext context, String label, IconData icon, int functionType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Color.fromARGB(255, 247, 243, 243)),
        label: Text(label,
            style: TextStyle(color: Color.fromARGB(255, 247, 243, 243))),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => _pageRoute(functionType)),
          );
          // Handle navigation or feature activation
        },
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

  Widget _pageRoute(int functionType) {
    switch (functionType) {
      case FunctionType.FunctionTypeWater:
        return WaterIntakeScreen();
      case FunctionType.FunctionTypeSleep:
        return SleepTimeScreen();
      case FunctionType.FunctionTypeDiet:
        return DietIntakeScreen();
      default:
        return Container();
    }
  }
}
