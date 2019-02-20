import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';

import './preset_edit_page.dart';

import './redux/redux_state.dart';
import './redux/reducer.dart';
import './redux/action_decoder.dart';


void main() async {

  var remoteDevtools = RemoteDevToolsMiddleware(
    '127.0.0.1:8040', 
    actionDecoder: MyDecoder(),
  );
  await remoteDevtools.connect();
  final store = DevToolsStore<ReduxState>(
    reducer,
    initialState: initialState,
    middleware: [remoteDevtools]
  );

  remoteDevtools.store = store;

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
        theme:ThemeData.light(),
        // theme: ThemeData(
        //   // This is the theme of your application.
        //   primarySwatch: Colors.blue,
        // ),
        home: PresetEditPage(
          title: 'Preset Editor',
        ),
      ),
    );
  }
}
