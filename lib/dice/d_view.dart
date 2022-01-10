import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'd_model.dart';

class ColoDice extends StatefulWidget {
  final Color selectedColor;
  const ColoDice({Key? key, required this.selectedColor}) : super(key: key);

  @override
  ColoDiceState createState() => ColoDiceState();
}

class ColoDiceState extends State<ColoDice> {
  final Dice dice = Dice();
  final diceLength = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: randomDice(widget.selectedColor),
    );
  }

  Center randomDice(Color selectedColor) {
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
                size: window.physicalSize.height * 0.03,
                color: Colors.white70,
              ),
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              onPressed: () {
                setState(() {
                  dice.ranHR = Random().nextInt(256);
                  dice.ranHG = Random().nextInt(256);
                  dice.ranHB = Random().nextInt(256);
                  selectedColor =
                      Color.fromRGBO(dice.ranHR, dice.ranHG, dice.ranHB, 1);
                });
              },
              color: selectedColor,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            '#${dice.copiedHEX[selectedColor.red]}${dice.copiedHEX[selectedColor.green]}${dice.copiedHEX[selectedColor.blue]}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: selectedColor,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Red: ${selectedColor.red}',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 5.0),
              Text(
                'Green: ${selectedColor.green}',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 5.0),
              Text(
                'Blue: ${selectedColor.blue}',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
