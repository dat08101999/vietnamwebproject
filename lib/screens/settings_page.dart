import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //* logo VAWEB
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'VAWEB',
                  style: TextStyle(
                      color: Color(0xff7589a2),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            //* biểu đồ
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(
                        show: true,
                        border: Border(
                            left:
                                BorderSide(width: 1, color: Color(0xff7589a2)),
                            bottom: BorderSide(
                                width: 1, color: Color(0xff7589a2)))),
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                        margin: 15,
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                        reservedSize: 15,
                        getTitles: (value) {
                          if (value == 0) {
                            return '';
                          } else if (value == 200000) {
                            return '500K';
                          } else if (value == 1000000) {
                            return '1m';
                          } else if (value == 2000000) {
                            return '2m';
                          } else if (value == 5000000) {
                            return '5m';
                          } else if (value == 10000000) {
                            return '10m';
                          } else if (value == 20000000) {
                            return '20m';
                          } else if (value == 30000000) {
                            return '30m';
                          } else if (value == 40000000) {
                            return '40m';
                          } else if (value == 50000000) {
                            return '50m';
                          } else if (value == 60000000) {
                            return '60m';
                          } else if (value == 70000000) {
                            return '70m';
                          } else if (value == 80000000) {
                            return '80m';
                          } else if (value == 90000000) {
                            return '90m';
                          } else if (value == 100000000) {
                            return '100m';
                          } else {
                            return '';
                          }
                        },
                      ),
                      bottomTitles: SideTitles(
                          showTitles: true,
                          margin: 20,
                          getTextStyles: (value) => TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold),
                          getTitles: (value) {
                            if (value == 0) {
                              return 'T2';
                            } else if (value == 1) {
                              return 'T3';
                            } else if (value == 2) {
                              return 'T4';
                            } else if (value == 3) {
                              return 'T5';
                            } else if (value == 4) {
                              return 'T6';
                            } else if (value == 5) {
                              return 'T7';
                            } else if (value == 6) {
                              return 'CN';
                            } else {
                              return '|';
                            }
                          }),
                    ),
                    barGroups: [
                      makeGroupData(
                          0,
                          double.parse(
                              new Random().nextInt(10000000).toString())),
                      makeGroupData(
                          1,
                          double.parse(
                              new Random().nextInt(10000000).toString())),
                      makeGroupData(
                          2,
                          double.parse(
                              new Random().nextInt(10000000).toString())),
                      makeGroupData(
                          3,
                          double.parse(
                              new Random().nextInt(10000000).toString())),
                      makeGroupData(
                          4,
                          double.parse(
                              new Random().nextInt(10000000).toString())),
                      makeGroupData(
                          5,
                          double.parse(
                              new Random().nextInt(10000000).toString())),
                      makeGroupData(
                          6,
                          double.parse(
                              new Random().nextInt(10000000).toString())),
                    ],
                  ),
                  swapAnimationDuration: Duration(seconds: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final Color _leftBarColor = const Color(0xff53fdd7);
final Color _rightBarColor = const Color(0xffff5182);

BarChartGroupData makeGroupData(int x, double y1) {
  return BarChartGroupData(barsSpace: 10, x: x, barRods: [
    BarChartRodData(
      y: y1,
      colors: [y1 > 1000000 ? _leftBarColor : _rightBarColor],
      width: 20,
      borderRadius: BorderRadius.circular(0),
    ),
  ]);
}
