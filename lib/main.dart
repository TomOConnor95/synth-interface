import 'package:flutter/material.dart';
import './preset_gauge_display.dart';
import './oscillator_params.dart';
import './slider_tile.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  double _widthAmpSlider2 = 0.8;
  double _widthAmpSlider3 = 0.9;

  int _widthFreqSlider1 = 2;
  int _widthFreqSlider2 = 3;
  int _widthFreqSlider3 = 4;

  double _opacityAmpSlider1 = 0.7;
  double _opacityAmpSlider2 = 0.8;
  double _opacityAmpSlider3 = 0.9;

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

  Color _color1 = Colors.indigoAccent;
  Color _color2 = Colors.red;
  Color _color3 = Colors.green;

  var _oscillatorParams1 = OscillatorParams(
    0.6,
    2,
    0.7,
    3,
    0.2,
    4,
  );
  var _oscillatorParams2 = OscillatorParams(
    0.7,
    3,
    0.6,
    5,
    0.1,
    4,
  );
  var _oscillatorParams3 = OscillatorParams(
    0.8,
    4,
    0.1,
    3,
    0.1,
    10,
  );

  var _presets = new List<List<OscillatorParams>>();

  void _savePreset() {
    var _params1 = OscillatorParams(
    _lengthSlider1,
    _freqSlider1,
    _widthAmpSlider1,
    _widthFreqSlider1,
    _opacityAmpSlider1,
    _opacityFreqSlider1,
    );
    var _params2 = OscillatorParams(
      _lengthSlider2,
      _freqSlider2,
      _widthAmpSlider2,
      _widthFreqSlider2,
      _opacityAmpSlider2,
      _opacityFreqSlider2,
    );
    var _params3 = OscillatorParams(
      _lengthSlider3,
      _freqSlider3,
      _widthAmpSlider3,
      _widthFreqSlider3,
      _opacityAmpSlider3,
      _opacityFreqSlider3,
    );
    var preset = [_params1, _params2, _params3];

    setState(() => _presets.add(preset));
    // print(_presets);
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
                height: 170,
                width: 200,
                child: Transform.scale(
                    scale: 2,
                    child: presetGaugeDisplay(
                      _oscillatorParams1, _color1,
                      _oscillatorParams2, _color2,
                      _oscillatorParams3, _color3,
                      _angleAnimation.value,
                    ))),
            
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: savePresetButton,
            ),

            ExpansionTile(
              title: Text(
                'Oscillator 1',
                style: TextStyle(
                color: _color1,
                fontSize: 22,
                ),
              ),
              children: [
                SliderTile(_lengthSlider1, _color1, _lengthSlider1Callback, 'Length'),
                SliderTileInt(_freqSlider1, _color1, _freqSlider1Callback, 'Freq'),
                SliderTile(_widthAmpSlider1, _color1, _widthAmpSlider1Callback, 'WidthAmp'),
                SliderTileInt(_widthFreqSlider1, _color1, _widthFreqSlider1Callback, 'WidthFreq'),
                SliderTile(_opacityAmpSlider1, _color1, _opacityAmpSlider1Callback, 'OpacAmp'),
                SliderTileInt(_opacityFreqSlider1, _color1, _opacityFreqSlider1Callback, 'OpacFreq'),
              ]
            ),
            ExpansionTile(
              title: Text(
                'Oscillator 2',
                style: TextStyle(
                color: _color2,
                fontSize: 22,
                ),
              ),
              children: [
                SliderTile(_lengthSlider2, _color2, _lengthSlider2Callback, 'Length'),
                SliderTileInt(_freqSlider2, _color2, _freqSlider2Callback, 'Freq'),
                SliderTile(_widthAmpSlider2, _color2, _widthAmpSlider2Callback, 'WidthAmp'),
                SliderTileInt(_widthFreqSlider2, _color2, _widthFreqSlider2Callback, 'WidthFreq'),
                SliderTile(_opacityAmpSlider2, _color2, _opacityAmpSlider2Callback, 'OpacAmp'),
                SliderTileInt(_opacityFreqSlider2, _color2, _opacityFreqSlider2Callback, 'OpacFreq'),
              ]
            ),
            ExpansionTile(
              title: Text(
                'Oscillator 3',
                style: TextStyle(
                color: _color3,
                fontSize: 22,
                ),
              ),
              children: [
                SliderTile(_lengthSlider3, _color3, _lengthSlider3Callback, 'Length'),
                SliderTileInt(_freqSlider3, _color3, _freqSlider3Callback, 'Freq'),
                SliderTile(_widthAmpSlider3, _color3, _widthAmpSlider3Callback, 'WidthAmp'),
                SliderTileInt(_widthFreqSlider3, _color3, _widthFreqSlider3Callback, 'WidthFreq'),
                SliderTile(_opacityAmpSlider3, _color3, _opacityAmpSlider3Callback, 'OpacAmp'),
                SliderTileInt(_opacityFreqSlider3, _color3, _opacityFreqSlider3Callback, 'OpacFreq'),
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
                      title: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                '${_presets[position][0].length.toStringAsFixed(2)}',
                                // 'Hello',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: _color1,
                                ),
                              ),
                              Text(
                                '${_presets[position][1].length.toStringAsFixed(2)}',
                                // 'Hello',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: _color2,
                                ),
                              ),
                              Text(
                                '${_presets[position][2].length.toStringAsFixed(2)}',
                                // 'Hello',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: _color3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      leading: Container(
                        height: 70,
                        width: 70,
                        child: Transform.scale(
                            scale: 0.65,
                            child: presetGaugeDisplay(
                              _presets[position][0], _color1,
                              _presets[position][1], _color2,
                              _presets[position][2], _color3,
                              _angleAnimation.value,
                            )),
                      ),
                      onTap: () {
                        setState(() => _lengthSlider1 = _presets[position][0].length);
                        setState(() => _lengthSlider2 = _presets[position][1].length);
                        setState(() => _lengthSlider3 = _presets[position][2].length);

                        setState(() => _freqSlider1 = _presets[position][0].freq);
                        setState(() => _freqSlider2 = _presets[position][1].freq);
                        setState(() => _freqSlider3 = _presets[position][2].freq);

                        setState(() => _widthAmpSlider1 = _presets[position][0].widthAmp);
                        setState(() => _widthAmpSlider2 = _presets[position][1].widthAmp);
                        setState(() => _widthAmpSlider3 = _presets[position][2].widthAmp);

                        setState(() => _widthFreqSlider1 = _presets[position][0].widthFreq);
                        setState(() => _widthFreqSlider2 = _presets[position][1].widthFreq);
                        setState(() => _widthFreqSlider3 = _presets[position][2].widthFreq);

                        setState(() => _opacityAmpSlider1 = _presets[position][0].opacityAmp);
                        setState(() => _opacityAmpSlider2 = _presets[position][1].opacityAmp);
                        setState(() => _opacityAmpSlider3 = _presets[position][2].opacityAmp);

                        setState(() => _opacityFreqSlider1 = _presets[position][0].opacityFreq);
                        setState(() => _opacityFreqSlider2 = _presets[position][1].opacityFreq);
                        setState(() => _opacityFreqSlider3 = _presets[position][2].opacityFreq);

                        setState(() => _oscillatorParams1.length = _presets[position][0].length);
                        setState(() => _oscillatorParams2.length = _presets[position][1].length);
                        setState(() => _oscillatorParams3.length = _presets[position][2].length);

                        setState(() => _oscillatorParams1.widthAmp = _presets[position][0].widthAmp);
                        setState(() => _oscillatorParams2.widthAmp = _presets[position][1].widthAmp);
                        setState(() => _oscillatorParams3.widthAmp = _presets[position][2].widthAmp);

                        setState(() => _oscillatorParams1.widthFreq = _presets[position][0].widthFreq);
                        setState(() => _oscillatorParams2.widthFreq = _presets[position][1].widthFreq);
                        setState(() => _oscillatorParams3.widthFreq = _presets[position][2].widthFreq);

                        setState(() => _oscillatorParams1.opacityAmp = _presets[position][0].opacityAmp);
                        setState(() => _oscillatorParams2.opacityAmp = _presets[position][1].opacityAmp);
                        setState(() => _oscillatorParams3.opacityAmp = _presets[position][2].opacityAmp);

                        setState(() => _oscillatorParams1.opacityFreq = _presets[position][0].opacityFreq);
                        setState(() => _oscillatorParams2.opacityFreq = _presets[position][1].opacityFreq);
                        setState(() => _oscillatorParams3.opacityFreq = _presets[position][2].opacityFreq);
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
