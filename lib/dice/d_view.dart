import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'd_model.dart';

class ColoDice extends StatefulWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;
  const ColoDice({
    Key? key,
    required this.selectedColor,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  _ColoDiceState createState() => _ColoDiceState();
}

class _ColoDiceState extends State<ColoDice> {
  final Dice dice = Dice();
  final diceLength = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(widget.selectedColor),
    );
  }

  Center buildBody(Color selectedColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: diceLength,
            height: diceLength,
            child: MaterialButton(
              child: Icon(
                Icons.shuffle_outlined,
                size: window.physicalSize.height * 0.04,
                color: Colors.white70,
              ),
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80)),
              onPressed: () {
                setState(() {
                  setState(() {
                    dice.randomHexRed = Random().nextInt(256);
                    dice.randomHexGreen = Random().nextInt(256);
                    dice.randomHexBlue = Random().nextInt(256);
                  });
                  selectedColor = Color.fromRGBO(
                    dice.randomHexRed,
                    dice.randomHexGreen,
                    dice.randomHexBlue,
                    1,
                  );
                  widget.onColorChanged(selectedColor);
                });
              },
              color: Color.fromARGB(
                255,
                dice.decimalList[dice.randomHexRed],
                dice.decimalList[dice.randomHexGreen],
                dice.decimalList[dice.randomHexBlue],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            '#${dice.hexList[dice.randomHexRed]}${dice.hexList[dice.randomHexGreen]}${dice.hexList[dice.randomHexBlue]}',
            style: TextStyle(
              fontSize: 21.0,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(
                255,
                dice.decimalList[dice.randomHexRed],
                dice.decimalList[dice.randomHexGreen],
                dice.decimalList[dice.randomHexBlue],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
