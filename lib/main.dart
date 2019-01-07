import 'package:flutter/material.dart';
import './preset_gauge_display.dart';

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
  double _sliderValue1 = 10.0;
  double _sliderValue2 = 10.0;
  double _sliderValue3 = 10.0;

  var _presets = new List();

  Animation<double> _angleAnimation;
  AnimationController _controller;

  void _savePreset() {
    var preset = [_sliderValue1, _sliderValue2, _sliderValue3];
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

  double _getPresetValue(List preset, int index) {
    return preset[index];
  }

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
        duration: const Duration(milliseconds: 8000), vsync: this);
    _angleAnimation = new Tween(begin: 0.0, end: 720.0).animate(_controller)
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
                      _sliderValue1,
                      _sliderValue2,
                      _sliderValue3,
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
                    activeColor: Colors.indigoAccent,
                    min: 0.0,
                    max: 10.0,
                    onChanged: (newRating) {
                      setState(() => _sliderValue1 = newRating);
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
                      color: Colors.indigoAccent,
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
                    activeColor: Colors.red,
                    min: 0.0,
                    max: 10.0,
                    onChanged: (newRating) {
                      setState(() => _sliderValue2 = newRating);
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
                      color: Colors.red,
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
                    activeColor: Colors.green,
                    min: 0.0,
                    max: 10.0,
                    onChanged: (newRating) {
                      setState(() => _sliderValue3 = newRating);
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
                        color: Colors.green,
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
                                    '${_getPresetValue(_presets[position], 0).toStringAsFixed(2)}',
                                    // 'Hello',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.indigoAccent,
                                    ),
                                  ),
                                  Text(
                                    '${_getPresetValue(_presets[position], 1).toStringAsFixed(2)}',
                                    // 'Hello',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '${_getPresetValue(_presets[position], 2).toStringAsFixed(2)}',
                                    // 'Hello',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.green,
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
                                  _getPresetValue(_presets[position], 0),
                                  _getPresetValue(_presets[position], 1),
                                  _getPresetValue(_presets[position], 2),
                                  _angleAnimation.value,
                                )),
                          ),
                          onTap: () {
                            setState(
                                () => _sliderValue1 = _presets[position][0]);
                            setState(
                                () => _sliderValue2 = _presets[position][1]);
                            setState(
                                () => _sliderValue3 = _presets[position][2]);
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
