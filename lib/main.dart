import 'package:flutter/material.dart';
import './preset_gauge_display.dart';
import './oscillator_params.dart';

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
  double _lengthSlider1 = 0.6;
  double _lengthSlider2 = 0.7;
  double _lengthSlider3 = 0.8;

  double _widthAmpSlider1 = 0.7;
  double _widthAmpSlider2 = 0.8;
  double _widthAmpSlider3 = 0.9;

  int _widthFreqSlider1 = 2;

  Color _color1 = Colors.indigoAccent;
  Color _color2 = Colors.red;
  Color _color3 = Colors.green;

  var _oscillatorParams1 = OscillatorParams(
    0.6,
    0.7,
    3,
    0.2,
    4,
  );

  var _oscillatorParams2 = OscillatorParams(
    0.7,
    0.6,
    5,
    0.1,
    4,
  );

  var _oscillatorParams3 = OscillatorParams(
    0.8,
    0.1,
    3,
    0.1,
    10,
  );

  var _presets = new List<List<OscillatorParams>>();

  Animation<double> _angleAnimation;
  AnimationController _controller;

  void _savePreset() {
    var _params1 = OscillatorParams(
    _lengthSlider1,
    _widthAmpSlider1,
    3,
    0.2,
    4,
  );
  var _params2 = OscillatorParams(
    _lengthSlider2,
    _widthAmpSlider2,
    5,
    0.1,
    4,
  );

  var _params3 = OscillatorParams(
    _lengthSlider3,
    _widthAmpSlider3,
    3,
    0.1,
    10,
  );
    var preset = [_params1, _params2, _params3];

    setState(() => _presets.add(preset));
    print(_presets);
  }

  Widget get savePresetButton {
    return RaisedButton(
      onPressed: _savePreset,
      child: Text('Save Preset'),
      color: Colors.lightBlueAccent,
    );
  }
Widget ParameterValueDisplay (value, Color color){
  return Container(
    width: 60,
    child: Text(
      '${value is int ? value : value.toStringAsFixed(2)}',
      style: TextStyle(
        color: color,
        fontSize: 22,
      ),
    )
  );
}

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
        duration: const Duration(milliseconds: 8000), vsync: this);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                ListTile(
                  contentPadding: EdgeInsets.only(left: 16),
                  dense: true,
                  leading: Text(
                    'Length',
                    style: TextStyle(
                    color: _color1,
                    fontSize: 20,
                    ),
                  ),
                  trailing: ParameterValueDisplay(_lengthSlider1, _color1),
                  title: Slider(
                    activeColor: _color1,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (newValue) {
                      setState(() => _lengthSlider1 = newValue);
                      setState(() => _oscillatorParams1.length = newValue);
                    },
                    value: _lengthSlider1,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 16),
                  dense: true,
                  leading: Text(
                    'WidthAmp',
                    style: TextStyle(
                    color: _color1,
                    fontSize: 20,
                    ),
                  ),
                  trailing: ParameterValueDisplay(_widthAmpSlider1, _color1),
                  title: Slider(
                    activeColor: _color1,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (newValue) {
                      setState(() => _widthAmpSlider1 = newValue);
                      setState(() => _oscillatorParams1.widthAmp = newValue);
                    },
                    value: _widthAmpSlider1,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 16),
                  dense: true,
                  leading: Text(
                    'WidthFreq',
                    style: TextStyle(
                    color: _color1,
                    fontSize: 20,
                    ),
                  ),
                  trailing: ParameterValueDisplay(_widthFreqSlider1, _color1),
                  title: Slider(
                    activeColor: _color1,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    onChanged: (newValue) {
                      setState(() => _widthFreqSlider1 = newValue.toInt());
                      setState(() => _oscillatorParams1.widthFreq = newValue.toInt());
                    },
                    value: _widthFreqSlider1.toDouble(),
                  ),
                ),
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
                ListTile(
                  contentPadding: EdgeInsets.only(left: 16),
                  dense: true,
                  leading: Text(
                    'Length',
                    style: TextStyle(
                    color: _color2,
                    fontSize: 20,
                    ),
                  ),
                  trailing: ParameterValueDisplay(_lengthSlider2, _color2),
                  title: Slider(
                      activeColor: _color2,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (newValue) {
                        setState(() => _lengthSlider2 = newValue);
                        setState(() => _oscillatorParams2.length = newValue);
                      },
                      value: _lengthSlider2,
                    ),
                  ),
                ],
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
                ListTile(
                  contentPadding: EdgeInsets.only(left: 16),
                  dense: true,
                  leading: Text(
                    'Length',
                    style: TextStyle(
                    color: _color3,
                    fontSize: 20,
                    ),
                  ),
                  trailing: ParameterValueDisplay(_lengthSlider3, _color3),
                  title: Slider(
                      activeColor: _color3,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (newValue) {
                        setState(() => _lengthSlider3 = newValue);
                        setState(() => _oscillatorParams3.length = newValue);
                      },
                      value: _lengthSlider3,
                    ),
                  ),
                ],
            ),
            Expanded(
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

                        setState(() => _widthAmpSlider1 = _presets[position][0].widthAmp);

                        setState(() => _oscillatorParams1.length = _presets[position][0].length);
                        setState(() => _oscillatorParams2.length = _presets[position][1].length);
                        setState(() => _oscillatorParams3.length = _presets[position][2].length);

                        setState(() => _oscillatorParams1.widthAmp = _presets[position][0].widthAmp);
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
