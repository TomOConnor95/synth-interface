import 'package:flutter/material.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../oscillator_params.dart';

class ReduxState {
  List<OscillatorParams> currentParams;
  List<List<OscillatorParams>> savedPresets;

  final WebSocketChannel channel;

  int presetSelectedLeft;
  int presetSelectedRight;
  double blendValue;

  ReduxState(
    this.currentParams,
    this.savedPresets,
    this.channel,
    this.presetSelectedLeft,
    this.presetSelectedRight,
    this.blendValue,
  );

  void dispose() {
    channel.sink.close();
  }
}

var initialParams = [
    OscillatorParams(
    length: 0.3,
    freq: 2,
    widthAmp: 0.7,
    widthFreq: 3,
    opacityAmp: 0.2,
    opacityFreq: 4,
    color: Colors.indigoAccent,
    ),
    OscillatorParams(
    length: 0.7,
    freq: 3,
    widthAmp: 0.6,
    widthFreq: 5,
    opacityAmp: 0.1,
    opacityFreq: 4,
    color: Colors.red,
    ),
    OscillatorParams(
    length: 0.8,
    freq: 4,
    widthAmp: 0.1,
    widthFreq: 3,
    opacityAmp: 0.1,
    opacityFreq: 10, 
    color: Colors.green,
    )
  ];

var initialState = ReduxState(
  initialParams,
  [],
  IOWebSocketChannel.connect('ws://127.0.0.1:6666'),
  0,
  1,
  0.5,
);
