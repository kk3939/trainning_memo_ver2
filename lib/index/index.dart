import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './index_model.dart';
import '../drawer/drawer_model.dart';
import 'package:intl/intl.dart';
import '../widget/widget.dart';

class IndexPage extends StatelessWidget {
  final user;
  IndexPage({Key key, this.user}) : super(key: key);

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
                    Navigator.pop(context);
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
                  title: Text('サインアウト'),
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
        }),
      ),
      body: ChangeNotifierProvider<IndexModel>(
        create: (_) => IndexModel(),
        child: Consumer<IndexModel>(builder: (context, model, child) {
          return FutureBuilder(
              future: model.fetchTrainingRecord(),
              builder: (context, snapshot) {
                //===============================================================
                //ローディングしているときのUI
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingMark();
                }
                //===============================================================

                //===============================================================
                //データが存在しないとき
                if (model.trainingRecordArray.length == 0) {
                  return displayNoContents();
                }
                //===============================================================

                //===============================================================
                //正常処理
                final trainingRecords = model.trainingRecordArray;
                final listTiles = trainingRecords.map(
                      (record) => Container(
                        decoration: const BoxDecoration(
                            border: const Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey))),
                        child: ListTile(
                          leading: Text(DateFormat('MM/dd')
                                  .format(record.trainingDate.toDate())
                                  .toString() //ライブラリ使用
                              ),
                          title: Text(record.event),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              model.deleteTrainingRecord(record.documentId);
                            },
                          ),
                          subtitle: Text(
                              "weight:${record.weight},rep:${record.rep},set:${record.set}"),
                        ),
                      ),
                    )
                    .toList();
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: ListView(
                    children: listTiles,
                  ),
                );
                //===============================================================
              });
        }),
      ),
    );
  }
}
