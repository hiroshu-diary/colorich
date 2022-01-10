import 'dart:ui';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: randomDice(widget.selectedColor),
    );
  }

  Center randomDice(Color selectedColor) {
    final Dice dice = Dice();
    const diceLength = 200.0;
    void shuffleColor() {
      setState(() {
        dice.randomHexRed = Random().nextInt(256);
        dice.randomHexGreen = Random().nextInt(256);
        dice.randomHexBlue = Random().nextInt(256);
      });
    }

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
              color: selectedColor,
              onPressed: () {
                shuffleColor();
                setState(() {
                  selectedColor = Color.fromRGBO(
                    dice.randomHexRed,
                    dice.randomHexGreen,
                    dice.randomHexBlue,
                    1,
                  );
                });
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            '#${dice.hexList[selectedColor.red]}${dice.hexList[selectedColor.green]}${dice.hexList[selectedColor.blue]}',
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
              const SizedBox(width: 4.0),
              Text(
                'Green: ${selectedColor.green}',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 4.0),
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
