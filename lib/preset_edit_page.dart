import 'package:flutter/material.dart';

import './preset_display.dart';
import './blend_presets_button.dart';
import './randomise_button.dart';
import './save_preset_button.dart';
import './current_params_guage_display.dart';
import './oscillator_panel.dart';


class PresetEditPage extends StatefulWidget {
  PresetEditPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PresetEditPageState createState() => _PresetEditPageState();
}

class _PresetEditPageState extends State<PresetEditPage>
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      persistentFooterButtons: <Widget>[
        RandomiseButton(),
        SavePresetButton(),
        BlendPresetsButton(),
      ],
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              height: 190,
              width: 200,
              child: Transform.scale(
                scale: 2,
                child: CurrentParamsGuageDisplay(_angleAnimation.value)
              )
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
