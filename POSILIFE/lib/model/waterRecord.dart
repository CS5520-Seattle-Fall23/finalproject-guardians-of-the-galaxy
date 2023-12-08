import 'package:cloud_firestore/cloud_firestore.dart';

class WaterRecord {
  String id;
  int current;
  int goal;
  String currentUnit;
  String goalUnit;

  WaterRecord({
    required this.id,
    required this.current,
    required this.goal,
    required this.currentUnit,
    required this.goalUnit,
  });

  factory WaterRecord.fromDocument(DocumentSnapshot doc) {
    return WaterRecord(
      id: doc.id,
      current: doc['Current'] ?? 0,
      goal: doc['Goal'] ?? 0,
      currentUnit: doc['currentUnit'] ?? 'ml',
      goalUnit: doc['goalUnit'] ?? 'ml',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Current': current,
      'Goal': goal,
      'currentUnit': currentUnit,
      'goalUnit': goalUnit,
    };
  }
}
