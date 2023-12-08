import 'package:cloud_firestore/cloud_firestore.dart';

class DietRecord {
  String id;
  int current;
  int goal;
  String currentUnit;
  String goalUnit;

  DietRecord({
    required this.id,
    required this.current,
    required this.goal,
    required this.currentUnit,
    required this.goalUnit,
  });

  factory DietRecord.fromDocument(DocumentSnapshot doc) {
    return DietRecord(
      id: doc.id,
      current: doc['current'] ?? 0,
      goal: doc['goal'] ?? 0,
      currentUnit: doc['currentUnit'] ?? 'kcal',
      goalUnit: doc['goalUnit'] ?? 'kcal',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': current,
      'goal': goal,
      'currentUnit': currentUnit,
      'goalUnit': goalUnit,
    };
  }
}