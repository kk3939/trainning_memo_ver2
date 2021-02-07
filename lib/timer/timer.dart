import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/widget.dart';
import '../drawer/drawer_model.dart';
import '../timer/timer_model.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerPage extends StatelessWidget{
  final user;
  TimerPage({Key key, this.user}) : super(key: key);

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
                      Navigator.pop(context);
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
            child: ChangeNotifierProvider<TimerModel>(
              create: (_) => TimerModel(),
              child: Consumer<TimerModel>(
                builder: (context, model, child) {
                  return Column(
                    children: [
                      const SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('HH'),
                              NumberPicker.integer(
                                  initialValue: model.hour,
                                  minValue: 0,
                                  maxValue: 23,
                                  onChanged: (val){
                                    model.changeHourVal(val);
                                  }
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             const Text('MM'),
                              NumberPicker.integer(
                                  initialValue: model.minute,
                                  minValue: 0,
                                  maxValue: 59,
                                  onChanged: (val){
                                    model.changeMinuteVal(val);
                                  }
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('SS'),
                              NumberPicker.integer(
                                  initialValue: model.second,
                                  minValue: 0,
                                  maxValue: 59,
                                  onChanged: (val){
                                    model.changeSecondVal(val);
                                  }
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 50.0),
                      Container(
                        child: Center(
                          child: Text(
                            model.timeToDisplay,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            color: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 10.0,
                            ),
                            child: Text(
                              'Start',
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onPressed: model.started ? model.start : null,
                          ),
                          RaisedButton(
                            color: Colors.redAccent,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 10.0,
                            ),
                            child: Text(
                              'Stop',
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            onPressed: model.stopped ? model.stop : null,
                          )
                        ],
                      ),
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