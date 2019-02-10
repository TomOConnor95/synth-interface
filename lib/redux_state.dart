
import './oscillator_params.dart';

class ReduxState {
  List<OscillatorParams> currentParams;
  List<List<OscillatorParams>> savedPresets;

  ReduxState(this.currentParams, this.savedPresets);
}
