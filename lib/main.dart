import 'package:ble_testapp/shell/navigation/named_navigator_impl.dart';
import 'package:flutter/material.dart';

import 'core/navigation/named_navigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelany',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.INITIAL_PAGE,
      onGenerateRoute: NamedNavigatorImpl.onGenerateRoute,
      navigatorKey: NamedNavigatorImpl.navigatorState,
    );
  }
}
