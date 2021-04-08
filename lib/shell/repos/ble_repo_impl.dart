import 'dart:async';

import 'package:ble_testapp/core/repos/ble_repo.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleRepoImpl implements BleRepo {
  final FlutterReactiveBle _flutterReactiveBle;

  BleRepoImpl() : _flutterReactiveBle = FlutterReactiveBle();

  @override
  Stream<DiscoveredDevice> scanForDevices() {
    return _flutterReactiveBle.scanForDevices(withServices: []);
  }
}
