import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login/login.dart';
import '../index/index.dart';
import '../new/new.dart';

class LogoutModel extends ChangeNotifier{

  void transitionIndexPage(context) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        IndexPage(user: user)
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


  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignOut() async {
    await FirebaseAuth.instance.signOut();
    try
    {
      await _googleSignIn.signOut();
    }
    catch (e)
    {
      print(e);
    }
  }

  Future logout(context) async {
    await _handleSignOut();
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(
            builder: (context) => new Login()), (_) => false);
   notifyListeners();
  }
}