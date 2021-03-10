import 'package:flutter/material.dart';

class ConfigsPlaceholder {
  static Widget placeholderText() {
    return Container(
      width: 100,
      height: 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.withOpacity(0.2),
      ),
    );
  }
}
