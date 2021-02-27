import 'package:flutter/material.dart';
import 'package:flutter_back_end/models/charts.dart';
import 'package:flutter_back_end/models/models_revenue.dart';

class WidgetChart extends StatefulWidget {
  @override
  _WidgetChartgetState createState() => _WidgetChartgetState();
}

class _WidgetChartgetState extends State<WidgetChart> {
  Widget buildTapbarView(DateTime today) {
    return Chart(
      data: [],
    );
  }

  void printdata() async {
    var data = await Revenue.getRevenueData(DateTime.now(), DateTime.now());
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    printdata();
    return Container(
      child: Column(children: [
        TabBar(
          tabs: [
            Text('Hôm nay '),
            Text('Hôm qua'),
            Text('Tuần này'),
            Text('Tháng này')
          ],
        ),
      ]),
    );
  }
}
