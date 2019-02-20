import 'package:flutter/material.dart';

import './preset_display.dart';
import './blend_presets_button.dart';
import './randomise_button.dart';
import './save_preset_button.dart';
import './current_params_guage_display.dart';
import './oscillator_panel.dart';


class PresetEditPage extends StatelessWidget {
  PresetEditPage({Key key, this.title}) : super(key: key);

  final String title;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                child: CurrentParamsGuageDisplay()
              )
            ),
            OscillatorPanel(0),
            OscillatorPanel(1),
            OscillatorPanel(2),
            PresetDisplay(),
          ],
        ),
      ),
    );
  }
}
