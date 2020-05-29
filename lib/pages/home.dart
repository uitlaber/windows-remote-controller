import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../stores/command.dart';

import 'dart:convert' show utf8;


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State {
  double currentVolume = 0.0;
  SharedPreferences prefs;

 loadData() async {
   prefs = await SharedPreferences.getInstance();
   currentVolume = prefs.get('currentVolume') ?? 0.0;
 }

  @override
  Widget build(BuildContext context) {
    loadData();
    var command = new Command();
    var robotText = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Главная')),
        body: Container(
            padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0 ),
            decoration: BoxDecoration(
              color: Colors.white,

              //borderRadius: BorderRadius.all(Radius.circular(22))
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(Icons.volume_down, size: 30),
                    new Expanded(
                      child: Slider(
                        value: currentVolume,
                        onChanged: (newValue) {

                          setState(() => currentVolume = newValue);
                          prefs.setDouble('currentVolume', newValue);
                        },
                        onChangeEnd: (newValue) {
                          double resultValue = (65535/100)*newValue;
                          command.run('setsysvolume ${resultValue}');
                        },
                        min: 0,
                        max: 100,
                      ),
                    ),
                    Icon(
                      Icons.volume_up,
                      size: 30,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      FlatButton(
                        padding: const EdgeInsets.all(20.0),
                        color: Colors.indigo,
                        textColor: Colors.white,
                        onPressed: () {
                          print('monitor off');
                          command.run('monitor off');
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.personal_video, size: 42),
//                            Text(
//                              "Выкл. монитор",
//                            )
                          ],
                        ),
                      ),
                      FlatButton(
                        padding: const EdgeInsets.all(20.0),
                        color: Colors.greenAccent,
                        textColor: Colors.white,
                        onPressed: () {
                          command.run('exitwin reboot');
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.replay, size: 42,),
//                            Text(
//                              "Перезагрузить",
//                            )
                          ],
                        ),
                      ),
                      FlatButton(
                        padding: const EdgeInsets.all(20.0),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        onPressed: () {
                          command.run('exitwin poweroff');
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.power_settings_new, size: 42,),
//                            Text(
//                              "Перезагрузить",
//                            )
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      padding: const EdgeInsets.all(20.0),
                      color: Colors.yellowAccent,
                      textColor: Colors.black,
                      onPressed: () async {
                        ClipboardData data = await Clipboard.getData('text/plain');
                        print('clipboard set '+ data.text);
                        command.run('clipboard set "'+ data.text +'"');
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.content_paste, size: 42),
//                            Text(
//                              "Перезагрузить",
//                            )
                        ],
                      ),
                    ),
                    FlatButton(
                      padding: const EdgeInsets.all(20.0),
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        command.run('standby');
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.brightness_2, size: 42),
//                            Text(
//                              "Перезагрузить",
//                            )
                        ],
                      ),
                    ),
                    FlatButton(
                      padding: const EdgeInsets.all(20.0),
                      color: Colors.tealAccent,
                      textColor: Colors.white,
                      onPressed: () {
                        showDialog(child: new Dialog(
                          child: Container(
                            height: 150,
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextField(
                                  controller: robotText,
                                ),
                                FlatButton(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text('Отправить'),
                                  onPressed: () {
                                    command.run('speak text "' + robotText.text + '"');
                                  },
                                )
                              ],
                            ),
                          )
                        ), context: context);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.voicemail, size: 42),
//                            Text(
//                              "Перезагрузить",
//                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
