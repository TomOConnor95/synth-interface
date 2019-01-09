import 'dart:math';
import 'package:flutter/material.dart';
import './circle_sector.dart';
import './oscillator_params.dart';


Widget presetGaugeDisplay(OscillatorParams oscillatorParams1, Color color1, OscillatorParams oscillatorParams2, Color color2, OscillatorParams oscillatorParams3, Color color3, double animationAngle) {
    double angleInRadians = animationAngle / 360 * 2 * pi;
    double size = 100;
    double width = 8;

    double radius1 = 40;
    double radius2 = 30;
    double radius3 = 20;

    return Stack(
      children: <Widget>[
        OscillatorAnimation(
          oscillatorParams1.length*100,
          oscillatorParams1.widthAmp,
          oscillatorParams1.widthFreq, 
          oscillatorParams1.opacityAmp, 
          oscillatorParams1.opacityFreq,
          radius1,
          color1,
          width,
          angleInRadians * 2,
          size,
        ),
        OscillatorAnimation(
          oscillatorParams2.length*100,
          oscillatorParams2.widthAmp,
          oscillatorParams2.widthFreq, 
          oscillatorParams2.opacityAmp, 
          oscillatorParams2.opacityFreq,
          radius2,
          color2,
          width,
          angleInRadians * 3,
          size,
        ),
        OscillatorAnimation(
          oscillatorParams3.length*100,
          oscillatorParams3.widthAmp,
          oscillatorParams3.widthFreq, 
          oscillatorParams3.opacityAmp, 
          oscillatorParams3.opacityFreq,
          radius3,
          color3,
          width,
          angleInRadians * 4,
          size,
        ),
      ],
    );
  }

  Widget OscillatorAnimation(
    double length,
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
        angle: angleAnimationValue,
        child: Center(
          child: CircleSector(
              length,
              size,
              radius,
              width * (2 + widthAmp *(sin(widthFreq * angleAnimationValue) - 1))/2,
              color.withOpacity((2 + opacityAmp *(sin(opacityFreq * angleAnimationValue) - 1))/2)),
        ),
    );
  }