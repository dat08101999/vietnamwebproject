import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartModel {
  /// giá trị hàng ngang
  final String x;

  /// giá trị hàng dọc
  final int y;

  /// màu của cột
  final charts.Color barcolor;

  /// barcolor = Barcolor.barcolor('Màu')
  ChartModel({@required this.x, @required this.y, @required this.barcolor});
}

class Barcolor {
  static charts.Color barcolor(MaterialColor color) {
    return charts.ColorUtil.fromDartColor(color);
  }
}

class Chart extends StatelessWidget {
  final List<ChartModel> data;
  Chart({this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartModel, String>> series = [
      charts.Series(
          id: 'sub',
          data: data,
          domainFn: (ChartModel series, _) => series.x,
          measureFn: (ChartModel series, _) => series.y,
          colorFn: (ChartModel series, _) => series.barcolor)
    ];
    return charts.BarChart(
      series,
      animate: true,
      primaryMeasureAxis: charts.NumericAxisSpec(),
      behaviors: [
        new charts.SlidingViewport(),
        new charts.PanAndZoomBehavior(),
      ],
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(
            labelStyle: new charts.TextStyleSpec(
                fontSize: 9, // size in Pts.
                color: charts.MaterialPalette.black),
          ),
          viewport: new charts.OrdinalViewport('01', 7)),
    );
  }
}
