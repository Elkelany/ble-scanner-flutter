import 'package:ble_testapp/core/navigation/named_navigator.dart';
import 'package:ble_testapp/shell/views/ble_device_details_page.dart';
import 'package:ble_testapp/shell/views/ble_devices_list_page.dart';
import 'package:ble_testapp/shell/views/initial_page.dart';
import 'package:flutter/material.dart';

class NamedNavigatorImpl implements NamedNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.INITIAL_PAGE:
        return MaterialPageRoute(builder: (_) => InitialPage());
      case Routes.DEVICES_LIST:
        return MaterialPageRoute(builder: (_) => BleDevicesListPage());
      case Routes.DEVICE_DETAILS:
        return MaterialPageRoute(
            builder: (_) =>
                BleDeviceDetailsPage(bleDevice: settings.arguments));
    }
    return MaterialPageRoute(builder: (_) => Container());
  }

  @override
  Future push(String routeName, {arguments, bool replace = false}) {
    if (replace)
      return navigatorState.currentState
          .pushReplacementNamed(routeName, arguments: arguments);

    return navigatorState.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  @override
  void pop({dynamic result}) {
    if (navigatorState.currentState.canPop())
      navigatorState.currentState.pop(result);
  }
}
