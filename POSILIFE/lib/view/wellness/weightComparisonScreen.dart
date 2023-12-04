import 'package:flutter/material.dart';

class WeightComparisonScreen extends StatefulWidget {
  @override
  _WeightComparisonScreenState createState() => _WeightComparisonScreenState();
}

class _WeightComparisonScreenState extends State<WeightComparisonScreen> {
  bool isKg = true; // State variable to track unit toggle for weight

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Last Record'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Current Weight',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.pink.shade200,
            child: Text(
              '51.0 Kg',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Container(
            color: Colors.pink.shade100,
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Weight',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '+0.7Kg',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'BMI',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '+0.3',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ibs',
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
                      // TODO: Implement unit conversion if needed
                    });
                  },
                  activeTrackColor: Colors.pink.shade200,
                  activeColor: Colors.pink,
                ),
                Text(
                  'Kg',
                  style: TextStyle(
                    fontSize: 16,
                    color: isKg ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // You can add the bottom navigation bar if needed
        ],
      ),
    );
  }
}
