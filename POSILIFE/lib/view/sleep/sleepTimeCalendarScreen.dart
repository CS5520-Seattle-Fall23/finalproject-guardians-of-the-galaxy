import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SleepTimeCalendarScreen extends StatefulWidget {
  @override
  _SleepTimeCalendarScreenState createState() => _SleepTimeCalendarScreenState();
}

class _SleepTimeCalendarScreenState extends State<SleepTimeCalendarScreen> {
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
      'text': 'Sleep Time Goal Completed!',
      'icon': Icons.check_circle_outline,
      'color': Colors.green,
    },
    {
      'text': 'Sleep Time Goal Incompleted!',
      'icon': Icons.error_outline,
      'color': Colors.red,
    },
    {
      'text': 'Sleep Time was not recorded!',
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
  void _initializeEvents() {
    // Initialize your events and day colors here.
    // For the purpose of the example, we are initializing the colors and events statically.
    DateTime today = DateTime.utc(2023, 12, 4); // Today's date
    _events[today] = ['Sleep Time Goal Completed!'];
    _dayColor[today] = Colors.pink; // Pink background for completed goals
    // ... Initialize other dates as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My SleepTime Calendar"),
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
        return Icons.calendar_view_day;
      case 1:
        return Icons.calendar_month;
      case 2:
        return Icons.bar_chart;
      case 3:
        return Icons.account_box;
      default:
        return Icons.error;
    }
  }
}


