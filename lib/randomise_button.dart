import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './redux/actions.dart';
import './redux/redux_state.dart';

class RandomiseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReduxState, VoidCallback>(
        converter: (store) {
          return () => store.dispatch(RandomiseParameters());
        },
        builder: (context, callback) {
          return RaisedButton(
            onPressed: callback,
            child: Text('Randomise', style: TextStyle(color: Colors.white)),
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          );
        }
    );
  }
}
