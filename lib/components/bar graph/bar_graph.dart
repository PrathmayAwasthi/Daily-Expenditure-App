import 'package:daily_expenditure_tracker/components/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thurAmount: thurAmount,
        friAmount: friAmount,
        satAmount: satAmount,
        sunAmount: sunAmount);
    myBarData.initializeBarData();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BarChart(BarChartData(
        maxY: 100,
        minY: 0,
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, getTitlesWidget: getBottomTiles))),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.amber,
                      width: 25,
                      borderRadius: BorderRadius.circular(8),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true, color: Colors.amber[100], toY: maxY))
                ]))
            .toList(),
      )),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta tm) {
  const style = TextStyle(
    color: Colors.amber,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        "Mon",
        style: style,
      );
      break;
    case 1:
      text = const Text(
        "Tue",
        style: style,
      );
      break;
    case 2:
      text = const Text(
        "Wed",
        style: style,
      );
      break;
    case 3:
      text = const Text(
        "Thu",
        style: style,
      );
      break;
    case 4:
      text = const Text(
        "Fri",
        style: style,
      );
      break;
    case 5:
      text = const Text(
        "Sat",
        style: style,
      );
      break;
    case 6:
      text = const Text(
        "Sun",
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(child: text, axisSide: tm.axisSide);
}
