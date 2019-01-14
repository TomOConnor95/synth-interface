import 'package:flutter/material.dart';

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
