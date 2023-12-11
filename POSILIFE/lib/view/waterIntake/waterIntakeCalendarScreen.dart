import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../account/accountInfoScreen.dart';
import '../bottomNavigationBar.dart';
import '../homeScreen.dart';
import '../period/periodMainScreen.dart';
import '../report/reportHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class WaterIntakeCalendarScreen extends StatefulWidget {
  @override
  _WaterIntakeCalendarScreenState createState() => _WaterIntakeCalendarScreenState();
}

class _WaterIntakeCalendarScreenState extends State<WaterIntakeCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List> _events = {};
  Map<DateTime, Color> _dayColor = {};
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchWaterRecords();
  }
  String _getWaterIntakeStatusForDate(DateTime date) {
  List events = _events[date] ?? [];
  if (events.isNotEmpty) {
    return 'On ${_formatDate(date)}, Your Water Intake Goal has ${events[0].toLowerCase()}.';
  }
  return 'On ${_formatDate(date)}, Your Water Intake was not recorded.';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
  void _fetchWaterRecords() async {
  // Ensure the user is logged in
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print("No user logged in!");
    return;
  }
  String userId = user.uid;

  try {
    // Fetch water records from Firestore
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Water')
        .doc(userId)
        .collection('waterRecord')
        .get();

    // Convert documents into events and colors
    Map<DateTime, List> events = {};
    Map<DateTime, Color> dayColor = {};

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // Use a try-catch to handle any parsing issues
      try {
        DateTime date = DateTime.parse(doc.id);
        bool isComplete = data['Current'] >= data['Goal'];
        events[date] = [isComplete ? 'Goal Completed' : 'Goal Not Completed'];
        dayColor[date] = isComplete ? Colors.green : Colors.red;
      } catch (e) {
        print('Error parsing date or data for document ${doc.id}: $e');
      }
    }

    // Update the state with the new events and colors
    setState(() {
      _events = events;
      _dayColor = dayColor;
    });
  } catch (e) {
    print('Error fetching water records: $e');
  }
}

  final List<Map<String, dynamic>> _annotations = [
    {
      'text': 'Water Intake Goal Completed!',
      'icon': Icons.check_circle_outline,
      'color': Colors.green,
    },
    {
      'text': 'Water Intake Goal Incompleted!',
      'icon': Icons.error_outline,
      'color': Colors.red,
    },
    {
      'text': 'Water Intake was not recorded!',
      'icon': Icons.info_outline,
      'color': Colors.grey,
    },
  ];

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
      title: Text("My Water Calendar"),
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
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, date, _) {
              bool isSelected = isSameDay(_selectedDay, date);
              bool isToday = isSameDay(DateTime.now(), date);
              bool isGoalCompleted = _events[date]?.contains('Goal Completed') ?? false;
              bool isGoalNotCompleted = _events[date]?.contains('Goal Not Completed') ?? false;
              
              BoxDecoration boxDecoration;
              if (isSelected) {
                boxDecoration = BoxDecoration(
                  color: Colors.pink[300],
                  shape: BoxShape.circle,
                );
              } else if (isGoalCompleted) {
                boxDecoration = BoxDecoration(
                  border: Border.all(color: Colors.green, width: 10),
                  shape: BoxShape.circle,
                );
              } else if (isGoalNotCompleted) {
                boxDecoration = BoxDecoration(
                  border: Border.all(color: Colors.red, width: 10),
                  shape: BoxShape.circle,
                );
              } else {
                boxDecoration = BoxDecoration(
                  shape: BoxShape.circle,
                );
              }

              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: boxDecoration,
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(fontSize: 16.0),
                ),
              );
            },
            todayBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSameDay(_selectedDay, date) ? Colors.pink[300] : Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(fontSize: 16.0, color: Colors.white),
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
      // This could be a SnackBar or a Text widget that changes based on the selected date's data
    bottomSheet: Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(10),
      child: Text(
        _getWaterIntakeStatusForDate(_selectedDay),
        textAlign: TextAlign.center,
      ),
    ),
      bottomNavigationBar: CustomBottomNavigationBar(
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
     ),
    );
  }
}


