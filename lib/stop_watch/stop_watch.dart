import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/widget.dart';
import '../drawer/drawer_model.dart';
import '../stop_watch/stop_watch_model.dart';

class StopWatch extends StatelessWidget {
  final user;
  StopWatch({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: graAppBar(),
      drawer: ChangeNotifierProvider<DrawerModel>(
        create: (_) => DrawerModel(),
        child: Consumer<DrawerModel>(
          builder: (context, model, child) {
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
                      Navigator.pop(context);
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
                      model.transitionLogout(context);
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
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: ChangeNotifierProvider<StopWatchModel>(
              create: (_) => StopWatchModel(),
              child: Consumer<StopWatchModel>(
                builder: (context, model, child) {
                  return Column(
                    children: [
                      const SizedBox(height: 100.0),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          model.stopWatchTimeDisplay,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      RaisedButton(
                        color: Colors.redAccent,
                        child: const Text('STOP'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: model.isStopPressed ? null : model.stopStopWatch,
                      ),
                      const SizedBox(height: 10.0),
                      RaisedButton(
                        color: Colors.green,
                        child: const Text('RESET'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: model.isResetPressed ? null : model.resetStopWatch,
                      ),
                      const SizedBox(height: 10.0),
                      RaisedButton(
                        color: Colors.orange,
                        child: const Text('START'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        onPressed: model.isStartPressed ? model.startStopWatch : null,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
