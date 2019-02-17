import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './redux/actions.dart';
import './redux/redux_state.dart';

class SavePresetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReduxState, VoidCallback>(
      converter: (store) {
        return () => store.dispatch(SavePreset());
      },
      builder: (context, callback) {
        return RaisedButton(
            child: Text('Save Preset', style: TextStyle(color: Colors.white)),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              callback();
            });
      },
    );
  }
}
