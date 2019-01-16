import 'dart:math';
import 'package:flutter/material.dart';
import './circle_sector.dart';
import './oscillator_params.dart';


Widget presetGaugeDisplay(OscillatorParams oscillatorParams1, OscillatorParams oscillatorParams2, OscillatorParams oscillatorParams3, double animationAngle) {
    double angleInRadians = animationAngle / 360 * 2 * pi;
    double size = 100;
    double width = 8;

    double radius1 = 40;
    double radius2 = 30;
    double radius3 = 20;

    return Stack(
      children: <Widget>[
        oscillatorAnimation(
          oscillatorParams1.length*100,
          oscillatorParams1.freq,
          oscillatorParams1.widthAmp,
          oscillatorParams1.widthFreq, 
          oscillatorParams1.opacityAmp, 
          oscillatorParams1.opacityFreq,
          radius1,
          oscillatorParams1.color,
          width,
          angleInRadians,
          size,
        ),
        oscillatorAnimation(
          oscillatorParams2.length*100,
          oscillatorParams2.freq,
          oscillatorParams2.widthAmp,
          oscillatorParams2.widthFreq, 
          oscillatorParams2.opacityAmp, 
          oscillatorParams2.opacityFreq,
          radius2,
          oscillatorParams2.color,
          width,
          angleInRadians,
          size,
        ),
        oscillatorAnimation(
          oscillatorParams3.length*100,
          oscillatorParams3.freq,
          oscillatorParams3.widthAmp,
          oscillatorParams3.widthFreq, 
          oscillatorParams3.opacityAmp, 
          oscillatorParams3.opacityFreq,
          radius3,
          oscillatorParams3.color,
          width,
          angleInRadians,
          size,
        ),
      ],
    );
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