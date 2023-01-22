import 'package:flutter/material.dart';

const double baseHeight = 650.0;

double screenAwareWidthSize(double size, BuildContext context) {
  double drawingHeight =
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  return size * drawingHeight / baseHeight;
}
