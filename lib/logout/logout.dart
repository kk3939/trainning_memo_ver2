import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'logout_model.dart';
import '../widget/widget.dart';
import '../drawer/drawer_model.dart';

class Logout extends StatelessWidget {
  final FirebaseUser user;

  Logout({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: graAppBar(),
      drawer: ChangeNotifierProvider<DrawerModel>(
          create: (_) => DrawerModel(),
          child: Consumer<DrawerModel>(builder: (context, model, child) {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  drawerHeader(user),
                  ListTile(
                    leading: const Icon(
                      Icons.notes,
                      color: Colors.black54,
                    ),
                    title: const Text('筋トレログ一覧'),
                    onTap: () {
                      model.transitionIndexPage(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.message,
                      color: Colors.black54,
                    ),
                    title: const Text('ログ追加'),
                    onTap: () {
                      model.transitionNewPage(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.access_time,
                      color: Colors.black54,
                    ),
                    title: const Text('ストップウォッチ'),
                    onTap: () {
                      model.transitionStopWatch(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.access_alarm,
                      color: Colors.black54,
                    ),
                    title: const Text('タイマー'),
                    onTap: () {
                      model.transitionTimerPage(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.black54,
                    ),
                    title: const Text('サインアウト'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.close,
                      color: Colors.black54,
                    ),
                    title: const Text('閉じる'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          })),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:  const EdgeInsets.only(
              top: 100,
              left: 30,
              right: 30,
              bottom: 30
            ),
            child: ChangeNotifierProvider<LogoutModel>(
                create: (_) => LogoutModel(),
                child: Consumer<LogoutModel>(builder: (context, model, child) {
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          displayUserImage(user),
                          displayUserInfo(user),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
                            child: RaisedButton.icon(
                              shape: const StadiumBorder(),
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              label: const Text('Sign out with Google'),
                              color: const Color(0xfff57c00),
                              textColor: Colors.white,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      content: const Text("ログアウトしますか？"),
                                      actions: <Widget>[
                                        // ボタン領域
                                        FlatButton(
                                            child: const Text('戻る'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        FlatButton(
                                            child: const Text('ログアウト'),
                                            onPressed: () {
                                              model.logout(context);
                                            }),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ]),
                  );
                })),
          ),
        ),
      ),
    );
  }
}
