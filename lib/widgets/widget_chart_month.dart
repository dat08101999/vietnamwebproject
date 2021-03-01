import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/models/request_dio.dart';

class ChartMonth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getRevenueMonth(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BarChartGroupData> _barCharGroupData = snapshot.data;
            return AspectRatio(
              aspectRatio: 1,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: const Color(0xff2c4260),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 10, bottom: 10, top: 10),
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
                            'VAWEB',
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
                                borderData: FlBorderData(
                                    show: true,
                                    border: Border(
                                        left: BorderSide(
                                            width: 1, color: Color(0xff7589a2)),
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color(0xff7589a2)))),
                                titlesData: FlTitlesData(
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (value) => const TextStyle(
                                        color: Color(0xff7589a2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    margin: 20,
                                    reservedSize: 14,
                                    getTitles: (value) {
                                      if (value == 0) {
                                        return '';
                                      } else if (value == 200000) {
                                        return '200K';
                                      } else if (value == 1000000) {
                                        return '1.m';
                                      } else if (value == 5000000) {
                                        return '5.m';
                                      } else if (value == 10000000) {
                                        return '10.m';
                                      } else if (value == 20000000) {
                                        return '20.m';
                                      } else if (value == 30000000) {
                                        return '30.m';
                                      } else if (value == 40000000) {
                                        return '40.m';
                                      } else if (value == 50000000) {
                                        return '50.m';
                                      } else if (value == 60000000) {
                                        return '60.m';
                                      } else if (value == 70000000) {
                                        return '70.m';
                                      } else if (value == 80000000) {
                                        return '80.m';
                                      } else if (value == 90000000) {
                                        return '90.m';
                                      } else if (value == 100000000) {
                                        return '100.m';
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
                                          fontSize: 14),
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
              ),
            );
          } else {
            print(snapshot.error);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

final Color leftBarColor = const Color(0xff53fdd7);
final Color rightBarColor = const Color(0xffff5182);

BarChartGroupData makeGroupData(int x, double y1) {
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      y: y1,
      colors: [y1 > 1000000 ? leftBarColor : rightBarColor],
      borderRadius: BorderRadius.circular(3),
      width: 5,
    ),
  ]);
}

Future<List<BarChartGroupData>> getRevenueMonth() async {
  var paramas = {
    'token': '4779ce0e8eeb2de09fd04dd38c7d0526',
    'from': '1/02/2021',
    'to': '28/02/2021'
  };
  var response = await RequestDio.get(
      url: ConfigsMywebvietnam.getRepostRevenue, parames: paramas);
  if (response['success']) {
    List counts = response['data']['counts'];
    return List.generate(counts.length, (index) {
      // if (counts[index] >= 10000)
      return makeGroupData(index, double.parse(counts[index].toString()));
      // return null;
    });
  } else {
    print('lỗi getRevenueMonth');
    return null;
  }
}
