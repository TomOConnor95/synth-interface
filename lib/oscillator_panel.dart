import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './slider_tile.dart';
import './amp_freq_knobs.dart';
import './oscillator_title_row.dart';

import './redux/actions.dart';
import './redux/redux_state.dart';


class OscillatorPanel extends StatelessWidget {
  final int oscNum;
  OscillatorPanel(this.oscNum);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReduxState, Store<ReduxState>>(
      converter: (store) => store,
      builder: (context, store) {
        return ExpansionTile(
          title: OscillatorTitleRow(
            title: 'Oscillator ${oscNum + 1}',
            color: store.state.currentParams[oscNum].color,
            onColorChanged: (color) => store.dispatch(ColorCallback(oscNum, color)),
            onShufflePressed: () => store.dispatch(RandomiseParameters(oscillatorToRandomise: oscNum))
          ),
          children: [
            SliderTile(
              store.state.currentParams[oscNum].length,
              store.state.currentParams[oscNum].color,
              (value) => store.dispatch(LengthCallback(oscNum, value)),
              'Length'
            ),
            SliderTileInt(
              store.state.currentParams[oscNum].freq,
              store.state.currentParams[oscNum].color,
              (value) => store.dispatch(FreqCallback(oscNum, value)),
              'Freq'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  AmpFreqKnobs(
                    ampValue: store.state.currentParams[oscNum].widthAmp,
                    ampMin: 0,
                    ampMax: 1,
                    ampCallback: (value) => store.dispatch(WidthAmpCallback(oscNum, value)),
                    freqValue: store.state.currentParams[oscNum].widthFreq,
                    freqMin: 1,
                    freqMax: 10,
                    freqCallback: (value) => store.dispatch(WidthFreqCallback(oscNum, value)),
                    label: 'Width Mod',
                    color: store.state.currentParams[oscNum].color,
                  ),
                  AmpFreqKnobs(
                    ampValue: store.state.currentParams[oscNum].opacityAmp,
                    ampMin: 0,
                    ampMax: 1,
                    ampCallback: (value) => store.dispatch(OpacityAmpCallback(oscNum, value)),
                    freqValue: store.state.currentParams[oscNum].opacityFreq,
                    freqMin: 1,
                    freqMax: 10,
                    freqCallback: (value) => store.dispatch(OpacityFreqCallback(oscNum, value)),
                    label: 'Opacity Mod',
                    color: store.state.currentParams[oscNum].color,
                  ),
                ]
              ),
            ),
          ]
        );
      }
    );
  }
}