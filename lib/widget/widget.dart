
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

//グラデーションappBar
Widget graAppBar() {
  return GradientAppBar(
    title: const Text(
      'Memo your training.',
      textAlign: TextAlign.center,
    ),
    backgroundColorStart: const Color(0xffd50000),
    backgroundColorEnd: const Color(0xfff57c00),
  );
}

//drawerのユーザー情報が記載されるヘッダー
Widget drawerHeader(FirebaseUser user) {
  return UserAccountsDrawerHeader(
    accountName: Text(user.displayName),
    accountEmail: Text(user.email),
    currentAccountPicture: CircleAvatar(
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage(user.photoUrl),
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomRight,
        colors: [
          const Color(0xffd50000).withOpacity(1),
          const Color(0xfff57c00).withOpacity(0.9),
        ],
        stops: const [
          0.0,
          1.0,
        ],
      ),
    ),
  );
}


Widget loadingMark(){
  return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
        ],
      )
  );
}

Widget displayNoContents(){
  return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("データが存在しません"),
        ],
      )
  );
}

Widget displayUserImage(FirebaseUser user) {
  return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.fill,
              image:  NetworkImage(user.photoUrl)
          )
      )
  );
}

Widget displayUserInfo(FirebaseUser user) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 20,
    ),
    child: Column(
      children: <Widget>[
        Text(
          user.displayName,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        Text(
          user.email,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}

Widget successDialog(model, context){
  return AlertDialog(
        content: const Text("保存されました！"),
        actions: <Widget>[
          // ボタン領域
          FlatButton(
              child: const Text('戻る'),
              onPressed: () {
                model.transitionIndexPage(context);
              }
          ),
        ],
  );
}

Widget errorDialog(model, context, e){
  return AlertDialog(
    //エラーメッセージをダイアログとして出力
    content: Text(e.toString()),
    actions: <Widget>[
      // ボタン領域
      FlatButton(
          child: const Text('戻る'),
          onPressed: () {
            Navigator.pop(context);
          }
      ),
    ],
  );
}

