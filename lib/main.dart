import 'package:colorich/view/laugh_tail_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LaughTailView(),
    );
  }
}
// todo ①ラフテルのcolorListを表示できるようにする
// todo ②new_world_viewの確定ボタン後、db追加、UI更新
// todo ③各カードをロングタップ時にDraggableにし、下中央で削除できるようんする。
// todo ④カードタップ時に、インスタみたいなアニメで編集画面へ遷移、色と言葉だけ変更可能に。
// todo ⑤累積RGBを示す。
// todo ⑥SettingsViewを作成。(通知設定、アプリ評価）
