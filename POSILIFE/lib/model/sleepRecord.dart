import 'package:cloud_firestore/cloud_firestore.dart';

class SleepRecord {
  String id;
  int current;
  int goal;

  SleepRecord({
    required this.id,
    required this.current,
    required this.goal,
  });

  factory SleepRecord.fromDocument(DocumentSnapshot doc) {
    return SleepRecord(
      id: doc.id,
      current: doc['current'] ?? 0,
      goal: doc['goal'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': current,
      'goal': goal,
    };
  }
}