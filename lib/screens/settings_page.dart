import 'package:flutter/material.dart';
import 'package:flutter_back_end/widgets/widget_chart_month.dart';

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
    return ChartMonth();
  }
}
