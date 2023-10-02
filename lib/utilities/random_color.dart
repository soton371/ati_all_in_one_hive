import 'dart:math';
import 'package:flutter/material.dart';

Random myRandom = Random();
Color myRandomColor() {
  int r = myRandom.nextInt(255);
  int g = myRandom.nextInt(255);
  int b = myRandom.nextInt(255);

  return Color.fromRGBO(r, g, b, 0.8);
}