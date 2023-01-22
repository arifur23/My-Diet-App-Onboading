import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintClass extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.height;
    var centerY = size.width / 2;
    var center = Offset(centerX, centerY);
    var startAngle = 5 * pi;
    var sweepAngle = 180 * pi / 180;

    var arcPaint = Paint()
      ..color = Colors.grey.withOpacity(.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 100
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: 255), startAngle, sweepAngle,
        false, arcPaint);

    var innerCircleRadius = 280 - 17;
    var outerCircleRadius = 275;

    var dashBrush = Paint()
      ..color =  Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    var angle = 180;
    var centersY = 170;
    var centersX = 190;

    for (double i = 0; i < 360; i += 3) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / angle);
      var y1 = centerX + outerCircleRadius * sin(i * pi / angle);

      var x2 = centerX + innerCircleRadius * cos(i * pi / angle);
      var y2 = centerX + innerCircleRadius * sin(i * pi / angle);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    for (double i = 0; i < 360; i += 6) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / angle);
      var y1 = centerX + outerCircleRadius * sin(i * pi / angle);

      var x2 = centerX + 260 * cos(i * pi / angle);
      var y2 = centerX + 260 * sin(i * pi / angle);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
