import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_memo/timer/timer.dart';
import '../stop_watch/stop_watch.dart';
import '../logout/logout.dart';
import '../new/new.dart';
import '../index/index.dart';

class DrawerModel extends ChangeNotifier{
  //drawerに必要なトランジション関数

  void transitionLogout(context) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        Logout(user: user)
    ));
    notifyListeners();
  }

  void transitionNewPage(context) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        NewPage(user: user)
    ));
    notifyListeners();
  }

  void transitionIndexPage(context) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        IndexPage(user: user)
    ));
    notifyListeners();
  }

  void transitionStopWatch(context) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        StopWatch(user: user)
    ));
    notifyListeners();
  }

  void transitionTimerPage(context) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        TimerPage(user: user)
    ));
    notifyListeners();
  }

}