import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'dart:convert';

import './preset_gauge_display.dart';
import './oscillator_params.dart';
import './slider_tile.dart';
import './amp_freq_knobs.dart';
import './oscillator_title_row.dart';
import './preset_blending_page.dart';

import './actions.dart';
import './redux_state.dart';


ReduxState counterReducer(ReduxState state, dynamic action) {
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
      state.currentParams[0] = randomOscillatorParams();
    } else if (action.oscillatorToRandomise == 2) {
      state.currentParams[0] = randomOscillatorParams();
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
  if (action is BlendPresets) {
    state.currentParams = [
      lerpOscillatorParams(state.savedPresets[action.presetNumberA][0], state.savedPresets[action.presetNumberB][0], action.blendValue),
      lerpOscillatorParams(state.savedPresets[action.presetNumberA][1], state.savedPresets[action.presetNumberB][1], action.blendValue),
      lerpOscillatorParams(state.savedPresets[action.presetNumberA][2], state.savedPresets[action.presetNumberB][2], action.blendValue),
    ];
  }

  sendParametersToSynth(state.channel, state.currentParams);
  return state;
}

void main() {

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
  
  final store = Store<ReduxState>(
      counterReducer,
      initialState: ReduxState(
        initialParams,
        [],
        IOWebSocketChannel.connect('ws://127.0.0.1:6666'),
      )
    );
  runApp(MyApp(
    store: store,
  ));
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
      },
      'oscillator2': {
        'length': preset[1].length,
        'freq': preset[1].freq,
        'widthAmp': preset[1].widthAmp,
        'widthFreq': preset[1].widthFreq,
        'opacityAmp': preset[1].opacityAmp,
        'opacityFreq': preset[1].opacityFreq,
      },
      'oscillator3': {
        'length': preset[2].length,
        'freq': preset[2].freq,
        'widthAmp': preset[2].widthAmp,
        'widthFreq': preset[2].widthFreq,
        'opacityAmp': preset[2].opacityAmp,
        'opacityFreq': preset[2].opacityFreq,
      }
    };
    
    channel.sink.add(json.encode(paramsToSend));
  } 

class MyApp extends StatelessWidget {
  MyApp({this.store});

  final Store<ReduxState> store;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<ReduxState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          title: 'Preset Editor',
        ),
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  Animation<double> _angleAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 6000), vsync: this);
    _angleAnimation = new Tween(begin: 0.0, end: 360.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    _angleAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   widget.channel.sink.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      persistentFooterButtons: <Widget>[
        StoreConnector<ReduxState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(RandomiseParameters());
          },
          builder: (context, callback) {
            return RaisedButton(
              onPressed: callback,
              child: Text('Randomise',
                style: TextStyle(color: Colors.white)
              ),
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
            );
          },
          onDispose: (store) => store.state.channel.sink.close()
        ),
        StoreConnector<ReduxState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(SavePreset());
          },
          builder: (context, callback) {
            return RaisedButton(
              child: Text('Save Preset',
                style: TextStyle(color: Colors.white)
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              onPressed: () {
                callback();
              }
            );
          },
        ),

        StoreConnector<ReduxState, ReduxState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return RaisedButton(
              child: Text('Blend Presets',
                style: TextStyle(color: Colors.white)
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              // Do this check based on redux state
              onPressed: (state.savedPresets.length < 2) ? null : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PresetBlenderPage(),
                  ),
                );
              },
            );
          }
        ),
      ],
      body: Center(
        child: ListView(
          children: <Widget>[
            StoreConnector<ReduxState, ReduxState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  height: 190,
                  width: 200,
                  child: Transform.scale(
                    scale: 2,
                    child: presetGaugeDisplay(
                      state.currentParams[0],
                      state.currentParams[1],
                      state.currentParams[2],
                      _angleAnimation.value,
                    )
                  )
                );
              }
            ),
            OscillatorPanel(0),
            OscillatorPanel(1),
            OscillatorPanel(2),
            PresetDisplay(
              _angleAnimation.value, 
            ),
          ],
        ),
      ),
    );
  }
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
                    freqMin: 0,
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
                    freqMin: 0,
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
class PresetDisplay extends StatelessWidget {
  final double animationAngle;

  @override
  PresetDisplay(this.animationAngle);

  Widget build(BuildContext context) {
    return StoreConnector<ReduxState, Store<ReduxState>>(
      converter: (store) => store,
      builder: (context, store) {
        return SizedBox(
          height: store.state.savedPresets.length * 70.0,
          child: ListView.builder(
            itemCount: store.state.savedPresets.length,
            padding: const EdgeInsets.all(3.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.0),
                  ListTile(
                    title: Text('Preset ${position + 1}',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.blue,
                      ),
                    ),
                    leading: Container(
                      height: 70,
                      width: 70,
                      child: Transform.scale(
                        scale: 0.65,
                        child: presetGaugeDisplay(
                          store.state.savedPresets[position][0],
                          store.state.savedPresets[position][1],
                          store.state.savedPresets[position][2],
                          animationAngle,
                        )
                      ),
                    ),
                    onTap: () => store.dispatch(RecallPreset(position)),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => store.dispatch(DeletePreset(position))
                    ),
                  ),
                ],
              );
            }
          ),
        );
      },
    );
  }
}
