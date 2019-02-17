import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './preset_gauge_display.dart';
import './current_params_guage_display.dart';
import './save_preset_button.dart';

import './redux/actions.dart';
import './redux/redux_state.dart';

class PresetBlenderPage extends StatefulWidget {
  @override
  _PresetBlenderPageState createState() => _PresetBlenderPageState();
}

class _PresetBlenderPageState extends State<PresetBlenderPage>
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
                child: CurrentParamsGuageDisplay(_angleAnimation.value)
              ),
            ),
            Row(
              children: <Widget>[
                PresetSelector(_angleAnimation.value, LeftRight.left),
                BlendSlider(),
                PresetSelector(_angleAnimation.value, LeftRight.right),
              ],
            ),
            SavePresetButton(),
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

class BlendSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    return StoreConnector<ReduxState, Store<ReduxState>>(
      converter: (store)  => store,
      onInit: (store) {
        store.dispatch(BlendPresets());
      },
      builder: (context, store) {
        return Expanded(
          child: Slider(
            value: store.state.blendValue,
            onChanged: (newValue) {
              store.dispatch(BlendSliderCallback(newValue));
              store.dispatch(BlendPresets());
            },
          ),
        );
      }
    );
  }
}

enum LeftRight {
  left,
  right,
}
class PresetSelector extends StatelessWidget {
  final double animationAngle;
  final LeftRight leftRight;
  PresetSelector(this.animationAngle, this.leftRight);

  @override
  Widget build(BuildContext context) {    
    int presetSelected;
    return StoreConnector<ReduxState, Store<ReduxState>>(
      converter: (store) => store,
      builder: (context, store) {
        if (leftRight == LeftRight.left) {
          presetSelected = store.state.presetSelectedLeft;
        } else {
          presetSelected = store.state.presetSelectedRight;
        }
        return ButtonTheme(
          alignedDropdown: true,
          child:DropdownButtonHideUnderline(
            child: DropdownButton(
              value: presetSelected,
              elevation: 8,
              items: List<DropdownMenuItem<int>>.generate(
                store.state.savedPresets.length,
                (int index) => DropdownMenuItem(
                  value: index,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Transform.scale(
                      scale: index == presetSelected ? 0.7 : 0.5,
                      child: presetGaugeDisplay(
                        store.state.savedPresets[index],
                        animationAngle,
                      ),
                    ),
                  ),
                ),
              ),
              onChanged: (value) {
                if (leftRight == LeftRight.left) {
                  store.dispatch(LeftPresetSelectorCallback(value));
                } else {
                  store.dispatch(RightPresetSelectorCallback(value));
                }
              }
            ),
          ),
        );
      }
    );
  }
}
