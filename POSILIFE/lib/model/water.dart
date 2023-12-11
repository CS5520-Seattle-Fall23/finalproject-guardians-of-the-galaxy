import 'package:cloud_firestore/cloud_firestore.dart';
import 'waterRecord.dart';

class Water {
  String userId;
  List<WaterRecord> records;

  Water({
    required this.userId,
    required this.records,
  });

  // This method assumes you have fetched the entire waterRecord subcollection
  // for a given user and passed the QuerySnapshot to it.
  factory Water.fromSnapshot(QuerySnapshot snapshot) {
    List<WaterRecord> records = snapshot.docs
        .map((doc) => WaterRecord.fromDocument(doc))
        .toList();
    
    return Water(
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