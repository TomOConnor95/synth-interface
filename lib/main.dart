import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './preset_edit_page.dart';

import './redux/redux_state.dart';
import './redux/reducer.dart';

void main() {

  final store = Store<ReduxState>(
    reducer,
    initialState: initialState
  );

  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({this.store});

  final Store<ReduxState> store;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<ReduxState>(
      store: store,
      child: MaterialApp(
        title: 'Synth Interface App',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        home: PresetEditPage(
          title: 'Preset Editor',
        ),
      ),
    );
  }
}
