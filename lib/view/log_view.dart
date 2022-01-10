//RGBの円グラフを表示。
import 'package:colorich/view/laugh_tail_view.dart';
import 'package:colorich/view_model/function.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class RGBPie extends StatefulWidget {
  final double countR;
  final double countG;
  final double countB;
  const RGBPie({
    Key? key,
    required this.countR,
    required this.countG,
    required this.countB,
  }) : super(key: key);

  @override
  _RGBPieState createState() => _RGBPieState();
}

class _RGBPieState extends State<RGBPie> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> rgbMap = {
      'Red': widget.countR,
      'Green': widget.countG,
      'Blue': widget.countB,
    };
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () =>
              Nav.navigate(context, const LaughTailView(), const Offset(1, 0)),
          child: const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Icon(Icons.arrow_back_ios_outlined),
          ),
        ),
      ),
      body: Center(
        child: PieChart(
          dataMap: rgbMap,
          animationDuration: const Duration(milliseconds: 800),
          chartLegendSpacing: 70,
          chartRadius: MediaQuery.of(context).size.width / 1.5,
          colorList: const [
            Colors.redAccent,
            Colors.greenAccent,
            Colors.blueAccent
          ],
          initialAngleInDegree: -90,
          chartType: ChartType.disc,
          ringStrokeWidth: 32,
          centerText: "RGB",
          centerTextStyle: const TextStyle(
            color: Colors.white,
            backgroundColor: Colors.black12,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.bottom,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: const ChartValuesOptions(
            chartValueStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            showChartValueBackground: false,
            showChartValues: true,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
          ),
        ),
      ),
    );
  }
}
