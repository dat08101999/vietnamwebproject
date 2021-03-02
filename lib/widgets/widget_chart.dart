import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_mainpage.dart';
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
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

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

  Widget buildTitleArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Thống Kê Tài Chính',
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            height: 50,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.grey),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: Colors.white70,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              tabs: [
                Tab(child: Text('Tuần này', style: TextStyle(fontSize: 10))),
                Tab(child: Text('Tháng này', style: TextStyle(fontSize: 10))),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: GetBuilder<ControllerMainPage>(
          builder: (build) {
            return Column(children: [buildTitleArea(), buildChartArea()]);
          },
        ));
  }
}
