import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './preset_blending_page.dart';

import './redux/redux_state.dart';

class BlendPresetsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReduxState, ReduxState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return RaisedButton(
            child: Text('Blend Presets', style: Theme.of(context).textTheme.button),
            color: Theme.of(context).buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: (state.savedPresets.length < 2)
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PresetBlenderPage(),
                      ),
                    );
                  },
          );
        });
  }
}
