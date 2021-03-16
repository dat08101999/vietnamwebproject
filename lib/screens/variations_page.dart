import 'package:flutter/material.dart';
import 'package:flutter_back_end/widgets/widget_variations.dart';

class VariationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> variations;

  VariationsPage({this.variations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          height: 400,
          child: ListView.builder(
            itemCount: variations.length,
            itemBuilder: (context, index) => WidgetVariations(
              variation: variations[index],
            ),
          )),
    );
  }
}
