import 'dart:math';
import 'package:flutter/material.dart';

class Knob extends StatefulWidget {
  double value;
  double min;
  double max;

  double size;

  Color color;

  final ValueChanged<double> onChanged;

  Knob({this.value, this.min, this.max, this.color, this.size, this.onChanged});

  @override
  State<StatefulWidget> createState() => KnobState();
}

class KnobState extends State<Knob> {
  
  double distanceToAngle = 40;
  
  @override
  Widget build(BuildContext context) {
    double angle = ((widget.value - widget.min) / (widget.max - widget.min)) * 1.8 * pi + - 0.9 * pi;
    double size = widget.size;
    return Center(
      child: Container(
        width: size,
        height: size,
        child: Transform.rotate(
          angle: angle,
          child: GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails details) {
                double newAngle = max(min(angle - details.delta.dy/distanceToAngle, 0.9*pi), -0.9*pi);
                double newValue = ((newAngle + 0.9*pi) / (1.8 * pi)) * (widget.max - widget.min) + widget.min;
                widget.onChanged(newValue);
            },
            child: ClipOval(
              child: Container(
                color: widget.color,
                child: Icon(Icons.arrow_upward,
                  color: Colors.white,
                  size: size * 0.75,
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}