import 'dart:math';
import 'package:flutter/material.dart';
import './circle_sector.dart';
import './oscillator_params.dart';

class PresetGaugeDisplay extends StatefulWidget {

  final List<OscillatorParams> preset;

  PresetGaugeDisplay(this.preset);

  @override
  _PresetGaugeDisplayState createState() => _PresetGaugeDisplayState();
}

class _PresetGaugeDisplayState extends State<PresetGaugeDisplay>
    with SingleTickerProviderStateMixin {

  Animation<double> _angleAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
        duration: const Duration(milliseconds: 6000), vsync: this);
    _angleAnimation = new Tween(begin: 0.0, end: 2*pi).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    _angleAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double size = 100;
    double width = 8;

    double radius1 = 40;
    double radius2 = 30;
    double radius3 = 20;

    return Stack(
      children: <Widget>[
        oscillatorAnimation(
          widget.preset[0].length*100,
          widget.preset[0].freq,
          widget.preset[0].widthAmp,
          widget.preset[0].widthFreq, 
          widget.preset[0].opacityAmp, 
          widget.preset[0].opacityFreq,
          radius1,
          widget.preset[0].color,
          width,
          _angleAnimation.value,
          size,
        ),
        oscillatorAnimation(
          widget.preset[1].length*100,
          widget.preset[1].freq,
          widget.preset[1].widthAmp,
          widget.preset[1].widthFreq, 
          widget.preset[1].opacityAmp, 
          widget.preset[1].opacityFreq,
          radius2,
          widget.preset[1].color,
          width,
          _angleAnimation.value,
          size,
        ),
        oscillatorAnimation(
          widget.preset[2].length*100,
          widget.preset[2].freq,
          widget.preset[2].widthAmp,
          widget.preset[2].widthFreq, 
          widget.preset[2].opacityAmp, 
          widget.preset[2].opacityFreq,
          radius3,
          widget.preset[2].color,
          width,
          _angleAnimation.value,
          size,
        ),
      ],
    );
  }
}

Widget oscillatorAnimation(
  double length,
  int freq,
  double widthAmp,
  int widthFreq, 
  double opacityAmp, 
  int opacityFreq,
  double radius,
  Color color
  double width,
  double angleAnimationValue,
  double size,
    ) {
  return Transform.rotate(
      angle: angleAnimationValue * freq,
      child: Center(
        child: CircleSector(
            length,
            size,
            radius,
            width * (2 + widthAmp *(cos(widthFreq * angleAnimationValue) - 1))/2,
            color.withOpacity((2 + opacityAmp *(cos(opacityFreq * angleAnimationValue) - 1))/2)),
      ),
  );
}
