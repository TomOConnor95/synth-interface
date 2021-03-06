import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './preset_gauge_display.dart';

import './redux/redux_state.dart';


class CurrentParamsGuageDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    return StoreConnector<ReduxState, ReduxState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return PresetGaugeDisplay(
          state.currentParams,
        );
      },
    );
  }
}
