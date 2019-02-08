import 'package:flutter/material.dart';
import './preset_gauge_display.dart';
import './oscillator_params.dart';

class PresetBlenderPage extends StatefulWidget {
  PresetBlenderPage(this.presets, this.savePreset, this.sendParametersToSynth);

  final List<List<OscillatorParams>> presets;
  @required final void Function(List<OscillatorParams>) savePreset;
  @required final void Function(List<OscillatorParams>) sendParametersToSynth;

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
            Container(
              // padding: EdgeInsets.only(bottom: 40),
              child: Transform.scale(
                scale: 2.5,
                child: presetGaugeDisplay(
                  lerpOscillatorParams(widget.presets[presetSelectedLeft][0], widget.presets[presetSelectedRight][0], _blendSliderValue), 
                  lerpOscillatorParams(widget.presets[presetSelectedLeft][1], widget.presets[presetSelectedRight][1], _blendSliderValue),
                  lerpOscillatorParams(widget.presets[presetSelectedLeft][2], widget.presets[presetSelectedRight][2], _blendSliderValue),
                  _angleAnimation.value,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                ButtonTheme(
                  alignedDropdown: true,
                  child:DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: presetSelectedLeft,
                      elevation: 8,
                      items: List<DropdownMenuItem<int>>.generate(
                        widget.presets.length,
                        (int index) => DropdownMenuItem(
                          value: index,
                          child: Container(
                            width: 50,
                            height: 50,
                            child: Transform.scale(
                              scale: index == presetSelectedLeft ? 0.7 : 0.5,
                              child: presetGaugeDisplay(
                                widget.presets[index][0], 
                                widget.presets[index][1],
                                widget.presets[index][2],
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
                        widget.sendParametersToSynth([
                          lerpOscillatorParams(widget.presets[presetSelectedLeft][0], widget.presets[presetSelectedRight][0], _blendSliderValue),
                          lerpOscillatorParams(widget.presets[presetSelectedLeft][1], widget.presets[presetSelectedRight][1], _blendSliderValue),
                          lerpOscillatorParams(widget.presets[presetSelectedLeft][2], widget.presets[presetSelectedRight][2], _blendSliderValue),
                        ]);
                      }
                    ),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: _blendSliderValue,
                    onChanged: (newValue) {
                      setState(() {
                        _blendSliderValue = newValue;             
                      });
                      widget.sendParametersToSynth([
                        lerpOscillatorParams(widget.presets[presetSelectedLeft][0], widget.presets[presetSelectedRight][0], _blendSliderValue),
                        lerpOscillatorParams(widget.presets[presetSelectedLeft][1], widget.presets[presetSelectedRight][1], _blendSliderValue),
                        lerpOscillatorParams(widget.presets[presetSelectedLeft][2], widget.presets[presetSelectedRight][2], _blendSliderValue),
                      ]);
                    },
                  ),
                ),
                ButtonTheme(
                  alignedDropdown: true,
                  child:DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: presetSelectedRight,
                      elevation: 8,
                      items: List<DropdownMenuItem<int>>.generate(
                        widget.presets.length,
                        (int index) => DropdownMenuItem(
                          value: index,
                          child: Container(
                            width: 50,
                            height: 50,
                            child: Transform.scale(
                              scale: index == presetSelectedRight ? 0.7 : 0.5,
                              child: presetGaugeDisplay(
                                widget.presets[index][0], 
                                widget.presets[index][1],
                                widget.presets[index][2],
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
                        widget.sendParametersToSynth([
                          lerpOscillatorParams(widget.presets[presetSelectedLeft][0], widget.presets[presetSelectedRight][0], _blendSliderValue),
                          lerpOscillatorParams(widget.presets[presetSelectedLeft][1], widget.presets[presetSelectedRight][1], _blendSliderValue),
                          lerpOscillatorParams(widget.presets[presetSelectedLeft][2], widget.presets[presetSelectedRight][2], _blendSliderValue),
                        ]);
                      }
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: () => widget.savePreset(
                [
                  lerpOscillatorParams(widget.presets[presetSelectedLeft][0], widget.presets[presetSelectedRight][0], _blendSliderValue),
                  lerpOscillatorParams(widget.presets[presetSelectedLeft][1], widget.presets[presetSelectedRight][1], _blendSliderValue),
                  lerpOscillatorParams(widget.presets[presetSelectedLeft][2], widget.presets[presetSelectedRight][2], _blendSliderValue),
                ]
              ),
              child: Text('Save Preset',
                style: TextStyle(color: Colors.white)
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
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
