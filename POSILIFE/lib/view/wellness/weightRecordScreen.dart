import 'package:flutter/material.dart';


class WeightRecordScreen extends StatefulWidget {
  @override
  _WeightRecordScreenState createState() => _WeightRecordScreenState();
}
class _WeightRecordScreenState extends State<WeightRecordScreen> {
  int _selectedIndex = 0;
  final TextEditingController _weightAmountController = TextEditingController();
  bool isKg = false; // State variable to track unit toggle
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/weightScreen');
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
  void _confirmweight() {
    // Logic to confirm weightt goes here
    // Convert to Kg if necessary and send to backend or local storage
    int weight = int.parse(_weightAmountController.text);
    if (isKg) {
      // Convert to kg if needed
      weight = (weight * 0.453592).round(); // 1lbs = 0.453592kg
    }
    print('weight: $weight kg'); // Replace with actual logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's weight"),
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
              'Add weight:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _weightAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                filled: true,
                fillColor: Colors.pink[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixText: isKg ? 'lbs' : 'kg',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _confirmweight,
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
                  'kg',
                  style: TextStyle(
                    fontSize: 16,
                    color: isKg ? Colors.grey : Colors.black,
                  ),
                ),
                Switch(
                  value: isKg,
                  onChanged: (value) {
                    setState(() {
                      isKg = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
                Text(
                  'lbs',
                  style: TextStyle(
                    fontSize: 16,
                    color: isKg ? Colors.black : Colors.grey,
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