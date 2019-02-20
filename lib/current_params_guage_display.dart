import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './preset_gauge_display.dart';

import './redux/redux_state.dart';


class CurrentParamsGuageDisplay extends StatefulWidget {
  @override
  _CurrentParamsGuageDisplayState createState() => _CurrentParamsGuageDisplayState();
}

class _CurrentParamsGuageDisplayState extends State<CurrentParamsGuageDisplay>
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
    return StoreConnector<ReduxState, ReduxState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return presetGaugeDisplay(
          state.currentParams,
          _angleAnimation.value,
        );
      },
    );
  }
}
