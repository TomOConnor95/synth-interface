import 'dart:math';
import 'package:flutter/material.dart';
import './circle_sector.dart';
import './oscillator_params.dart';


Widget presetGaugeDisplay(List<OscillatorParams> preset, double animationAngle) {
    double angleInRadians = animationAngle / 360 * 2 * pi;
    double size = 100;
    double width = 8;

    double radius1 = 40;
    double radius2 = 30;
    double radius3 = 20;

    return Stack(
      children: <Widget>[
        oscillatorAnimation(
          preset[0].length*100,
          preset[0].freq,
          preset[0].widthAmp,
          preset[0].widthFreq, 
          preset[0].opacityAmp, 
          preset[0].opacityFreq,
          radius1,
          preset[0].color,
          width,
          angleInRadians,
          size,
        ),
        oscillatorAnimation(
          preset[1].length*100,
          preset[1].freq,
          preset[1].widthAmp,
          preset[1].widthFreq, 
          preset[1].opacityAmp, 
          preset[1].opacityFreq,
          radius2,
          preset[1].color,
          width,
          angleInRadians,
          size,
        ),
        oscillatorAnimation(
          preset[2].length*100,
          preset[2].freq,
          preset[2].widthAmp,
          preset[2].widthFreq, 
          preset[2].opacityAmp, 
          preset[2].opacityFreq,
          radius3,
          preset[2].color,
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