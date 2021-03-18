import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/configs/config_theme.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/models/format.dart';

class ChartMonth extends StatelessWidget {
  final DateTime startday;
  final DateTime endday;
  ChartMonth({this.startday, this.endday});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getRevenueData(startday, endday),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BarChartGroupData> _barCharGroupData = snapshot.data;
            return AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 10, bottom: 10, top: 10),
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
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: Colors.black54,
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    const textStyle = TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    );
                                    return BarTooltipItem(
                                      Format.moneyFormat(
                                              rod.y.ceil().toString()) +
                                          ' đ',
                                      textStyle,
                                    );
                                  },
                                ),
                              ),
                              borderData: FlBorderData(
                                  show: false,
                                  border: Border(
                                      left: BorderSide(
                                          width: 1, color: Color(0xff7589a2)),
                                      bottom: BorderSide(
                                          width: 1, color: Color(0xff7589a2)))),
                              titlesData: FlTitlesData(
                                leftTitles: SideTitles(
                                  showTitles: true,
                                  getTextStyles: (value) => const TextStyle(
                                      color: Color(0xff7589a2),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                  margin: 10,
                                  reservedSize: 15,
                                  getTitles: (value) {
                                    if (value == 0) {
                                      return '';
                                    } else if (value == 50000) {
                                      return '50K';
                                    } else if (value == 100000) {
                                      return '100K';
                                    } else if (value == 200000) {
                                      return '200K';
                                    } else if (value == 500000) {
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
                                    margin: 10,
                                    getTextStyles: (value) => TextStyle(
                                        color: Color(0xff7589a2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                    getTitles: (value) {
                                      if (value == 0) {
                                        return '1';
                                      } else if (value == 4) {
                                        return '5';
                                      } else if (value == 9) {
                                        return '10';
                                      } else if (value == 14) {
                                        return '15';
                                      } else if (value == 19) {
                                        return '20';
                                      } else if (value == 24) {
                                        return '25';
                                      } else if (value == 29) {
                                        return '30';
                                      } else {
                                        return '.';
                                      }
                                    }),
                              ),
                              barGroups: _barCharGroupData),
                          swapAnimationDuration: Duration(seconds: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(
                'Không Có Dữ Liệu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

BarChartGroupData makeGroupData(int x, double y1) {
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      y: y1,
      colors: [
        y1 > 200000 ? ConfigTheme.hightBarColor : ConfigTheme.lowBarColor
      ],
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3), topRight: Radius.circular(3)),
      width: 2,
    ),
  ]);
}

int summary = 0;

Future<List<BarChartGroupData>> _getRevenueData(
    DateTime startday, DateTime endday) async {
  summary = 0;
  // Get.find<ControllerReveun>().update();
  var paramas = {
    'token': ControllerMainPage.webToken,
    'from': Format.dateFormat(startday),
    'to': Format.dateFormat(endday)
  };
  print(paramas);
  var response = await RequestDio.get(
      url: ConfigsMywebvietnam.getRepostRevenue, parames: paramas);
  if (response['success']) {
    List counts = response['data']['counts'];
    return List.generate(counts.length, (index) {
      summary += int.parse(counts[index].toString());
      return makeGroupData(index, double.parse(counts[index].toString()));
    });
  } else {
    print('lỗi getRevenueMonth');
    return null;
  }
}
