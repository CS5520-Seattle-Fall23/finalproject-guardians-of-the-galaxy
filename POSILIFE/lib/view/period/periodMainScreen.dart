import 'package:complete/view/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../account/accountInfoScreen.dart';
import 'periodReminderScreen.dart';
import '../bottomNavigationBar.dart';
import 'periodSetScreen.dart';
import '../report/reportHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class PeriodCalendarPage extends StatefulWidget {
  @override
  _PeriodCalendarPageState createState() => _PeriodCalendarPageState();
}

class _PeriodCalendarPageState extends State<PeriodCalendarPage> {
  late Map<DateTime, List> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _periodStartDate;
  DateTime? _periodEndDate;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _selectedEvents = {};
    _fetchPeriodData();
  }

  void _fetchPeriodData() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String documentId = DateFormat('yyyy-MM').format(DateTime.now());

  DocumentReference periodRecordRef = FirebaseFirestore.instance
      .collection('Period')
      .doc(userId)
      .collection('periodRecord')
      .doc(documentId);

  DocumentSnapshot periodSnapshot = await periodRecordRef.get();

  if (periodSnapshot.exists) {
    setState(() {
      _periodStartDate = DateTime(_focusedDay.year, _focusedDay.month, periodSnapshot['startDate']);
      _periodEndDate = DateTime(_focusedDay.year, _focusedDay.month, periodSnapshot['endDate']);
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
                color: Color.fromARGB(255, 163, 158, 164),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.purple.shade100,
                shape: BoxShape.circle,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_periodStartDate != null && _periodEndDate != null) {
                  if (day.isAfter(_periodStartDate!.subtract(Duration(days: 1))) &&
                      day.isBefore(_periodEndDate!.add(Duration(days: 0)))) {
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:Colors.pink.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Text(day.day.toString()),
                    );
                  }
                }
                // Return null for days that should not be customized.
                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => PeriodSetScreen()));

            },
            child: Text('Set Current My Period'),
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

