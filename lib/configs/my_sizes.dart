import 'package:flutter/material.dart';

class MySizes {
  static const double bodyPadding = 10.00;
  static const double radius = 10.00;
  static double height(context) => MediaQuery.sizeOf(context).height;
  static double width(context) => MediaQuery.sizeOf(context).width;
}