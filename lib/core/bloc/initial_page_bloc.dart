import 'package:ble_testapp/core/bloc/base_bloc.dart';
import 'package:ble_testapp/core/bloc/initial_page_message.dart';
import 'package:ble_testapp/core/navigation/named_navigator.dart';
import 'package:meta/meta.dart';

class InitialPageBloc extends BaseBloc<InitialPageMessage> {
  final NamedNavigator _namedNavigator;

  InitialPageBloc({
    @required NamedNavigator namedNavigator,
  }) : this._namedNavigator = namedNavigator;

  @override
  void eventHandler(InitialPageMessage message) {
    switch (message.event) {
      case InitialPageEvent.scan:
        _scan();
        break;
    }
  }

  // Events
  void _scan() async {
    _namedNavigator.push(Routes.DEVICES_LIST);
  }
}
