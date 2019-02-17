import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './preset_gauge_display.dart';

import './redux/actions.dart';
import './redux/redux_state.dart';

class PresetDisplay extends StatelessWidget {
  final double animationAngle;

  PresetDisplay(this.animationAngle);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReduxState, Store<ReduxState>>(
      converter: (store) => store,
      builder: (context, store) {
        return SizedBox(
          height: store.state.savedPresets.length * 70.0,
          child: ListView.builder(
            itemCount: store.state.savedPresets.length,
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
                          store.state.savedPresets[position],
                          animationAngle,
                        )
                      ),
                    ),
                    onTap: () => store.dispatch(RecallPreset(position)),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => store.dispatch(DeletePreset(position))
                    ),
                  ),
                ],
              );
            }
          ),
        );
      },
    );
  }
}
