import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

abstract class BleRepo {
  Stream<DiscoveredDevice> scanForDevices();
}
