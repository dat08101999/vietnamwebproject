import 'package:flutter/material.dart';
import 'package:flutter_back_end/widgets/widget_chart.dart';

class HomePage extends StatefulWidget {
  String name;
  HomePage({this.name});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [WidgetChart()],
        ),
      ),
    );
  }
}
