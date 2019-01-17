import 'package:flutter/material.dart';
import './preset_gauge_display.dart';
import './oscillator_params.dart';

class PresetBlenderPage extends StatefulWidget {
  PresetBlenderPage(this.presets);

  final List<List<OscillatorParams>> presets;

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
                  lerpOscillatorParams(widget.presets[0][0], widget.presets[1][0], _blendSliderValue), 
                  lerpOscillatorParams(widget.presets[0][1], widget.presets[1][1], _blendSliderValue),
                  lerpOscillatorParams(widget.presets[0][2], widget.presets[1][2], _blendSliderValue),
                  _angleAnimation.value,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Transform.scale(
                  scale: 0.8,
                  child: presetGaugeDisplay(
                    widget.presets[0][0], 
                    widget.presets[0][1],
                    widget.presets[0][2],
                    _angleAnimation.value,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: _blendSliderValue,
                    onChanged: (newValue) {
                      setState(() {
                        _blendSliderValue = newValue;             
                      });
                    },
                    
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: presetGaugeDisplay(
                    widget.presets[1][0], 
                    widget.presets[1][1],
                    widget.presets[1][2],
                    _angleAnimation.value,
                  ),
                ),
              ],
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
    