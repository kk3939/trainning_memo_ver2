import 'package:cloud_firestore/cloud_firestore.dart';

//設計図
class TrainingRecord {
  TrainingRecord(
      this.documentId,
      this.uid,
      this.trainingDate,
      this.event,
      this.rep,
      this.set,
      this.weight,
      );
  String documentId;
  String uid;
  Timestamp trainingDate;
  String event;
  String rep;
  String set;
  String weight;
}