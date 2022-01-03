import 'package:after_layout/after_layout.dart';
import 'package:colorich/dice/d_view.dart';
import 'package:colorich/model/one_piece.dart';
import 'package:colorich/model/sqlite.dart';
import 'package:colorich/view/settings_view.dart';
import 'package:colorich/view_model/function.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'list.dart';
import 'new_world_view.dart';

class LaughTailView extends StatefulWidget {
  const LaughTailView({Key? key}) : super(key: key);

  @override
  State<LaughTailView> createState() => _LaughTailViewState();
}

class _LaughTailViewState extends State<LaughTailView>
    with AfterLayoutMixin<LaughTailView> {
  List<OnePiece> timeLine = [];
  final scl = Scl();
  final Color rrr = const Color(0xffff99ff);
  final Color ggg = const Color.fromRGBO(255, 100, 255, 1);

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
    scrollController = ScrollController();
    super.initState();
    initDb();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: GestureDetector(
            onTap: () => scl.scrollToBottom(
              scrollController,
              scl.sclToBmDur,
              scl.sclToBmCur,
            ),
            onLongPress: () => scl.scrollToTop(
              scrollController,
              scl.sclToHdDur,
              scl.sclToHdCur,
            ),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MaterialButton(
        onPressed: () async {
          await showCupertinoModalBottomSheet(
            barrierColor: const Color.fromARGB(100, 0, 0, 0),
            topRadius: const Radius.circular(25),
            context: context,
            builder: (context) {
              return NewPieceView(timeLine: []);
            },
          );
          //上行の一瞬スクロールは、Riverpodを使わず、Rebuildが難しくなった時用。
          scl.scrollToTop(scrollController, scl.toRe, scl.newCur);
          scl.scrollToBottom(scrollController, scl.newDur, scl.newCur);
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
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: GridView.builder(
          controller: scrollController,
          itemCount: laughTailColors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return laughTailColors[index];
          },
        ),
      ),
    );
  }
}
