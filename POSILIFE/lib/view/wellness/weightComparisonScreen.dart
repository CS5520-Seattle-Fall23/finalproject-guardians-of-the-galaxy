import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeightComparisonScreen extends StatefulWidget {
  @override
  _WeightComparisonScreenState createState() => _WeightComparisonScreenState();
}

class _WeightComparisonScreenState extends State<WeightComparisonScreen> {
  double currentWeight = 0.0;
  double lastWeight = 0.0;
  double height = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

void _fetchUserData() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  try {
    DocumentSnapshot wellnessDoc = await FirebaseFirestore.instance.collection('Wellness').doc(userId).get();
    if (wellnessDoc.exists) {
      Map<String, dynamic> wellnessData = wellnessDoc.data() as Map<String, dynamic>;
      setState(() {
        currentWeight = _toDouble(wellnessData['Weight']);
        lastWeight = _toDouble(wellnessData['lastWeight']);
        height = _toDouble(wellnessData['Height']);
      });
    }
  } catch (e) {
    print('Error fetching user data: $e');
  }
}

double _toDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is String) {
    return double.tryParse(value) ?? 0.0;
  } else {
    return value ?? 0.0;
  }
}


  double calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }

  @override
  Widget build(BuildContext context) {
    double weightDifference = currentWeight - lastWeight;
    double currentBMI = calculateBMI(currentWeight, height);
    double lastBMI = calculateBMI(lastWeight, height);
    double bmiDifference = currentBMI - lastBMI;

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
              '${currentWeight.toStringAsFixed(1)} ${'Kg'}',
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
                     '${weightDifference >= 0 ? '+' : ''}${weightDifference.toStringAsFixed(1)} Kg',
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
                     '${bmiDifference >= 0 ? '+' : ''}${bmiDifference.toStringAsFixed(1)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Remove the unit toggle switch as the unit conversion feature is not implemented
          // You can add the bottom navigation bar if needed
        ],
      ),
    );
  }
}

