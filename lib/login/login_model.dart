import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_memo/index/index.dart';

class LoginModel extends ChangeNotifier {

  void transitionIndexPage(context,FirebaseUser user) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        IndexPage(user: user)
    ));
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //googleSignIn
  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleCurrentUser = _googleSignIn.currentUser;
    try {
      if (googleCurrentUser == null) googleCurrentUser = await _googleSignIn.signInSilently();
      if (googleCurrentUser == null) googleCurrentUser = await _googleSignIn.signIn();
      if (googleCurrentUser == null) return null;

      GoogleSignInAuthentication googleAuth = await googleCurrentUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future setUserData(user) async {
    await Firestore.instance.collection('users').document().setData(
        {
          'uid': user.uid,
          'name': user.displayName,
          'email': user.email,
        }
    );
  }

  Future login(context) async {
     final user = await _handleSignIn();
     if(user == null) return;
     String userUid;

     try
     {
       //userテーブルの行を全て取得
       QuerySnapshot snapshot = await Firestore.instance.collection('users').getDocuments();

       for(var i = 0; i < snapshot.documents.length; i++)
       {
         userUid = snapshot.documents[i].data['uid'];
         if(userUid == user.uid)//一致してたら終わり
         {
           break;
         }
         if(i < snapshot.documents.length-1)//最終データまでのデータは飛ばす
         {
           continue;
         }

         //最終データでも、一致するユーザーがいない場合、usersテーブルに追加
         setUserData(user);
       }
       print('正常にログインとユーザー保存が実行されました！！');
     }
     catch(e)
     {
       print(e);
       print('データベースに保存できませんでした。');
     }
     transitionIndexPage(context,user);
     notifyListeners();
  }
}