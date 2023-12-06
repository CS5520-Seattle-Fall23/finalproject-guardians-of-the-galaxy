import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import '../account/accountInfoScreen.dart';

class WellnessReportScreen extends StatefulWidget {
  @override
  _WellnessReportScreenState createState() => _WellnessReportScreenState();
}

class _WellnessReportScreenState extends State<WellnessReportScreen> {
  final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final weightData = [60, 60.5, 59.8, 60.2, 60, 59.5, 60]; // Example data for weight
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
        title: Text('Wellness'),
        backgroundColor: Colors.pink[200], // Adjust the color to match your design
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 70, // Assuming 70 kg is the upper limit for the chart
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
              checkToShowHorizontalLine: (value) => value % 10 == 0,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.black12,
                strokeWidth: 1.0,
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: weightData.asMap().entries.map((entry) {
              return BarChartGroupData(
                x: entry.key,
                barRods: [
                  BarChartRodData(
                    y: entry.value.toDouble(),
                    colors: [Colors.orange, Colors.pink],
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      // Bottom navigation bar can be added here if needed
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}
