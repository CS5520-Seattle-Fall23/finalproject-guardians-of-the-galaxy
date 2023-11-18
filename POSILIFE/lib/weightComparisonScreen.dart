import 'package:flutter/material.dart';

class WeightComparisonScreen extends StatelessWidget {
  // Example data, replace with actual data from backend
  final double lastWeight = 50.8;
  final double currentWeight = 51.0;
  final double bmiDifference = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Last Record'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Current Weight'),
            Text('${currentWeight.toStringAsFixed(1)} Kg'),
            // TODO: Add weight comparison logic here
            Text('Compare to last record:'),
            Text('Weight: +${(currentWeight - lastWeight).toStringAsFixed(1)} Kg'),
            Text('BMI: +${bmiDifference.toStringAsFixed(1)}'),
          ],
        ),
      ),
    );
  }
}
