import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './new_model.dart';
import 'package:intl/intl.dart';
import '../drawer/drawer_model.dart';
import '../widget/widget.dart';

class NewPage extends StatelessWidget {
  final user;

  NewPage({Key key, this.user}) : super(key: key);

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
                        Navigator.pop(context);
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
        body: ChangeNotifierProvider<NewModel>(
          create: (_) => NewModel(),
          child: Consumer<NewModel>(
            builder: (context, model, child) {
              return SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //日付を選ぶ
                        Row(
                          children: <Widget>[
                            Text(
                              DateFormat('y/MM/dd')
                                  .format(model.defaultDate)
                                  .toString(), //ライブラリ使用
                              style: const TextStyle(
                                shadows: [
                                  const Shadow(
                                      color: Colors.black, offset: Offset(0, -5))
                                ],
                                color: Colors.transparent,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey,
                                decorationThickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 13,
                                bottom: 20,
                              ),
                              child: RaisedButton.icon(
                                icon: const Icon(Icons.date_range),
                                label: const Text(
                                  '日付変更',
                                ),
                                textColor: Colors.white,
                                color: const Color(0xfff57c00),
                                shape: const StadiumBorder(),
                                onPressed: () async {
                                  final selectedDate =
                                      await model.returnShowDatePicker(context);
                                  if (selectedDate != null) {
                                    model.trainingDate = selectedDate; //登録されるデータ
                                    model.setNewDateValue(
                                        selectedDate); //UIとして描写されるデータ
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                          value: model.dropdownValue,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 1.5,
                            color: Colors.grey,
                          ),
                          onChanged: (String newValue) {
                            model.setNewEventValue(newValue);
                            model.event = newValue;
                          },
                          items: model.eventArray
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "重量を記入してください",
                            hintText: 'Example：60',
                          ),
                          onChanged: (text) {
                            model.weight = text;
                          },
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "レップ数を記入してください",
                            hintText: 'Example：5',
                          ),
                          onChanged: (text) {
                            model.rep = text;
                          },
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "セット数を記入してください",
                            hintText: 'Example：5',
                          ),
                          onChanged: (text) {
                            model.set = text;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(
                            child: ButtonTheme(
                              minWidth: 20,
                              height: 45,
                              child: RaisedButton.icon(
                                shape: const StadiumBorder(),
                                color: const Color(0xfff57c00),
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                label: const Text('保存'),
                                textColor: Colors.white,
                                onPressed: () async {
                                  try {
                                    await model.addNewTrainingRecord();
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return successDialog(model, context);
                                      },
                                    );
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return errorDialog(model, context, e);
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}
