import 'dart:math';
import 'package:flutter/material.dart';
double percentage;

class CircleSector extends StatelessWidget {

  CircleSector(this.percentage, this.size, this.radius, this.width, this.lineColor);

  final double percentage; 
  final double size;
  final double radius;
  final double width;
  final Color lineColor;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: CustomPaint(
        foregroundPainter: MyPainter(
            lineColor: lineColor,
            percent: percentage,
            width: width,
            radius: radius,
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter{
  Color lineColor;
  double percent;
  double radius;
  double width;
  MyPainter({this.lineColor, this.percent, this.radius, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center  = new Offset(size.width/2, size.height/2);
    double arcAngle = 2*pi* (percent/100);
    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        (-pi/2) - (arcAngle/2),
        arcAngle,
        false,
        complete
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}