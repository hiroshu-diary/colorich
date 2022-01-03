import 'dart:ui';
import 'package:colorich/view/laugh_tail_view.dart';
import 'package:colorich/view_model/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:math';
import 'd_model.dart';

class ColoDice extends StatefulWidget {
  const ColoDice({Key? key}) : super(key: key);

  @override
  _ColoDiceState createState() => _ColoDiceState();
}

class _ColoDiceState extends State<ColoDice> {
  final Dice dice = Dice();
  final diceLength = window.physicalSize.height * 0.12;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        gradient: const LinearGradient(
          colors: [Colors.greenAccent, Colors.green],
        ),
        title: const Text('ColoDice', style: TextStyle(fontSize: 33)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: const Icon(
                FontAwesomeIcons.peace,
                size: 33,
                color: Colors.white,
              ),
              onTap: () {
                Nav.navigate(
                  context,
                  const LaughTailView(),
                  const Offset(0, 0),
                );
              },
            ),
          )
        ],
      ),
      body: Center(
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
                    dice.ranHR = Random().nextInt(256);
                    dice.ranHG = Random().nextInt(256);
                    dice.ranHB = Random().nextInt(256);
                  });
                },
                color: Color.fromARGB(
                  255,
                  dice.hexRGB[dice.ranHR],
                  dice.hexRGB[dice.ranHG],
                  dice.hexRGB[dice.ranHB],
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Text(
              '#${dice.copiedHEX[dice.ranHR]}${dice.copiedHEX[dice.ranHG]}${dice.copiedHEX[dice.ranHB]}',
              style: TextStyle(
                fontSize: 21.0,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(
                  255,
                  dice.hexRGB[dice.ranHR],
                  dice.hexRGB[dice.ranHG],
                  dice.hexRGB[dice.ranHB],
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                Text(
                  'Red: ${dice.hexRGB[dice.ranHR]}',
                  style: const TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 12.0),
                Text(
                  'Green: ${dice.hexRGB[dice.ranHG]}',
                  style: const TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12.0),
                Text(
                  'Blue: ${dice.hexRGB[dice.ranHB]}',
                  style: const TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
      floatingActionButton: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        height: 44,
        color: Colors.grey,
        textColor: Colors.white,
        splashColor: Colors.grey,
        hoverColor: Colors.black,
        onPressed: () {
          setState(() {
            var data = ClipboardData(
                text:
                    '${dice.copiedHEX[dice.ranHR]}${dice.copiedHEX[dice.ranHG]}${dice.copiedHEX[dice.ranHB]}');

            Clipboard.setData(data);
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return CupertinoAlertDialog(
            //       title: const Text("Copy completed！"),
            //       content: Text(
            //           "#${dice.copiedHEX[dice.ranHR]}${dice.copiedHEX[dice.ranHG]}${dice.copiedHEX[dice.ranHB]}"),
            //       actions: <Widget>[
            //         CupertinoDialogAction(
            //           child: const Text("OK"),
            //           onPressed: () => Navigator.pop(context),
            //         ),
            //       ],
            //     );
            //   },
            // );
          });
        },
        child: const Text(
          'COPY',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
