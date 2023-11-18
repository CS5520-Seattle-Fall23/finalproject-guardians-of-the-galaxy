import 'package:flutter/material.dart';


class WeightRecordScreen extends StatefulWidget {
  @override
  _WeightRecordScreenState createState() => _WeightRecordScreenState();
}
class _WeightRecordScreenState extends State<WeightRecordScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Weight'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Record Weight:'),
            // TODO: Add weight recording logic here
            Text('kg'),
            ElevatedButton(
              onPressed: () {
                // TODO: Add logic to record the weight
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}