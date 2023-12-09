import 'package:cloud_firestore/cloud_firestore.dart';

class PeriodRecord {
  String id;
  int startDate;
  int endDate;

  PeriodRecord({
    required this.id,
    required this.startDate,
    required this.endDate,
  });

  factory PeriodRecord.fromDocument(DocumentSnapshot doc) {
    return PeriodRecord(
      id: doc.id,
      startDate: doc['startDate'] ?? 1,
      endDate: doc['endDate'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}