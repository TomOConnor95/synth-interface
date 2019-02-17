import 'package:flutter/material.dart';
import 'dart:math';

class OscillatorParams {
  double length;
  int freq;
  double widthAmp;
  int widthFreq;
  double opacityAmp;
  int opacityFreq;
  Color color;

  OscillatorParams({
    this.length,
    this.freq,
    this.widthAmp,
    this.widthFreq,
    this.opacityAmp,
    this.opacityFreq,
    this.color,
  });
}

OscillatorParams lerpOscillatorParams(
  OscillatorParams params1,
  OscillatorParams params2,
  double blendValue){
    OscillatorParams blendedParams =  OscillatorParams(
      length: lerp(params1.length, params2.length, blendValue),
      freq: lerpInt(params1.freq, params2.freq, blendValue),
      widthAmp: lerp(params1.widthAmp, params2.widthAmp, blendValue),
      widthFreq: lerpInt(params1.widthFreq, params2.widthFreq, blendValue),
      opacityAmp: lerp(params1.opacityAmp, params2.opacityAmp, blendValue),
      opacityFreq: lerpInt(params1.opacityFreq, params2.opacityFreq, blendValue),
      color: Color.lerp(params1.color, params2.color, blendValue)
    );
  return blendedParams;
}

double lerp(double a, double b, double blendValue){
  if (a == null && b == null)
    return null;
  a ??= 0.0;
  b ??= 0.0;
  return a + (b - a) * blendValue;
}
int lerpInt(int a, int b, double blendValue){
  if (a == null && b == null)
    return null;
  a ??= 0;
  b ??= 0;
  return (a + (b - a) * blendValue).round();
}

OscillatorParams randomOscillatorParams(){
  var randomGenerator = Random();
  return OscillatorParams(
    length: randomGenerator.nextDouble(),
    freq: randomGenerator.nextInt(10) + 1,
    widthAmp: randomGenerator.nextDouble(),
    widthFreq: randomGenerator.nextInt(10) + 1,
    opacityAmp: randomGenerator.nextDouble(),
    opacityFreq: randomGenerator.nextInt(10) + 1,
    color: Color.fromRGBO(
      randomGenerator.nextInt(256),
      randomGenerator.nextInt(256),
      randomGenerator.nextInt(256),
      1.0,
    ),
  );
}
