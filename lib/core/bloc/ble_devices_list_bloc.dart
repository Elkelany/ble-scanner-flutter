import 'dart:async';

import 'package:ble_testapp/core/bloc/base_bloc.dart';
import 'package:ble_testapp/core/bloc/ble_devices_list_message.dart';
import 'package:ble_testapp/core/models/ble_device.dart';
import 'package:ble_testapp/core/navigation/named_navigator.dart';
import 'package:ble_testapp/core/repos/ble_repo.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:meta/meta.dart';

class BleDevicesListBloc extends BaseBloc<BleDevicesListMessage> {
  final BleRepo _bleRepo;
  final NamedNavigator _namedNavigator;

  BleDevicesListBloc({
    @required BleRepo bleRepo,
    @required NamedNavigator namedNavigator,
  })  : this._bleRepo = bleRepo,
        this._namedNavigator = namedNavigator;

  @override
  void eventHandler(BleDevicesListMessage message) {
    switch (message.event) {
      case BleDevicesListEvent.scan:
        _scanForBleDevices(message);
        break;
      case BleDevicesListEvent.selectBleDevice:
        _selectBleDevice(message);
        break;
    }
  }

  List<BleDevice> _discoveredDevices = [];

  // Events
  void _scanForBleDevices(BleDevicesListMessage message) async {
    statesSink.add(message.copyWith(state: BleDevicesListState.scanning));

    bool permissionGranted = false;
    StreamSubscription subscription;

    PermissionStatus permission =
        await LocationPermissions().requestPermissions();

    permissionGranted = permission == PermissionStatus.granted;

    if (permissionGranted) {
      subscription = _bleRepo.scanForDevices().listen((device) {
        if (_discoveredDevices.every((element) => element.id != device.id)) {
          _discoveredDevices.add(BleDevice(id: device.id, name: device.name));
          statesSink.add(message.copyWith(
              state: BleDevicesListState.ready,
              bleDevices: _discoveredDevices));
        }
      });
    } else {
      print("------------------- Permission not granted -----------------");
    }

    Future.delayed(Duration(seconds: 5)).then((value) => subscription.cancel());
  }

  void _selectBleDevice(BleDevicesListMessage message) {
    BleDevice bleDevice = message.bleDevices[message.selectedBleDeviceIndex];

    _namedNavigator.push(Routes.DEVICE_DETAILS, arguments: bleDevice);
  }
}
