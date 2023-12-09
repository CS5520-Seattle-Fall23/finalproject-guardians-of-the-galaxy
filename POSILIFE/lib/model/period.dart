
import 'package:cloud_firestore/cloud_firestore.dart';
import 'periodRecord.dart';

class Period {
  String userId;
  Map<String, PeriodRecord> records;

  Period({
    required this.userId,
    required this.records,
  });

  // This method assumes you have fetched the periodRecord subcollection for a given user.
  factory Period.fromSnapshot(QuerySnapshot snapshot) {
    var records = <String, PeriodRecord>{};
    for (var doc in snapshot.docs) {
      records[doc.id] = PeriodRecord.fromDocument(doc);
    }

    return Period(
      userId: snapshot.docs.first.reference.parent.parent!.id, // Get the user ID from the document reference
      records: records,
    );
  }

  // Convert the entire object to JSON.
  // This structure assumes you will be updating records individually.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'records': records.map((id, record) => MapEntry(id, record.toJson())),
    };
  }
}