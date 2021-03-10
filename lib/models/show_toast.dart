import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class ShowToast {
  static ShowToast _showtoast;

  static ShowToast _getIntance() {
    if (_showtoast == null) {
      return _showtoast = new ShowToast();
    }
    return _showtoast;
  }

  static show({@required String title}) {
    return _getIntance()._showToast(title: title, seconds: 2);
  }

  void _showToast({@required String title, int seconds}) {
    Timer(Duration(seconds: seconds), () {
      Navigator.pop(currentContext);
    });
    showDialog(
        barrierColor: Colors.transparent,
        context: currentContext,
        barrierDismissible: false,
        child: Padding(
          padding: EdgeInsets.only(top: Get.height * 0.8),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: DiaLogCustoms(title: title),
          ),
        ));
  }
}

class DiaLogCustoms extends StatefulWidget {
  final String title;

  const DiaLogCustoms({Key key, this.title}) : super(key: key);
  @override
  _DiaLogCustomsState createState() => _DiaLogCustomsState();
}

class _DiaLogCustomsState extends State<DiaLogCustoms> {
  bool _hide = false;
  @override
  void initState() {
    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        _hide = !_hide;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey,
      ),
      curve: Curves.easeInOut,
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      height: _hide ? 0 : 50,
      duration: Duration(milliseconds: 300),
      child: Text(
        widget.title,
        style: _textStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  TextStyle _textStyle =
      TextStyle(fontWeight: FontWeight.w500, color: Colors.white);
}
