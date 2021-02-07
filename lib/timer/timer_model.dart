import 'dart:async';
import 'package:flutter/material.dart';


class TimerModel extends ChangeNotifier {
  int hour = 0;
  int minute = 0;
  int second = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  String timeToDisplay = '';
  bool checkTimer = true;

  changeHourVal(val){
    this.hour = val;
    notifyListeners();
  }

  changeMinuteVal(val){
    this.minute = val;
    notifyListeners();
  }

  changeSecondVal(val){
    this.second = val;
    notifyListeners();
  }


  void start() {
    started = false;
    stopped = true;
    notifyListeners();//先にボタンのアクティブを操作するため

    this.timeForTimer = ( (this.hour * 60 * 60) + (this.minute * 60) + this.second );
    Timer.periodic(
      Duration(
      seconds: 1,
      ), (Timer t){
        if(this.timeForTimer < 1 || this.checkTimer == false){
          t.cancel();
          this.checkTimer = true;
          this.timeToDisplay = '';
          stopped = false;
          started = true;
        } else if(this.timeForTimer < 60){
          this.timeToDisplay = this.timeForTimer.toString();
          this.timeForTimer = this.timeForTimer-1;
        } else if(this.timeForTimer < 3600) {
          int m = this.timeForTimer ~/ 60;
          int s = this.timeForTimer - (60 * m);
          this.timeToDisplay = m.toString() + ':' + s.toString();
          this.timeForTimer = this.timeForTimer -1;
        } else{
          int h = this.timeForTimer ~/ 3600;
          int t = this.timeForTimer - (3600 * h);
          int m = t ~/ 60;
          int s = t -(60 * m);
          this.timeToDisplay =
              h.toString() +':'+ m.toString() +':'+ s.toString();
          this.timeForTimer = this.timeForTimer -1;
        }
        notifyListeners();//表示される文字を1秒ごとに変換させるため
      });
  }

  void stop(){
    started = true;
    stopped = false;
    checkTimer = false;
  }

}