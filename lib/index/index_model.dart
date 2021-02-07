
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_memo/trainning_record/training_record.dart';

class IndexModel extends ChangeNotifier{


List<TrainingRecord> trainingRecordArray =[];

   Future fetchTrainingRecord() async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final document = await Firestore.instance.collection('posts')
        .where("uid", isEqualTo: user.uid)
        .orderBy('trainingDate',descending: true)
        .limit(100)
        .getDocuments();

    final trainingRecord = document.documents.map((docs) =>
          TrainingRecord(
          docs.documentID,
          docs['uid'],
          docs['trainingDate'],
          docs['event'],
          docs['rep'],
          docs['set'],
          docs['weight']
      )).toList();
    this.trainingRecordArray = trainingRecord;
    return this.trainingRecordArray;
  }

  Future deleteTrainingRecord(documentID) async{
    await Firestore.instance.collection('posts').document(documentID).delete();
    notifyListeners();
  }

}
