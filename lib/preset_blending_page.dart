import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './preset_gauge_display.dart';

import './actions.dart';
import './redux_state.dart';

class PresetBlenderPage extends StatefulWidget {
  @override
  _PresetBlenderPageState createState() => _PresetBlenderPageState();
}

class _PresetBlenderPageState extends State<PresetBlenderPage>
    with SingleTickerProviderStateMixin {

  double _blendSliderValue = 0.5;

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
    super.dispose();
  }

  int presetSelectedLeft = 0;
  int presetSelectedRight = 1;
  
  double length;
  int freq;
  double widthAmp;
  int widthFreq;
  double opacityAmp;
  int opacityFreq;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preset Blender"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            StoreConnector<ReduxState, ReduxState>(
              converter: (store) => store.state,
              builder: (context, state) {
                return Container(
                // padding: EdgeInsets.only(bottom: 40),
                  child: Transform.scale(
                    scale: 2.5,
                    child: presetGaugeDisplay(
                      state.currentParams[0],
                      state.currentParams[1],
                      state.currentParams[2],
                      _angleAnimation.value,
                    ),
                  ),
                );
              }
            ),
            Row(
              children: <Widget>[
                StoreConnector<ReduxState, ReduxState>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    return ButtonTheme(
                      alignedDropdown: true,
                      child:DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: presetSelectedLeft,
                          elevation: 8,
                          items: List<DropdownMenuItem<int>>.generate(
                            state.savedPresets.length,
                            (int index) => DropdownMenuItem(
                              value: index,
                              child: Container(
                                width: 50,
                                height: 50,
                                child: Transform.scale(
                                  scale: index == presetSelectedLeft ? 0.7 : 0.5,
                                  child: presetGaugeDisplay(
                                    state.savedPresets[index][0], 
                                    state.savedPresets[index][1],
                                    state.savedPresets[index][2],
                                    _angleAnimation.value,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              presetSelectedLeft = value;
                            });
                          }
                        ),
                      ),
                    );
                  }
                ),
                StoreConnector<ReduxState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(BlendPresets(presetSelectedLeft, presetSelectedRight, _blendSliderValue));
                  },
                  builder: (context, callback) {
                    return Expanded(
                      child: Slider(
                        value: _blendSliderValue,
                        onChanged: (newValue) {
                          setState(() {
                            _blendSliderValue = newValue;             
                          });
                          callback();
                        },
                      ),
                    );
                  }
                ),
                StoreConnector<ReduxState, ReduxState>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    return ButtonTheme(
                      alignedDropdown: true,
                      child:DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: presetSelectedRight,
                          elevation: 8,
                          items: List<DropdownMenuItem<int>>.generate(
                            state.savedPresets.length,
                            (int index) => DropdownMenuItem(
                              value: index,
                              child: Container(
                                width: 50,
                                height: 50,
                                child: Transform.scale(
                                  scale: index == presetSelectedRight ? 0.7 : 0.5,
                                  child: presetGaugeDisplay(
                                    state.savedPresets[index][0], 
                                    state.savedPresets[index][1],
                                    state.savedPresets[index][2],
                                    _angleAnimation.value,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              presetSelectedRight = value;
                            });
                          }
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
            StoreConnector<ReduxState, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(SavePreset());
              },
              builder: (context, callback) {
                return RaisedButton(
                  onPressed: callback,
                  child: Text('Save Preset',
                    style: TextStyle(color: Colors.white)
                  ),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                );
              }
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
