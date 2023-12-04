import 'package:flutter/material.dart';

class DietIntakeRecordScreen extends StatefulWidget {
  @override
  _DietIntakeRecordScreenState createState() => _DietIntakeRecordScreenState();
}
class _DietIntakeRecordScreenState extends State<DietIntakeRecordScreen> {
  final TextEditingController _calorieAmountController = TextEditingController();
  bool isKcal = false; // State variable to track unit toggle
  int _selectedIndex = 0;
  @override
  void dispose() {
    _calorieAmountController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/calorieIntakeScreen');
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
  void _confirmCalorieIntake() {
    // Logic to confirm calorie intake goes here
    // Convert to Kcal if necessary and send to backend or local storage
    int calorieIntake = int.parse(_calorieAmountController.text);
    if (isKcal) {
      // Convert to kj if needed
      calorieIntake = (calorieIntake * 4.184).round(); // 1kcal = 4.184kj
    }
    print('calorie Intake: $calorieIntake KJ'); // Replace with actual logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's calorie Intake"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add calorie:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _calorieAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                filled: true,
                fillColor: Colors.pink[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixText: isKcal ? 'Kcal' : 'KJ',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _confirmCalorieIntake,
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50), // specify the height of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'KJ',
                  style: TextStyle(
                    fontSize: 16,
                    color: isKcal ? Colors.grey : Colors.black,
                  ),
                ),
                Switch(
                  value: isKcal,
                  onChanged: (value) {
                    setState(() {
                      isKcal = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
                Text(
                  'Kcal',
                  style: TextStyle(
                    fontSize: 16,
                    color: isKcal ? Colors.black : Colors.grey,
                  ),
                ),
              ],
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