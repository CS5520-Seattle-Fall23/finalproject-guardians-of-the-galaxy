import 'package:complete/view/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../account/accountInfoScreen.dart';
import 'periodReminderScreen.dart';
import '../bottomNavigationBar.dart';
import 'periodTrendScreen.dart';
import '../report/reportHomeScreen.dart';

class PeriodCalendarPage extends StatefulWidget {
  @override
  _PeriodCalendarPageState createState() => _PeriodCalendarPageState();
}

class _PeriodCalendarPageState extends State<PeriodCalendarPage> {
  late Map<DateTime, List> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _selectedEvents = {};
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

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay; // Update the focused day
      _selectedEvents[selectedDay] = ['Your period.']; // Mark the selected day as in period
      // Here you can also handle the start and end date of the period
      // And send this data to your backend or Firebase storage
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Period Calendar'),
        backgroundColor: Colors.pink[300],
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return _selectedDay == day;
            },
            onDaySelected: _onDaySelected,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.pink.shade100,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.pink.shade100,
                shape: BoxShape.circle,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Press on the date to choose your period',
            ),
            subtitle: Text(
              _selectedDay != null
                  ? 'Your selected period date is ${_selectedDay.toString()}'
                  : 'No period data.',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement reminder setting logic

              // After setting the reminder, navigate to the reminder screen
              Navigator.push(context, MaterialPageRoute(builder: (context) => PeriodReminderScreen()));
            },
            child: Text('Remind me my upcoming period!'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[200],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to Period Trending Page
              Navigator.push(context, MaterialPageRoute(builder: (context) => PeriodTrendScreen()));

            },
            child: Text('My Period Trending'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[200],
            ),
          ),
          // ... Other UI elements or buttons
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}

