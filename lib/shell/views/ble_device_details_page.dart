import 'package:ble_testapp/core/models/ble_device.dart';
import 'package:flutter/material.dart';

class BleDeviceDetailsPage extends StatelessWidget {
  final BleDevice _bleDevice;

  const BleDeviceDetailsPage({BleDevice bleDevice})
      : assert(bleDevice != null),
        _bleDevice = bleDevice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLE Device Details"),
        leading: BackButton(),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text(
                  _bleDevice.name.isNotEmpty ? _bleDevice.name : "Unknow Name"),
              Text(_bleDevice.id),
            ],
          ),
        ),
      ),
    );
  }
}
