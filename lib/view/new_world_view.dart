import 'package:colorich/dice/d_model.dart';
import 'package:colorich/model/one_piece.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import 'package:simple_shadow/simple_shadow.dart';

class NewPieceView extends StatefulWidget {
  final List<OnePiece> timeLine;
  final int? index;

  const NewPieceView({Key? key, required this.timeLine, this.index})
      : super(key: key);

  @override
  _NewPieceViewState createState() => _NewPieceViewState();
}

class _NewPieceViewState extends State<NewPieceView> {
  Color selectedColor = const Color(0xFF000000);
  final double cardSideLength = window.physicalSize.width * 0.14;
  final Dice dice = Dice();
  final controller = TextEditingController();
  void initAddColor() {
    if (widget.index != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 10),
                child: SimpleShadow(
                  child: SizedBox(
                    child: Card(color: selectedColor),
                    width: cardSideLength,
                    height: cardSideLength,
                  ),
                  opacity: 0.4,
                  color: Colors.black87,
                  offset: const Offset(4, 4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SimpleShadow(
                      child: const Text(
                        'Howdy?',
                        style: TextStyle(fontSize: 21.0),
                      ),
                      opacity: 0.5,
                      color: Colors.black,
                      offset: const Offset(1, 1),
                    ),
                    const SizedBox(width: 18.0),
                    CupertinoButton(
                      child: SimpleShadow(
                        child: Icon(
                          FontAwesomeIcons.paintRoller,
                          color: selectedColor,
                          size: 33,
                        ),
                        opacity: 0.20,
                        color: Colors.black,
                        offset: const Offset(2, 2),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              insetPadding: const EdgeInsets.all(20),
                              titlePadding: const EdgeInsets.all(0),
                              contentPadding: const EdgeInsets.all(0),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              content: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Column(
                                    children: [
                                      ColorPicker(
                                        pickerColor: selectedColor,
                                        onColorChanged: (value) {
                                          setState(() => selectedColor = value);
                                        },
                                        colorPickerWidth: 300,
                                        pickerAreaHeightPercent: 0.7,
                                        enableAlpha: false,
                                        labelTypes: const [ColorLabelType.rgb],
                                        displayThumbColor: true,
                                        paletteType: PaletteType.hueWheel,
                                        pickerAreaBorderRadius:
                                            const BorderRadius.only(
                                          topLeft: Radius.circular(2),
                                          topRight: Radius.circular(2),
                                        ),
                                        hexInputBar: true,
                                      ),
                                      SlidePicker(
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: GestureDetector(
                  child: TextFormField(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SimpleShadow(
        opacity: 0.4,
        color: Colors.black,
        offset: const Offset(2, 2),
        child: IconButton(
          icon: const Icon(Icons.all_inclusive_rounded),
          iconSize: 70,
          color: selectedColor,
          hoverColor: selectedColor,
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
