import 'package:ble_testapp/core/bloc/initial_page_bloc.dart';
import 'package:ble_testapp/core/bloc/initial_page_message.dart';
import 'package:ble_testapp/shell/navigation/named_navigator_impl.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  final InitialPageBloc _bloc;

  InitialPage() : _bloc = InitialPageBloc(namedNavigator: NamedNavigatorImpl());

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void dispose() {
    widget._bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<InitialPageMessage>(
      initialData: InitialPageMessage.defaultValue(),
      stream: widget._bloc.statesStream,
      builder: (context, snapshot) {
        if (snapshot == null || snapshot.hasError || (!snapshot.hasData)) {
          return Container();
        } else {
          return _renderStates(context, snapshot.data);
        }
      },
    );
  }

  Widget _renderStates(BuildContext context, InitialPageMessage message) {
    Widget currentState = Container();

    switch (message.state) {
      case InitialPageState.initial:
        currentState = _renderInitialState(context, message);
        break;
    }

    return currentState;
  }

  Widget _renderInitialState(BuildContext context, InitialPageMessage message) {
    return Material(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Hypervolt",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "Flutter - BLE",
              style: Theme.of(context).textTheme.headline6,
            ),
            FlatButton(
              onPressed: () => _onScan(message),
              child: Text("Scan"),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }

  void _onScan(InitialPageMessage message) {
    widget._bloc.eventsSink.add(message.copyWith(event: InitialPageEvent.scan));
  }
}
