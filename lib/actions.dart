import 'package:flutter/material.dart';
import './oscillator_params.dart';


class SavePreset {
  final List<OscillatorParams> preset;
  SavePreset(this.preset);
}

class RecallPreset {
  final int presetNumber;
  RecallPreset(this.presetNumber);
}

class LengthCallback {
  final int oscillatorNumber;
  final double value;

  LengthCallback(this.oscillatorNumber, this.value);
}

class FreqCallback {
  final int oscillatorNumber;
  final int value;

  FreqCallback(this.oscillatorNumber, this.value);
}

class WidthAmpCallback {
  final int oscillatorNumber;
  final double value;

  WidthAmpCallback(this.oscillatorNumber, this.value);
}

class WidthFreqCallback {
  final int oscillatorNumber;
  final int value;

  WidthFreqCallback(this.oscillatorNumber, this.value);
}

class OpacityAmpCallback {
  final int oscillatorNumber;
  final double value;

  OpacityAmpCallback(this.oscillatorNumber, this.value);
}

class OpacityFreqCallback {
  final int oscillatorNumber;
  final int value;

  OpacityFreqCallback(this.oscillatorNumber, this.value);
}

class ColorCallback {
  final int oscillatorNumber;
  final Color value;

  ColorCallback(this.oscillatorNumber, this.value);
}


