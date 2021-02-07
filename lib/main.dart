import 'package:flutter/material.dart';
import 'login/login.dart';

//メイン
void main() {
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //アプリ設定
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        brightness: Brightness.light,
        primaryColor: Colors.redAccent,
        accentColor: Colors.redAccent,
      ),
      debugShowCheckedModeBanner: false,//デバッグマークの削除
      home: new Login(),
    );
  }
}
