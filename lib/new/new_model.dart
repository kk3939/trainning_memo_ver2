import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../index/index.dart';

class NewModel extends ChangeNotifier{

  //現状ダイアログからの画面遷移が必要になるため、関数記載
  void transitionIndexPage(context) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        IndexPage(user: user)
    ));
    notifyListeners();
  }

  returnShowDatePicker(context)  {
    final date = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    return date;
  }


  String dropdownValue = '種目選択';
  List<String> eventArray = [
    '種目選択',
    'ベンチプレス',
    'インクラインベンチ',
    'ダンベルフライ',
    'ケーブルフライ',
    'スクワット',
    'レッグカール',
    'レッグエクステンション',
    'デッドリフト',
    'ショルダーシュレッグ',
    'チンニング',
    'ロー',
    'ショルダープレス',
    'サイドレイズ',
    'アブドミナル',
  ];

  void setNewEventValue(newValue){
    dropdownValue = newValue;
    notifyListeners();
  }

  //初期値今日
  DateTime defaultDate = DateTime.now();//テキストで表示用

  void setNewDateValue(newValue){
    defaultDate = newValue;
    notifyListeners();
  }

  //初期値今日
  DateTime trainingDate =  DateTime.now();
  String event = '';
  String rep = '';
  String set  = '';
  String weight = '';


  Future addNewTrainingRecord() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user == null) return;

    //初期値の際にエラー投げる
    if(event.isEmpty || event == '選択してください！'){
      throw ('種目が未記入です！！');
    }
    if(weight.isEmpty){
      throw ('重量が未記入です！！');
    }
    if(rep.isEmpty){
      throw ('repが未記入です！！');
    }
    if(set.isEmpty){
      throw ('setが未記入です！！');
    }

    await Firestore.instance.collection('posts').document().setData({
      'uid': user.uid,
      "trainingDate": trainingDate,
      "event": event,
      "weight": weight,
      "rep": rep,
      "set": set,
        });
    print('正常に追加しました');
    notifyListeners();
  }

}