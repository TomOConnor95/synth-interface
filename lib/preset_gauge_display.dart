import 'dart:math';
import 'package:flutter/material.dart';
import './circle_sector.dart';

Widget presetGaugeDisplay(double value1, double value2, double value3, double animationAngle) {
    double angleInRadians = animationAngle / 360 * 2 * pi;
    double size = 100;
    double width = 8;
    return Stack(
      children: <Widget>[
        Transform.rotate(
          angle: angleInRadians * 1,
          child: Center(
            child: CircleSector(
                value1 * 10,
                size,
                40.0,
                width,
                Colors.indigoAccent),
          ),
        ),
        Transform.rotate(
          angle: angleInRadians * 1.5,
          child: Center(
            child: CircleSector(
              value2 * 10,
              size,
              30.0,
              width,
              Colors.red),
          ),
        ),
        Transform.rotate(
          angle: angleInRadians * 2,
          child: Center(
            child: CircleSector(
              value3 * 10,
              size, 20.0,
              width,
              Colors.green),
          ),
        ),
      ],
    );
  }