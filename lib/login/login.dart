import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import './login_model.dart';
import 'package:intl/intl.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
        create: (_) => LoginModel(),
        child: SafeArea(
          child: Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.topRight,
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
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          'Memo',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 20.0),
                    child: Row(
                      children:[
                        const Text(
                          'your training.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    height: MediaQuery.of(context).size.height - 185.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(130.0)),
                    ),
                    child: ListView(
                      primary: false,
                      // padding: EdgeInsets.only(top: 70.0, left: 25.0, right: 20.0),
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              child: const Text(
                                'Example',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ) ,
                          ],
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: const Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
                          ),
                          child: ListTile(
                            leading: Text(
                                DateFormat('MM/dd').
                                format(
                                    DateTime.now()
                                ).toString()//ライブラリ使用
                            ),
                            title: const Text('ベンチプレス'),
                            subtitle: const Text(
                                "weight:100,rep:5,set:5"
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: (){},
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
                          ),
                          child: ListTile(
                            leading: Text(
                                DateFormat('MM/dd').
                                format(
                                    DateTime.now()
                                ).toString()//ライブラリ使用
                            ),
                            title: const Text('チンニング'),
                            subtitle: const Text(
                                "weight:70,rep:10,set:5"
                            ),
                            trailing:  IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: (){},
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //ここだけ状態を持たせる
                                Consumer<LoginModel>(
                                    builder: (context, model, child) {
                                      return RaisedButton.icon(
                                        shape: const StadiumBorder(),
                                        icon: const Icon(
                                          Icons.login_sharp,
                                          color: Colors.white,
                                        ),
                                        label: const Text('Sign in with Google'),
                                        color: const Color(0xfff57c00),
                                        textColor: Colors.white,
                                        onPressed: () {
                                          model.login(context);
                                        },
                                      );
                                    })
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
