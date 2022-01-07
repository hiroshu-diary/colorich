//編集画面
import 'package:colorich/model/one_piece.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'dart:ui';

class UpdatePieceView extends StatefulWidget {
  final OnePiece thisPiece;

  const UpdatePieceView({Key? key, required this.thisPiece}) : super(key: key);

  @override
  _UpdatePieceViewState createState() => _UpdatePieceViewState();
}

class _UpdatePieceViewState extends State<UpdatePieceView> {
  final double cardSideLength = window.physicalSize.width * 0.14;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int nowId = widget.thisPiece.oneId;
    int nowRed = widget.thisPiece.oneRed;
    int nowGreen = widget.thisPiece.oneGreen;
    int nowBlue = widget.thisPiece.oneBlue;
    DateTime createdTime = widget.thisPiece.oneTime;
    String? nowStory = widget.thisPiece.oneStory;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(nowStory ?? ''),
            Text(createdTime.toString()),
            CircleAvatar(
              backgroundColor: Color.fromRGBO(nowRed, nowGreen, nowBlue, 1),
              minRadius: 50,
            )
          ],
        ),
      ),
    );
  }
}
