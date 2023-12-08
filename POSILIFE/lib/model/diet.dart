import 'package:cloud_firestore/cloud_firestore.dart';
import 'dietRecord.dart';


class Diet {
  String userId;
  List<DietRecord> records;

  Diet({
    required this.userId,
    required this.records,       
  });

  // This method assumes you have fetched the entire dietRecord subcollection
  // for a given user and passed the QuerySnapshot to it.
  factory Diet.fromSnapshot(QuerySnapshot snapshot) {
    List<DietRecord> records = snapshot.docs
        .map((doc) => DietRecord.fromDocument(doc))
        .toList();
    
    return Diet(
      userId: snapshot.docs.first.reference.parent.parent!.id, // Get the user ID from the document reference
      records: records,
    );
  }

  // Convert the entire object to JSON.
  // Note that this might not be directly usable for Firestore updates/sets
  // because Firestore does not support nested arrays in a single document.
  // You will likely need to iterate over the records and update them individually.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'records': records.map((record) => record.toJson()).toList(),
    };
  }
}