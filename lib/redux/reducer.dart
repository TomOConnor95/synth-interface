import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../oscillator_params.dart';

import './actions.dart';
import './redux_state.dart';

ReduxState reducer(ReduxState state, dynamic action) {
  if (action is SavePreset) {
    var newPreset = deepCopyPreset(state.currentParams);
    state.savedPresets.add(newPreset);
  }
  if (action is DeletePreset) {
    state.savedPresets.removeAt(action.presetNumber);
  }
  if (action is RecallPreset) {
    var recalledPreset = deepCopyPreset(state.savedPresets[action.presetNumber]);
    state.currentParams = recalledPreset;
  }
  if (action is RandomiseParameters) {
    if (action.oscillatorToRandomise == 0) {
      state.currentParams[0] = randomOscillatorParams();
    } else if (action.oscillatorToRandomise == 1) {
      state.currentParams[1] = randomOscillatorParams();
    } else if (action.oscillatorToRandomise == 2) {
      state.currentParams[2] = randomOscillatorParams();
    } else {
      state.currentParams[0] = randomOscillatorParams();
      state.currentParams[1] = randomOscillatorParams();
      state.currentParams[2] = randomOscillatorParams();
    }
  }
  if (action is LengthCallback) {
    state.currentParams[action.oscillatorNumber].length = action.value;
  }
  if (action is FreqCallback) {
    state.currentParams[action.oscillatorNumber].freq = action.value;
  }
  if (action is WidthAmpCallback) {
    state.currentParams[action.oscillatorNumber].widthAmp = action.value;
  }
  if (action is WidthFreqCallback) {
    state.currentParams[action.oscillatorNumber].widthFreq = action.value;
  }
  if (action is OpacityAmpCallback) {
    state.currentParams[action.oscillatorNumber].opacityAmp = action.value;
  }
  if (action is OpacityFreqCallback) {
    state.currentParams[action.oscillatorNumber].opacityFreq = action.value;
  }
  if (action is ColorCallback) {
    state.currentParams[action.oscillatorNumber].color = action.value;
  }
  
  if (action is LeftPresetSelectorCallback) {
    state.presetSelectedLeft = action.presetNumber;
  }
  if (action is RightPresetSelectorCallback) {
    state.presetSelectedRight = action.presetNumber;
  }
  if (action is BlendSliderCallback) {
    state.blendValue = action.blendValue;
  }
  if (action is BlendPresets || 
      action is LeftPresetSelectorCallback || 
      action is RightPresetSelectorCallback
  ) {
    state.currentParams = [
      lerpOscillatorParams(state.savedPresets[state.presetSelectedLeft][0], state.savedPresets[state.presetSelectedRight][0], state.blendValue),
      lerpOscillatorParams(state.savedPresets[state.presetSelectedLeft][1], state.savedPresets[state.presetSelectedRight][1], state.blendValue),
      lerpOscillatorParams(state.savedPresets[state.presetSelectedLeft][2], state.savedPresets[state.presetSelectedRight][2], state.blendValue),
    ];
  }

  sendParametersToSynth(state.channel, state.currentParams);
  return state;
}

List<OscillatorParams> deepCopyPreset(preset) {
  var newPreset = [
    OscillatorParams(
      length: preset[0].length,
      freq: preset[0].freq,
      widthAmp: preset[0].widthAmp,
      widthFreq: preset[0].widthFreq,
      opacityAmp: preset[0].opacityAmp,
      opacityFreq: preset[0].opacityFreq,
      color: preset[0].color,
    ),
    OscillatorParams(
      length: preset[1].length,
      freq: preset[1].freq,
      widthAmp: preset[1].widthAmp,
      widthFreq: preset[1].widthFreq,
      opacityAmp: preset[1].opacityAmp,
      opacityFreq: preset[1].opacityFreq,
      color: preset[1].color,
    ),
    OscillatorParams(
      length: preset[2].length,
      freq: preset[2].freq,
      widthAmp: preset[2].widthAmp,
      widthFreq: preset[2].widthFreq,
      opacityAmp: preset[2].opacityAmp,
      opacityFreq: preset[2].opacityFreq,
      color: preset[2].color,
    )
  ];
  return newPreset;
}

void sendParametersToSynth(WebSocketChannel channel, List<OscillatorParams> preset) {
  var paramsToSend = {
    'oscillator1': {
      'length': preset[0].length,
      'freq': preset[0].freq,
      'widthAmp': preset[0].widthAmp,
      'widthFreq': preset[0].widthFreq,
      'opacityAmp': preset[0].opacityAmp,
      'opacityFreq': preset[0].opacityFreq,
      'color':{
        'r': preset[0].color.red,
        'g': preset[0].color.green,
        'b': preset[0].color.blue,
      },
    },
    'oscillator2': {
      'length': preset[1].length,
      'freq': preset[1].freq,
      'widthAmp': preset[1].widthAmp,
      'widthFreq': preset[1].widthFreq,
      'opacityAmp': preset[1].opacityAmp,
      'opacityFreq': preset[1].opacityFreq,
      'color':{
        'r': preset[1].color.red,
        'g': preset[1].color.green,
        'b': preset[1].color.blue,
      },
    },
    'oscillator3': {
      'length': preset[2].length,
      'freq': preset[2].freq,
      'widthAmp': preset[2].widthAmp,
      'widthFreq': preset[2].widthFreq,
      'opacityAmp': preset[2].opacityAmp,
      'opacityFreq': preset[2].opacityFreq,
      'color':{
        'r': preset[2].color.red,
        'g': preset[2].color.green,
        'b': preset[2].color.blue,
      },
    }
  };
  
  channel.sink.add(json.encode(paramsToSend));
} 
