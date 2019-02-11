import 'package:web_socket_channel/web_socket_channel.dart';

import './oscillator_params.dart';

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
}
