import 'package:flutter/material.dart';

class GaugeNeedle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    double centerX = size.width / 2;
    double centerY = size.height;
    double sizeX = 5;
    double sizeY = size.height * 0.9 ;

    double radius = size.width / 4;

    canvas.drawRect(Offset(centerX, centerY-sizeY) & Size(sizeX, sizeY), paint);
    //canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}