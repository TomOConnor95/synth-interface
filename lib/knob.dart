import 'dart:math';
import 'package:flutter/material.dart';

class Knob extends StatefulWidget {
  final double value;
  final double min;
  final double max;

  final double size;

  final Color color;

  final ValueChanged<double> onChanged;

  Knob({this.value, this.min, this.max, this.color, this.size, this.onChanged});

  @override
  State<StatefulWidget> createState() => KnobState();
}

class KnobState extends State<Knob> {
  
  double distanceToAngle = 40;
  
  @override
  Widget build(BuildContext context) {
    double normalisedValue = (widget.value - widget.min) / (widget.max - widget.min);
    double angle = normalisedValue * 1.8 * pi + - 0.9 * pi;
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
                decoration: BoxDecoration(
                  color: widget.color.withAlpha((170 + normalisedValue*255/3).toInt()),
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    width: 3.0,
                    color: widget.color.withAlpha((255 - normalisedValue*255).toInt()),
                  ),
                ),
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

class KnobInt extends StatefulWidget {
  final int value;
  final int min;
  final int max;

  final double size;
  final Color color;

  final ValueChanged<int> onChanged;

  KnobInt({this.value, this.min, this.max, this.color, this.size, this.onChanged});

  @override
  State<StatefulWidget> createState() => KnobIntState();
}

class KnobIntState extends State<KnobInt> {
  
  double distanceToAngle = 70;
  Color iconColor = Colors.white;
  double internalValue = 3;
  @override
  Widget build(BuildContext context) {
    // double angle = ((internalValue - widget.min) / (widget.max - widget.min)) * 1.8 * pi + - 0.9 * pi;
    double normalisedValue = (internalValue - widget.min) / (widget.max - widget.min);
    double angle = normalisedValue * 1.8 * pi + - 0.9 * pi;
    double size = widget.size;
    return Center(
      child: Container(
        width: size,
        height: size,
        child: Transform.rotate(
          angle: angle,
          child: GestureDetector(
            onVerticalDragStart: (DragStartDetails details) {
              setState(() {
                internalValue = widget.value.toDouble();            
              });
            },
            onVerticalDragEnd: (DragEndDetails details) {
              setState(() {
                internalValue = widget.value.toDouble();            
              });
            },
            onVerticalDragUpdate: (DragUpdateDetails details) {
                double newAngle = max(min(angle - details.delta.dy/distanceToAngle, 0.9*pi), -0.9*pi);
                double newValue = ((newAngle + 0.9*pi) / (1.8 * pi)) * (widget.max - widget.min) + widget.min;

                setState(() {
                  internalValue = newValue;            
                });

                if ((newValue - widget.value).abs() >= 1)
                setState(() {
                  widget.onChanged(newValue.round());
                });
            },
            child: ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color.withAlpha((170 + normalisedValue*255/3).toInt()),
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    width: 3.0,
                    color: widget.color.withAlpha((255 - normalisedValue*255).toInt()),
                  ),
                ),
                child: Icon(Icons.arrow_upward,
                  color: iconColor,
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
