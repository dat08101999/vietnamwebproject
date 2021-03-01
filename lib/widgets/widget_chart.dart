import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_revuen.dart';
import 'package:flutter_back_end/widgets/widget_chart_month.dart';
import 'package:flutter_back_end/widgets/widget_chart_week.dart';
import 'package:get/get.dart';

class WidgetChart extends StatefulWidget {
  @override
  _WidgetChartgetState createState() => _WidgetChartgetState();
}

class _WidgetChartgetState extends State<WidgetChart>
    with SingleTickerProviderStateMixin {
  ControllerReveun controllerReveun = Get.put(ControllerReveun());
  TabController _tabController;
  int _todaysum = 0;
  int _weeksum = 0;
  int _yesterdaysum = 0;
  int _monthsum = 0;
  String sumText = '';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _tabController.addListener(() {
      int index = _tabController.index;
      switch (index) {
        case 0:
          sumText = _todaysum.toString();
          break;
        case 1:
          sumText = _yesterdaysum.toString();
          break;
        case 2:
          sumText = _weeksum.toString();
          break;
        case 3:
          sumText = _monthsum.toString();
          break;
      }
      controllerReveun.update();
    });
  }

  void getSumary(String type, int sumParam) {
    switch (type) {
      case 'day':
        _todaysum += sumParam;
        break;
      case 'yesterday':
        _yesterdaysum += sumParam;
        break;
      case 'week':
        _weeksum += sumParam;
        break;
      case 'month':
        _monthsum += sumParam;
        break;
    }
  }

  // FutureBuilder buildTapbarView(DateTime from, DateTime to, String type) {
  //   sumText = _todaysum.toString();
  //   if (type == 'month') controllerReveun.update();
  //   return FutureBuilder<List<ChartModel>>();
  // }

  DateTime now = DateTime.now();
  DateTime today() {
    return now;
  }

  DateTime startThisWeek() {
    return now.subtract(Duration(days: now.weekday - 1));
  }

  DateTime endThisWeek() {
    return now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  }

  DateTime startThisMonth() {
    return DateTime(now.year, now.month, 1);
  }

  DateTime endThisMonth() {
    int lastday = DateTime(now.year, now.month + 1, 0).day;
    return DateTime(now.year, now.month, lastday);
  }

  DateTime yesterday() {
    return DateTime(now.year, now.month, now.day - 1);
  }

  BoxDecoration decorationTitle() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    );
  }

  Widget buildChartArea() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          WeekChart(
            startday: startThisWeek(),
            endday: endThisWeek(),
          ),
          ChartMonth(
            startday: startThisMonth(),
            endday: endThisMonth(),
          )
        ],
      ),
    );
  }

  Widget buildCenterArea() {
    return Container(
      //height: currentContext.height * 0.15,
      child: Center(
        child: Text('Tổng: ' + sumText),
      ),
    );
  }

  Widget buildTitleArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // color: Colors.blue,
        child: Row(children: [
          // Text('Báo Cáo tài Chính'),
          Container(
            decoration: decorationTitle(),
            width: MediaQuery.of(context).size.width * 0.55,
            child: TabBar(
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              tabs: [
                Tab(
                    child: Text('Tuần này',
                        style: TextStyle(color: Colors.black, fontSize: 14))),
                Tab(
                    child: Text('Tháng này',
                        style: TextStyle(color: Colors.black, fontSize: 14))),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        color: Colors.white,
        child: Column(children: [
          buildTitleArea(),
          GetBuilder<ControllerReveun>(
            builder: (builder) {
              return buildChartArea();
            },
          ),
        ]));
  }
}
