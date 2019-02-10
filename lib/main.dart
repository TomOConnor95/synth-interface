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

class ReduxState {
  var currentParams;
  var savedPresets;

  ReduxState(this.currentParams, this.savedPresets);
}

ReduxState counterReducer(ReduxState state, dynamic action) {
  if (action is SavePreset) {
    var newPreset = deepCopyPreset(state.currentParams);
    state.savedPresets.add(newPreset);
    return state;
  }
  if (action is RecallPreset) {
    var newPreset = deepCopyPreset(state.savedPresets[action.presetNumber]);
    state.currentParams = newPreset;
    return state;
  }
  if (action is LengthCallback) {
    state.currentParams[action.oscillatorNumber].length = action.value;
    return state;
  }
  if (action is FreqCallback) {
    state.currentParams[action.oscillatorNumber].freq = action.value;
    return state;
  }
  if (action is WidthAmpCallback) {
    state.currentParams[action.oscillatorNumber].widthAmp = action.value;
    return state;
  }
  if (action is WidthFreqCallback) {
    state.currentParams[action.oscillatorNumber].widthFreq = action.value;
    return state;
  }
  if (action is OpacityAmpCallback) {
    state.currentParams[action.oscillatorNumber].opacityAmp = action.value;
    return state;
  }
  if (action is OpacityFreqCallback) {
    state.currentParams[action.oscillatorNumber].opacityFreq = action.value;
    return state;
  }
  if (action is ColorCallback) {
    state.currentParams[action.oscillatorNumber].color = action.value;
    return state;
  }

  // need to add reducers for randomising parameters

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
        []
      )
    );
  runApp(MyApp(
    store: store,
  ));
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
          channel: IOWebSocketChannel.connect('ws://127.0.0.1:6666'),
        ),
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, @required this.channel}) : super(key: key);

  final WebSocketChannel channel;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  
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

  // void _randomiseParameters({int oscillatorNum}) {
  //   OscillatorParams _params1;
  //   OscillatorParams _params2;
  //   OscillatorParams _params3;
    
  //   if (oscillatorNum == 1) {
  //     _params1 = randomOscillatorParams();
  //     setState(() {
  //       _oscillatorParams1 = _params1;
  //     });
  //     updateOscillatorInputElements1(_params1);
  //   } else if (oscillatorNum == 2) {
  //     _params2 = randomOscillatorParams();
  //     setState(() {
  //       _oscillatorParams2 = _params2;
  //     });
  //     updateOscillatorInputElements2(_params2);
  //   } else if (oscillatorNum == 3) {
  //     _params3 = randomOscillatorParams();
  //     setState(() {
  //       _oscillatorParams3 = _params3;
  //     });
  //     updateOscillatorInputElements3(_params3);
  //   } else {
  //     _params1 = randomOscillatorParams();
  //     _params2 = randomOscillatorParams();
  //     _params3 = randomOscillatorParams();
  //     setState(() {
  //       _oscillatorParams1 = _params1;
  //       _oscillatorParams2 = _params2;
  //       _oscillatorParams3 = _params3;
  //     });
  //     updateAllInputElements(
  //       _params1,
  //       _params2,
  //       _params3,
  //     );
  //   }
  //   sendParametersToSynth(widget.channel, _presetFromParams());
  // }

  // bool _isBlendPresetButtonDisabled = true;

  // void enablePresetBlendingIfNecessary(){
  //   if (_presets.length >= 2){
  //     _isBlendPresetButtonDisabled = false;
  //   } else {
  //     _isBlendPresetButtonDisabled = true;
  //   }
  // }

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

  @override
  void dispose() {
    _controller.dispose();
    widget.channel.sink.close();
    super.dispose();
  }

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
        // RaisedButton(
        //   onPressed: _randomiseParameters,
        //   child: Text('Randomise',
        //     style: TextStyle(color: Colors.white)
        //   ),
        //   color: Colors.red,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10.0)
        //   ),
        // ),
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

        // RaisedButton(
        //   child: Text('Blend Presets',
        //     style: TextStyle(color: Colors.white)
        //   ),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(30.0)
        //   ),
        //   // Do this check based on redux state
        //   onPressed: _isBlendPresetButtonDisabled ? null : () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => PresetBlenderPage(
        //           _presets,
        //           _savePreset,
        //           (preset) {
        //             sendParametersToSynth(widget.channel, preset);
        //           },
        //         ),
        //       ),
        //     );
        //   },
        // ),
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
            onShufflePressed: (
            ) => {},
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
                    onTap: () => store.dispatch(RecallPreset(position))
                    // trailing: IconButton(
                    //   icon: const Icon(Icons.remove_circle_outline),
                    //   onPressed: () {
                    //     setState(() {
                    //       _presets.removeAt(position);
                    //     });
                    //     enablePresetBlendingIfNecessary();
                    //   },
                    // ),
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
