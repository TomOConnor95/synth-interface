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
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double _sliderValue1 = 0.6;
  double _sliderValue2 = 0.7;
  double _sliderValue3 = 0.8;

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
    _sliderValue1,
    0.7,
    3,
    0.2,
    4,
  );
  var _params2 = OscillatorParams(
    _sliderValue2,
    0.6,
    5,
    0.1,
    4,
  );

  var _params3 = OscillatorParams(
    _sliderValue3,
    0.1,
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Here are some sliders:',
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Slider(
                    activeColor: _color1,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (newValue) {
                      setState(() => _sliderValue1 = newValue);
                      setState(() => _oscillatorParams1.length = newValue);
                    },
                    value: _sliderValue1,
                  ),
                ),
                Container(
                  width: 90.0,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${_sliderValue1.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: _color1,
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Slider(
                    activeColor: _color2,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (newValue) {
                      setState(() => _sliderValue2 = newValue);
                      setState(() => _oscillatorParams2.length = newValue);
                    },
                    value: _sliderValue2,
                  ),
                ),
                Container(
                  width: 90.0,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${_sliderValue2.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: _color2,
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Slider(
                    activeColor: _color3,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (newValue) {
                      setState(() => _sliderValue3 = newValue);
                      setState(() => _oscillatorParams3.length = newValue);

                    },
                    value: _sliderValue3,
                  ),
                ),
                Container(
                    width: 90.0,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${_sliderValue3.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: _color3,
                        fontSize: 32,
                      ),
                    )),
              ],
            ),
            savePresetButton,
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
                            setState(() => _sliderValue1 = _presets[position][0].length);
                            setState(() => _sliderValue2 = _presets[position][1].length);
                            setState(() => _sliderValue3 = _presets[position][2].length);

                            setState(() => _oscillatorParams1.length = _presets[position][0].length);
                            setState(() => _oscillatorParams2.length = _presets[position][1].length);
                            setState(() => _oscillatorParams3.length = _presets[position][2].length);
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
