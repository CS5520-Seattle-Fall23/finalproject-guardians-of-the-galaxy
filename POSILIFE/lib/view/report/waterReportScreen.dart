import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import '../account/accountInfoScreen.dart';


class WaterReportScreen extends StatefulWidget {
  @override
  _WaterReportScreenState createState() => _WaterReportScreenState();
}

class _WaterReportScreenState extends State<WaterReportScreen> {
  final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final waterIntakeData = [1600, 1400, 1800, 1900, 1500, 1700, 1800]; // Example data
  int _selectedIndex = 2; // Assumed you have a bottom navigation with index

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
        title: Text('Water', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink[200],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 2000,
                barTouchData: BarTouchData(
                  enabled: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(color: Colors.black, fontSize: 14),
                    margin: 16,
                    getTitles: (double value) {
                      return weekDays[value.toInt()];
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(color: Colors.black, fontSize: 14),
                    margin: 32,
                    reservedSize: 14,
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 500 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.black12,
                    strokeWidth: 1.0,
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: waterIntakeData.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        y: entry.value.toDouble(),
                        colors: [Colors.lightBlueAccent, Colors.greenAccent],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          // Your other widgets go here
        ],
      ),
      // Bottom navigation bar can be added here if needed
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}
