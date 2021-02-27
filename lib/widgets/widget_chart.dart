import 'package:flutter/material.dart';
import 'package:flutter_back_end/controllers/controller_revuen.dart';
import 'package:flutter_back_end/main.dart';
import 'package:flutter_back_end/models/charts.dart';
import 'package:flutter_back_end/models/models_revenue.dart';
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
    _tabController = TabController(length: 4, initialIndex: 0, vsync: this);
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

  FutureBuilder buildTapbarView(DateTime from, DateTime to, String type) {
    sumText = _todaysum.toString();
    if (type == 'month') controllerReveun.update();
    return FutureBuilder<List<ChartModel>>(
      future: getListChartModel(from, to, type),
      builder: (buil, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Chart(
          data: snapshot.data,
        );
      },
    );
  }

  Future<List<ChartModel>> getListChartModel(
      DateTime from, DateTime to, String type) async {
    List<ChartModel> chartModels = List<ChartModel>();
    dynamic reponse = await Revenue.getRevenueData(from, to);
    dynamic data = reponse['data'];
    for (int i = 0; i < data['labels'].length; i++) {
      getSumary(type, int.parse(data['counts'][i].toString()));
      chartModels.add(ChartModel(
          x: getdataLable(data['labels'][i].toString().split('/')),
          y: int.parse(data['counts'][i].toString()),
          barcolor: data['labels'][i] == DateTime.now()
              ? Barcolor.barcolor(Colors.grey)
              : Barcolor.barcolor(Colors.blue)));
    }
    return chartModels;
  }

  String getdataLable(List<String> daySplit) {
    List<String> dayinWeek = ["mon", "tue", "wed", "thur", "fri", "sat", "sun"];
    int weekDayindex = DateTime(int.parse(daySplit[2]), int.parse(daySplit[1]),
            int.parse(daySplit[0]))
        .weekday;
    return daySplit[0] + '.' + dayinWeek[weekDayindex - 1];
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
        borderRadius: BorderRadius.circular(10), color: Colors.white,
        //shape: BoxShape.values,
        boxShadow: [BoxShadow(blurRadius: 20)]);
  }

  Widget buildChartArea() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          buildTapbarView(today(), today(), 'day'),
          buildTapbarView(yesterday(), yesterday(), 'yesterday'),
          buildTapbarView(startThisWeek(), endThisWeek(), 'week'),
          buildTapbarView(startThisMonth(), endThisMonth(), 'month')
        ],
      ),
    );
  }

  Widget buildCenterArea() {
    return Container(
      height: currentContext.height * 0.15,
      child: Center(
        child: Text('Tổng: ' + sumText),
      ),
    );
  }

  Widget buildTitleArea() {
    return Container(
      color: Colors.blue,
      child: Row(children: [
        Text('Báo Cáo tài Chính'),
        Container(
          decoration: decorationTitle(),
          width: MediaQuery.of(context).size.width * 0.65,
          child: TabBar(
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.white,
            controller: _tabController,
            tabs: [
              Tab(
                  child: Text(
                'Hôm nay',
                style: TextStyle(color: Colors.black, fontSize: 9),
              )),
              Tab(
                  child: Text('Hôm qua',
                      style: TextStyle(color: Colors.black, fontSize: 9))),
              Tab(
                  child: Text('Tuần này',
                      style: TextStyle(color: Colors.black, fontSize: 9))),
              Tab(
                  child: Text('Tháng này',
                      style: TextStyle(color: Colors.black, fontSize: 9))),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        color: Colors.white,
        child: Column(children: [
          buildTitleArea(),
          GetBuilder<ControllerReveun>(
            builder: (builder) {
              return buildCenterArea();
            },
          ),
          buildChartArea()
        ]));
  }
}
