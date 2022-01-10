//編集画面
import 'package:colorich/model/one_piece.dart';
import 'package:colorich/model/sqlite.dart';
import 'package:colorich/view/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'dart:ui';

class UpdatePieceView extends StatefulWidget {
  final OnePiece thisPiece;

  const UpdatePieceView({Key? key, required this.thisPiece}) : super(key: key);

  @override
  _UpdatePieceViewState createState() => _UpdatePieceViewState();
}

class _UpdatePieceViewState extends State<UpdatePieceView> {
  final double cardSideLength = window.physicalSize.width * 0.20;
  var colorController = TextEditingController();
  var storyController = TextEditingController();
  final DateFormat outputFormat = DateFormat('yyyy年 M月 d日 h時 m分');
  late OnePiece onePiece;
  //Color selectedColor = Colors.grey;

  @override
  void initState() {
    colorController = TextEditingController();
    storyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    colorController.dispose();
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int nowRed = widget.thisPiece.oneRed;
    int nowGreen = widget.thisPiece.oneGreen;
    int nowBlue = widget.thisPiece.oneBlue;
    DateTime createdTime = widget.thisPiece.oneTime;
    String? nowStory = widget.thisPiece.oneStory;
    Color selectedColor = Color.fromRGBO(nowRed, nowGreen, nowBlue, 1);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          outputFormat.format(createdTime),
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  showDialog(
                      context: context,
                      builder: (context) {
                        OnePiece thisPiece = widget.thisPiece;
                        return CupertinoAlertDialog(
                          content: const Text(
                            '本当に削除してもいいですか？',
                            style: TextStyle(fontSize: 15),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('はい'),
                              onPressed: () async {
                                //todo 削除→はい、にした時画面が崩れてる？
                                await DbProvider.delete(thisPiece.oneId);
                                Navigator.pop(context);
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                Navigator.pop(context);
                                // reBuild();
                             },
                            ),
                            CupertinoDialogAction(
                              child: const Text('いいえ'),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        );
                      });
                });
              },
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        var currentIndex = 0;
                        return AlertDialog(
                          titlePadding: const EdgeInsets.all(0),
                          contentPadding: const EdgeInsets.all(5.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          content: SizedBox(
                            height: 420,
                            child: CupertinoTabScaffold(
                              tabBuilder: (context, currentIndex) {
                                if (currentIndex == 0) {
                                  return ColorPicker(
                                    pickerColor: selectedColor,
                                    hexInputController: colorController,
                                    onColorChanged: (value) {
                                      setState(
                                        () => selectedColor = value,
                                      );
                                    },
                                    colorPickerWidth: 300,
                                    pickerAreaHeightPercent: 0.65,
                                    enableAlpha: false,
                                    labelTypes: const [
                                      ColorLabelType.rgb,
                                      ColorLabelType.hsv,
                                      ColorLabelType.hsl,
                                    ],
                                    displayThumbColor: true,
                                    paletteType: PaletteType.hueWheel,
                                    pickerAreaBorderRadius:
                                        const BorderRadius.only(
                                      topLeft: Radius.circular(2),
                                      topRight: Radius.circular(2),
                                    ),
                                    hexInputBar: true,
                                  );
                                } else {
                                  return SlidePicker(
                                    pickerColor: selectedColor,
                                    onColorChanged: (Color value) {
                                      setState(() {
                                        selectedColor = value;
                                      });
                                    },
                                    colorModel: ColorModel.rgb,
                                    sliderSize: const Size(350, 50),
                                    sliderTextStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    enableAlpha: false,
                                    displayThumbColor: true,
                                    showParams: true,
                                    indicatorBorderRadius:
                                        const BorderRadius.all(
                                      Radius.circular(3),
                                    ),
                                  );
                                }
                              },
                              tabBar: CupertinoTabBar(
                                currentIndex: currentIndex,
                                items: const [
                                  BottomNavigationBarItem(
                                    icon: Icon(Icons.colorize),
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Icon(
                                        CupertinoIcons.slider_horizontal_3),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: SimpleShadow(
                    child: SizedBox(
                      child: styleValue == false
                          ? Card(color: selectedColor)
                          : Image.asset('images/puzzule.jpg',
                              color: selectedColor),
                      width: cardSideLength,
                      height: cardSideLength,
                    ),
                    opacity: 0.4,
                    color: Colors.black87,
                    offset: const Offset(4, 4),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: GestureDetector(
                  child: TextFormField(
                    controller: storyController,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: ('STORY'),
                      hintStyle: const TextStyle(fontSize: 20),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    maxLines: 10,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SimpleShadow(
        opacity: 0.4,
        color: Colors.black,
        offset: const Offset(2, 2),
        child: IconButton(
          icon: const Icon(Icons.update),
          iconSize: 70,
          color: selectedColor,
          hoverColor: selectedColor,
          onPressed: () async {
            onePiece = OnePiece(
              widget.thisPiece.oneId,
              selectedColor.red,
              selectedColor.green,
              selectedColor.blue,
              createdTime,
              storyController.text,
            );
            // await DbProvider.update(onePiece);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
