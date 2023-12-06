import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../account/accountInfoScreen.dart';
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';

class DietIntakeCalendarScreen extends StatefulWidget {
  @override
  _DietIntakeCalendarScreenState createState() => _DietIntakeCalendarScreenState();
}

class _DietIntakeCalendarScreenState extends State<DietIntakeCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List> _events = {};
  Map<DateTime, Color> _dayColor = {};

  @override
  void initState() {
    super.initState();
    _initializeEvents();
  }
  final List<Map<String, dynamic>> _annotations = [
    {
      'text': 'Diet Intake Goal Completed!',
      'icon': Icons.check_circle_outline,
      'color': Colors.green,
    },
    {
      'text': 'Diet Intake Goal Incompleted!',
      'icon': Icons.error_outline,
      'color': Colors.red,
    },
    {
      'text': 'Diet Intake was not recorded!',
      'icon': Icons.info_outline,
      'color': Colors.grey,
    },
  ];

  int _selectedIndex = 0; // For bottom navigation bar
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
  void _initializeEvents() {
    // Initialize your events and day colors here.
    // For the purpose of the example, we are initializing the colors and events statically.
    DateTime today = DateTime.utc(2023, 12, 4); // Today's date
    _events[today] = ['Diet Intake Goal Completed!'];
    _dayColor[today] = Colors.pink; // Pink background for completed goals
    // ... Initialize other dates as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Diet Calendar"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: (day) => _events[day] ?? [],
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarFormat: CalendarFormat.month,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              // Define the styling here
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              todayDecoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.pink[300],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              markerDecoration: BoxDecoration(
                color: Colors.brown,
                shape: BoxShape.circle,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _dayColor[date] ?? Colors.transparent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(fontSize: 16.0),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _annotations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    _annotations[index]['icon'],
                    color: _annotations[index]['color'],
                  ),
                  title: Text(_annotations[index]['text']),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}

