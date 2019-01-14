import 'package:flutter/material.dart';
import './preset_gauge_display.dart';
import './oscillator_params.dart';
import './slider_tile.dart';
import './amp_freq_knobs.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Preset Editor'),
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

  double _lengthSlider1 = 0.3;
  double _lengthSlider2 = 0.7;
  double _lengthSlider3 = 0.8;

  int _freqSlider1 = 2;
  int _freqSlider2 = 3;
  int _freqSlider3 = 4;

  double _widthAmpSlider1 = 0.7;
  double _widthAmpSlider2 = 0.6;
  double _widthAmpSlider3 = 0.1;

  int _widthFreqSlider1 = 2;
  int _widthFreqSlider2 = 3;
  int _widthFreqSlider3 = 4;

  double _opacityAmpSlider1 = 0.1;
  double _opacityAmpSlider2 = 0.2;
  double _opacityAmpSlider3 = 0.2;

  int _opacityFreqSlider1 = 3;
  int _opacityFreqSlider2 = 4;
  int _opacityFreqSlider3 = 5;
  
  _lengthSlider1Callback(newValue) {
    setState(() => _lengthSlider1 = newValue);
    setState(() => _oscillatorParams1.length = newValue);
  }
  _lengthSlider2Callback(newValue) {
    setState(() => _lengthSlider2 = newValue);
    setState(() => _oscillatorParams2.length = newValue);
  }
  _lengthSlider3Callback(newValue) {
    setState(() => _lengthSlider3 = newValue);
    setState(() => _oscillatorParams3.length = newValue);
  }

  _freqSlider1Callback(newValue) {
    setState(() => _freqSlider1 = newValue);
    setState(() => _oscillatorParams1.freq = newValue);
  }
  _freqSlider2Callback(newValue) {
    setState(() => _freqSlider2 = newValue);
    setState(() => _oscillatorParams2.freq = newValue);
  }
  _freqSlider3Callback(newValue) {
    setState(() => _freqSlider3 = newValue);
    setState(() => _oscillatorParams3.freq = newValue);
  }

  _widthAmpSlider1Callback(newValue) {
    setState(() => _widthAmpSlider1 = newValue);
    setState(() => _oscillatorParams1.widthAmp = newValue);
  }
  _widthAmpSlider2Callback(newValue) {
    setState(() => _widthAmpSlider2 = newValue);
    setState(() => _oscillatorParams2.widthAmp = newValue);
  }
  _widthAmpSlider3Callback(newValue) {
    setState(() => _widthAmpSlider3 = newValue);
    setState(() => _oscillatorParams3.widthAmp = newValue);
  }

  _widthFreqSlider1Callback(newValue) {
    setState(() => _widthFreqSlider1 = newValue);
    setState(() => _oscillatorParams1.widthFreq = newValue);
  }
  _widthFreqSlider2Callback(newValue) {
    setState(() => _widthFreqSlider2 = newValue);
    setState(() => _oscillatorParams2.widthFreq = newValue);
  }
  _widthFreqSlider3Callback(newValue) {
    setState(() => _widthFreqSlider3 = newValue);
    setState(() => _oscillatorParams3.widthFreq = newValue);
  }

  _opacityAmpSlider1Callback(newValue) {
    setState(() => _opacityAmpSlider1 = newValue);
    setState(() => _oscillatorParams1.opacityAmp = newValue);
  }
  _opacityAmpSlider2Callback(newValue) {
    setState(() => _opacityAmpSlider2 = newValue);
    setState(() => _oscillatorParams2.opacityAmp = newValue);
  }
  _opacityAmpSlider3Callback(newValue) {
    setState(() => _opacityAmpSlider3 = newValue);
    setState(() => _oscillatorParams3.opacityAmp = newValue);
  }

  _opacityFreqSlider1Callback(newValue) {
    setState(() => _opacityFreqSlider1 = newValue);
    setState(() => _oscillatorParams1.opacityFreq = newValue);
  }
   _opacityFreqSlider2Callback(newValue) {
    setState(() => _opacityFreqSlider2 = newValue);
    setState(() => _oscillatorParams2.opacityFreq = newValue);
  }
   _opacityFreqSlider3Callback(newValue) {
    setState(() => _opacityFreqSlider3 = newValue);
    setState(() => _oscillatorParams3.opacityFreq = newValue);
  }


  var _oscillatorParams1 = OscillatorParams(
    length: 0.3,
    freq: 2,
    widthAmp: 0.7,
    widthFreq: 3,
    opacityAmp: 0.2,
    opacityFreq: 4,
    color: Colors.indigoAccent,
  );
  var _oscillatorParams2 = OscillatorParams(
    length: 0.7,
    freq: 3,
    widthAmp: 0.6,
    widthFreq: 5,
    opacityAmp: 0.1,
    opacityFreq: 4,
    color: Colors.red,
  );
  var _oscillatorParams3 = OscillatorParams(
    length: 0.8,
    freq: 4,
    widthAmp: 0.1,
    widthFreq: 3,
    opacityAmp: 0.1,
    opacityFreq: 10, 
    color: Colors.green,
  );

  Color _color1 = Colors.indigoAccent;
  Color _color2 = Colors.red;
  Color _color3 = Colors.green;

  ValueChanged<Color> onColorChanged;
  changeColor1(Color color) {
    setState(() => _color1 = color);
    setState(() => _oscillatorParams1.color = color);
  }
  changeColor2(Color color) {
    setState(() => _color2 = color);
    setState(() => _oscillatorParams2.color = color);
  }
  changeColor3(Color color) {
    setState(() => _color3 = color);
    setState(() => _oscillatorParams3.color = color);
  }

  var _presets = new List<List<OscillatorParams>>();

  void _savePreset() {
    var _params1 = OscillatorParams(
      length: _lengthSlider1,
      freq: _freqSlider1,
      widthAmp: _widthAmpSlider1,
      widthFreq: _widthFreqSlider1,
      opacityAmp: _opacityAmpSlider1,
      opacityFreq: _opacityFreqSlider1,
      color: _color1,
    );
    var _params2 = OscillatorParams(
      length: _lengthSlider2,
      freq: _freqSlider2,
      widthAmp: _widthAmpSlider2,
      widthFreq: _widthFreqSlider2,
      opacityAmp: _opacityAmpSlider2,
      opacityFreq: _opacityFreqSlider2,
      color: _color2,
    );
    var _params3 = OscillatorParams(
      length: _lengthSlider3,
      freq: _freqSlider3,
      widthAmp: _widthAmpSlider3,
      widthFreq: _widthFreqSlider3,
      opacityAmp: _opacityAmpSlider3,
      opacityFreq: _opacityFreqSlider3,
      color: _color3,
    );
    var preset = [_params1, _params2, _params3];

    setState(() => _presets.add(preset));
  }

  Widget get savePresetButton {
    return RaisedButton(
      onPressed: _savePreset,
      child: Text('Save Preset'),
      color: Colors.lightBlueAccent,
    );
  }

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
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 15),
                height: 170,
                width: 200,
                child: Transform.scale(
                    scale: 2,
                    child: presetGaugeDisplay(
                      _oscillatorParams1,
                      _oscillatorParams2,
                      _oscillatorParams3,
                      _angleAnimation.value,
                    ))),
            
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: savePresetButton,
            ),

            ExpansionTile(
              title: Row(
                children: <Widget> [
                  Text(
                    'Oscillator 1',
                    style: TextStyle(
                    color: _oscillatorParams1.color,
                    fontSize: 22,
                    ),
                  ),
                  RaisedButton(
                    shape: CircleBorder(),
                    elevation: 3.0,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0.0),
                            contentPadding: const EdgeInsets.all(0.0),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: _oscillatorParams1.color,
                                onColorChanged: changeColor1,
                                colorPickerWidth: 1000.0,
                                pickerAreaHeightPercent: 0.7,
                                enableAlpha: false,
                                enableLabel: false,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(Icons.color_lens,
                      color: useWhiteForeground(_oscillatorParams1.color)
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                    ),
                    color: _oscillatorParams1.color, 
                  ),
                ]
              ),
              children: [
                SliderTile(_lengthSlider1, _oscillatorParams1.color, _lengthSlider1Callback, 'Length'),
                SliderTileInt(_freqSlider1, _oscillatorParams1.color, _freqSlider1Callback, 'Freq'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AmpFreqKnobs(
                        ampValue: _widthAmpSlider1,
                        ampMin: 0,
                        ampMax: 1,
                        ampCallback: _widthAmpSlider1Callback,
                        freqValue: _widthFreqSlider1,
                        freqMin: 0,
                        freqMax: 10,
                        freqCallback: _widthFreqSlider1Callback,
                        label: 'Width Mod',
                        color: _oscillatorParams1.color,
                      ),
                      AmpFreqKnobs(
                        ampValue: _opacityAmpSlider1,
                        ampMin: 0,
                        ampMax: 1,
                        ampCallback: _opacityAmpSlider1Callback,
                        freqValue: _opacityFreqSlider1,
                        freqMin: 0,
                        freqMax: 10,
                        freqCallback: _opacityFreqSlider1Callback,
                        label: 'Opacity Mod',
                        color: _oscillatorParams1.color,
                      ),
                    ]
                  ),
                ),
              ]
            ),
            ExpansionTile(
              title: Row(
                children: <Widget> [
                  Text(
                    'Oscillator 2',
                    style: TextStyle(
                    color: _oscillatorParams2.color,
                    fontSize: 22,
                    ),
                  ),
                  RaisedButton(
                    shape: CircleBorder(),
                    elevation: 3.0,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0.0),
                            contentPadding: const EdgeInsets.all(0.0),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: _oscillatorParams2.color,
                                onColorChanged: changeColor2,
                                colorPickerWidth: 1000.0,
                                pickerAreaHeightPercent: 0.7,
                                enableAlpha: false,
                                enableLabel: false,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(Icons.color_lens,
                      color: useWhiteForeground(_oscillatorParams2.color)
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                    ),
                    color: _oscillatorParams2.color, 
                  ),
                ]
              ),
              children: [
                SliderTile(_lengthSlider2, _oscillatorParams2.color, _lengthSlider2Callback, 'Length'),
                SliderTileInt(_freqSlider2, _oscillatorParams2.color, _freqSlider2Callback, 'Freq'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AmpFreqKnobs(
                        ampValue: _widthAmpSlider2,
                        ampMin: 0,
                        ampMax: 1,
                        ampCallback: _widthAmpSlider2Callback,
                        freqValue: _widthFreqSlider2,
                        freqMin: 0,
                        freqMax: 10,
                        freqCallback: _widthFreqSlider2Callback,
                        label: 'Width Mod',
                        color: _oscillatorParams2.color,
                      ),
                      AmpFreqKnobs(
                        ampValue: _opacityAmpSlider2,
                        ampMin: 0,
                        ampMax: 1,
                        ampCallback: _opacityAmpSlider2Callback,
                        freqValue: _opacityFreqSlider2,
                        freqMin: 0,
                        freqMax: 10,
                        freqCallback: _opacityFreqSlider2Callback,
                        label: 'Opacity Mod',
                        color: _oscillatorParams2.color,
                      ),
                    ]
                  ),
                ),
              ]
            ),
            ExpansionTile(
              title: Row(
                children: <Widget> [
                  Text(
                    'Oscillator 3',
                    style: TextStyle(
                    color: _oscillatorParams3.color,
                    fontSize: 22,
                    ),
                  ),
                  RaisedButton(
                    shape: CircleBorder(),
                    elevation: 3.0,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.all(0.0),
                            contentPadding: const EdgeInsets.all(0.0),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: _oscillatorParams3.color,
                                onColorChanged: changeColor3,
                                colorPickerWidth: 1000.0,
                                pickerAreaHeightPercent: 0.7,
                                enableAlpha: false,
                                enableLabel: false,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(Icons.color_lens,
                      color: useWhiteForeground(_oscillatorParams3.color)
                        ? const Color(0xffffffff)
                        : const Color(0xff000000),
                    ),
                    color: _oscillatorParams3.color, 
                  ),
                ]
              ),
              children: [
                SliderTile(_lengthSlider3, _oscillatorParams3.color, _lengthSlider3Callback, 'Length'),
                SliderTileInt(_freqSlider3, _oscillatorParams3.color, _freqSlider3Callback, 'Freq'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AmpFreqKnobs(
                        ampValue: _widthAmpSlider3,
                        ampMin: 0,
                        ampMax: 1,
                        ampCallback: _widthAmpSlider3Callback,
                        freqValue: _widthFreqSlider3,
                        freqMin: 0,
                        freqMax: 10,
                        freqCallback: _widthFreqSlider3Callback,
                        label: 'Width Mod',
                        color: _oscillatorParams3.color,
                      ),
                      AmpFreqKnobs(
                        ampValue: _opacityAmpSlider3,
                        ampMin: 0,
                        ampMax: 1,
                        ampCallback: _opacityAmpSlider3Callback,
                        freqValue: _opacityFreqSlider3,
                        freqMin: 0,
                        freqMax: 10,
                        freqCallback: _opacityFreqSlider3Callback,
                        label: 'Opacity Mod',
                        color: _oscillatorParams3.color,
                      ),
                    ]
                  ),
                ),
              ]
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
              itemCount: _presets.length,
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
                              _presets[position][0],
                              _presets[position][1],
                              _presets[position][2],
                              _angleAnimation.value,
                            )),
                      ),
                      onTap: () {
                        setState(() {
                          _lengthSlider1 = _presets[position][0].length;
                          _lengthSlider2 = _presets[position][1].length;
                          _lengthSlider3 = _presets[position][2].length;

                          _freqSlider1 = _presets[position][0].freq;
                          _freqSlider2 = _presets[position][1].freq;
                          _freqSlider3 = _presets[position][2].freq;

                          _widthAmpSlider1 = _presets[position][0].widthAmp;
                          _widthAmpSlider2 = _presets[position][1].widthAmp;
                          _widthAmpSlider3 = _presets[position][2].widthAmp;

                          _widthFreqSlider1 = _presets[position][0].widthFreq;
                          _widthFreqSlider2 = _presets[position][1].widthFreq;
                          _widthFreqSlider3 = _presets[position][2].widthFreq;

                          _opacityAmpSlider1 = _presets[position][0].opacityAmp;
                          _opacityAmpSlider2 = _presets[position][1].opacityAmp;
                          _opacityAmpSlider3 = _presets[position][2].opacityAmp;

                          _opacityFreqSlider1 = _presets[position][0].opacityFreq;
                          _opacityFreqSlider2 = _presets[position][1].opacityFreq;
                          _opacityFreqSlider3 = _presets[position][2].opacityFreq;

                          _color1 = _presets[position][0].color;
                          _color2 = _presets[position][1].color;
                          _color3 = _presets[position][2].color;

                          _oscillatorParams1.length = _presets[position][0].length;
                          _oscillatorParams2.length = _presets[position][1].length;
                          _oscillatorParams3.length = _presets[position][2].length;

                          _oscillatorParams1.widthAmp = _presets[position][0].widthAmp;
                          _oscillatorParams2.widthAmp = _presets[position][1].widthAmp;
                          _oscillatorParams3.widthAmp = _presets[position][2].widthAmp;

                          _oscillatorParams1.widthFreq = _presets[position][0].widthFreq;
                          _oscillatorParams2.widthFreq = _presets[position][1].widthFreq;
                          _oscillatorParams3.widthFreq = _presets[position][2].widthFreq;

                          _oscillatorParams1.opacityAmp = _presets[position][0].opacityAmp;
                          _oscillatorParams2.opacityAmp = _presets[position][1].opacityAmp;
                          _oscillatorParams3.opacityAmp = _presets[position][2].opacityAmp;

                          _oscillatorParams1.opacityFreq = _presets[position][0].opacityFreq;
                          _oscillatorParams2.opacityFreq = _presets[position][1].opacityFreq;
                          _oscillatorParams3.opacityFreq = _presets[position][2].opacityFreq;

                          _oscillatorParams1.color = _presets[position][0].color;
                          _oscillatorParams2.color = _presets[position][1].color;
                          _oscillatorParams3.color = _presets[position][2].color;
                        });
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          setState(() {
                            _presets.removeAt(position);
                          });
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
