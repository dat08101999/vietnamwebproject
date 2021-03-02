import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/widgets/widget_chart_month.dart';

class WeekChart extends StatelessWidget {
  final DateTime startday;
  final DateTime endday;
  WeekChart({this.startday, this.endday});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRevenueData(startday, endday),
      builder: (builder, snapshot) {
        if (snapshot.hasData) {
          List<BarChartGroupData> _barchartGroup = snapshot.data;
          return AspectRatio(
            aspectRatio: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: const Color(0xff2c4260),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //* title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'VAWEB ' + summary.toString(),
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Báo cáo tài chính',
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    //* biểu đồ
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        child: BarChart(
                          BarChartData(
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (value) => const TextStyle(
                                    color: Color(0xff7589a2),
                                    fontWeight: FontWeight.bold),
                                margin: 32,
                                reservedSize: 14,
                                getTitles: (value) {
                                  if (value == 0) {
                                    return '1K';
                                  } else if (value == 10) {
                                    return '5K';
                                  } else if (value == 19) {
                                    return '10K';
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
                                      return '0';
                                    } else if (value == 1) {
                                      return 'Thứ 2';
                                    } else if (value == 2) {
                                      return 'Thứ 3';
                                    } else if (value == 3) {
                                      return 'Thứ 4';
                                    } else if (value == 4) {
                                      return 'Thứ 5';
                                    } else if (value == 5) {
                                      return 'Thứ 6';
                                    } else if (value == 6) {
                                      return 'Thứ 7';
                                    } else if (value == 7) {
                                      return 'CN';
                                    } else {
                                      return '';
                                    }
                                  }),
                            ),
                            barGroups: _barchartGroup,
                          ),
                          swapAnimationDuration: Duration(seconds: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

final Color leftBarColor = const Color(0xff53fdd7);
final Color rightBarColor = const Color(0xffff5182);

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      y: y1,
      colors: [y1 > 10 ? leftBarColor : rightBarColor],
      borderRadius: BorderRadius.circular(3),
      width: 20,
    ),
  ]);
}
