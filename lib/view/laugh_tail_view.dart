import 'package:after_layout/after_layout.dart';
import 'package:colorich/dice/d_model.dart';
import 'package:colorich/dice/d_view.dart';
import 'package:colorich/model/one_piece.dart';
import 'package:colorich/model/sqlite.dart';
import 'package:colorich/view/settings_view.dart';
import 'package:colorich/view_model/function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'new_world_view.dart';

class LaughTailView extends StatefulWidget {
  const LaughTailView({Key? key}) : super(key: key);

  @override
  State<LaughTailView> createState() => _LaughTailViewState();
}

class _LaughTailViewState extends State<LaughTailView>
    with AfterLayoutMixin<LaughTailView> {
  final scl = Scl();
  final Color rrr = const Color(0xffff99ff);
  final Color ggg = const Color.fromRGBO(255, 100, 255, 1);
  final double connectCircle = 27.0;
  final double sidePadding = 3.9;
  final Dice dice = Dice();
  List<OnePiece> timeLine = [];

  ScrollController scrollController = ScrollController();

  //同時に削除できないようにする↑
  Future<void> initDb() async {
    await DbProvider.setDb();
    timeLine = await DbProvider.read();
    setState(() {});
  }

  Future<void> reBuild() async {
    timeLine = await DbProvider.read();
    setState(() {});
  }

  @override
  void afterFirstLayout(BuildContext context) {
    scl.scrollToBottom(scrollController, scl.startDur, scl.startCur);
  }

  @override
  void initState() {
    super.initState();
    initDb();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: GestureDetector(
            onTap: () => scl.oneTapTitle(scrollController),
            onLongPress: () => scl.longTapTitle(scrollController),
            child: const Text('ColoRich', style: TextStyle(fontSize: 33)),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: const Icon(Icons.settings, size: 33, color: Colors.black),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingsView();
                }));
              },
              onLongPress: () {
                Nav.navigate(context, const ColoDice(), const Offset(0, -1));
              },
            ),
          )
        ],
        elevation: 0.0,
      ),
      backgroundColor: Color.fromARGB(
        255,
        dice.hexRGB[dice.ranHR],
        dice.hexRGB[dice.ranHG],
        dice.hexRGB[dice.ranHB],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MaterialButton(
        onPressed: () async {
          await showCupertinoModalBottomSheet(
            barrierColor: const Color.fromARGB(100, 0, 0, 0),
            topRadius: const Radius.circular(25),
            context: context,
            builder: (context) {
              return const NewPieceView(timeLine: []);
            },
          );
          reBuild();
          //上行の一瞬スクロールは、Riverpodを使わず、Rebuildが難しくなった時用。
          scl.afterNewPiece(scrollController);
        },
        onLongPress: () {},
        shape: const CircleBorder(),
        child: CircleAvatar(
            radius: 42,
            backgroundColor: Colors.white,
            child: SimpleShadow(
                opacity: 0.3,
                color: Colors.black,
                offset: const Offset(0, 7),
                child: const Image(
                  image: AssetImage('images/peace.png'),
                  height: 80,
                  width: 80,
                ))),
        //↑左からRGBの円グラフ（RGBPieChart）を出す。
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.white,
        child: SizedBox(height: 40),
      ),
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sidePadding,
                vertical: 3.0,
              ),
              child: GridView.builder(
                controller: scrollController,
                itemCount: timeLine.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    //CupertinoDialogで削除ポップ
                    onLongPress: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) {
                              var thisPiece = timeLine[index];
                              return CupertinoAlertDialog(
                                content: const Text(
                                  '本当に削除してもいいですか？',
                                  style: TextStyle(fontSize: 15),
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text('はい'),
                                    onPressed: () async {
                                      await DbProvider.delete(thisPiece.oneId);
                                      Navigator.pop(context);
                                      reBuild();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text('いいえ'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        //ほぼ正方形
                        SimpleShadow(
                          offset: const Offset(-2, -2),
                          sigma: 3,
                          child: Container(
                            margin: const EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21.0),
                              color: oneColor(index),
                            ),
                          ),
                        ),
                        //左右コネクト
                        Positioned(
                          left: -3,
                          top: (deviceWidth - sidePadding * 2) / 6 -
                              connectCircle / 2,
                          width: connectCircle,
                          height: connectCircle,
                          child: SimpleShadow(
                            sigma: 3,
                            color: oneColor(index),
                            offset: const Offset(-3, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index % 3 != 0
                                    ? oneColor(index - 1)
                                    : const Color.fromRGBO(0, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                        //上下コネクト
                        Positioned(
                          top: -3,
                          left: (deviceWidth - sidePadding * 2) / 6 -
                              connectCircle / 2,
                          width: connectCircle,
                          height: connectCircle,
                          child: SimpleShadow(
                            sigma: 3,
                            color: oneColor(index),
                            offset: const Offset(0, -3),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index > 2
                                    ? oneColor(index - 3)
                                    : const Color.fromRGBO(0, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color oneColor(int index) {
    return Color.fromRGBO(
      timeLine[index].oneRed,
      timeLine[index].oneGreen,
      timeLine[index].oneBlue,
      1.0,
    );
  }
}
