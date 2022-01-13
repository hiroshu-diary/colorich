import 'package:colorich/view/laugh_tail_view.dart';
import 'package:colorich/view_model/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:io';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

var box = Hive.box('myBox');

bool styleValue = box.get('style', defaultValue: false);

class _SettingsViewState extends State<SettingsView> {
  bool notifyValue = box.get('notice', defaultValue: false);
  TimeOfDay time = const TimeOfDay(hour: 21, minute: 00);

  final setHelper = SetHelper();

  Future<void> selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (newTime != null) {
      setState(() {
        time = newTime;
        putString(time);
      });
    }
    FlutterLocalNotificationsPlugin().cancelAll();

    if (notifyValue == true) {
      setHelper.notify(time);
    }
  }

  //通知の保存
  Future putNotice(notice) async => await box.put('notice', notice);
  //通知時間の保存
  Future putTimers(timers) async => await box.put('timers', timers);
  Future putString(timeString) async =>
      await box.put('string', time.format(context));
  //Card↔Puzzuleの切り替え
  Future putStyle(style) async => await box.put('style', style);

  @override
  Widget build(BuildContext context) {
    String timeString = box.get('string', defaultValue: time.format(context));
    return ValueListenableBuilder(
      valueListenable: Hive.box('myBox').listenable(),
      builder: (context, box, widget) {
        return Scaffold(
          appBar: NewGradientAppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: GestureDetector(
                onTap: () {
                  Nav.navigate(
                    context,
                    const LaughTailView(),
                    const Offset(-1, 0),
                  );
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
            centerTitle: true,
            gradient: const LinearGradient(
              colors: [Colors.blueAccent, Colors.cyanAccent],
            ),
            title: const Text('Settings', style: TextStyle(fontSize: 28)),
          ),
          body: SettingsList(
            contentPadding: const EdgeInsets.all(5.0),
            sections: [
              SettingsSection(
                title: 'BACK',
                titlePadding: const EdgeInsets.only(top: 15, left: 15),
                titleTextStyle: const TextStyle(fontSize: 20),
                tiles: [
                  SettingsTile.switchTile(
                    title: 'Notification',
                    titleTextStyle: const TextStyle(fontSize: 18),
                    leading: Icon(
                      notifyValue == false
                          ? Icons.alarm_off_outlined
                          : Icons.alarm_on_outlined,
                      size: 30,
                    ),
                    switchValue: notifyValue,
                    onToggle: (bool value) {
                      setState(
                        () {
                          notifyValue = !notifyValue;
                          putNotice(notifyValue);
                          if (notifyValue == false) {
                            setHelper.notify(time);
                          } else {
                            setHelper.dumpNotify();
                          }
                        },
                      );
                    },
                  ),
                  SettingsTile(
                    title: 'Time',
                    titleTextStyle: const TextStyle(fontSize: 18),
                    leading: const Icon(Icons.watch_later_outlined, size: 30),
                    trailing: GestureDetector(
                      onTap: () {
                        selectTime();
                        if (notifyValue == true) {
                          setHelper.dumpNotify();
                          setHelper.notify(time);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          //timeString,
                          timeString,
                          // ' ${time.format(context)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: 'STYLE',
                titlePadding: const EdgeInsets.only(top: 15, left: 15),
                titleTextStyle: const TextStyle(fontSize: 20),
                tiles: [
                  SettingsTile.switchTile(
                    title: styleValue == false ? 'Card' : 'Puzzle',
                    titleTextStyle: const TextStyle(fontSize: 18),
                    leading: Icon(
                      styleValue == false
                          ? Icons.view_comfortable
                          : FontAwesomeIcons.puzzlePiece,
                      size: 30,
                    ),
                    switchValue: styleValue,
                    onToggle: (bool value) {
                      setState(() {
                        styleValue = value;
                        putStyle(value);
                      });
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'ACTION',
                titlePadding: const EdgeInsets.only(top: 20, left: 15),
                titleTextStyle: const TextStyle(fontSize: 20),
                tiles: [
                  // SettingsTile(
                  //   onPressed: (BuildContext context) {
                  //     setHelper.launchMail();
                  //   },
                  //   title: 'Message',
                  //   titleTextStyle: const TextStyle(fontSize: 18),
                  //   leading: const Icon(Icons.mail_outline_outlined, size: 30),
                  // ),
                  SettingsTile(
                    onPressed: (BuildContext context) {
                      setHelper.launchAppStore();
                    },
                    title: 'Review',
                    titleTextStyle: const TextStyle(fontSize: 18),
                    leading: Platform.isIOS
                        ? const Icon(FontAwesomeIcons.appStore, size: 30)
                        : const Icon(FontAwesomeIcons.googlePlay, size: 30),
                  ),
                ],
              ),
              //使い方を表示
              SettingsSection(
                title: 'Instructions',
                titlePadding: const EdgeInsets.only(top: 20, left: 15),
                titleTextStyle: const TextStyle(fontSize: 20),
                tiles: [
                  const SettingsTile(
                    leading: Text('ColoRich を１回タップ'),
                    title: '',
                    titleTextStyle: TextStyle(fontSize: 18),
                    trailing: Text('最新ピースへ移動'),
                  ),
                  const SettingsTile(
                    leading: Text('ColoRich をロングタップ'),
                    title: '',
                    titleTextStyle: TextStyle(fontSize: 18),
                    trailing: Text('最古ピースへ移動'),
                  ),
                  SettingsTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(FontAwesomeIcons.peace),
                        Text('ボタンをロングタップ'),
                      ],
                    ),
                    title: '',
                    titleTextStyle: const TextStyle(fontSize: 18),
                    trailing: const Text('RGBグラフ へ移動'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
