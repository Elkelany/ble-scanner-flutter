import 'package:ble_testapp/core/models/ble_device.dart';

enum BleDevicesListState { scanning, ready }

enum BleDevicesListEvent { scan, selectBleDevice }

class BleDevicesListMessage {
  final BleDevicesListState state;
  final BleDevicesListEvent event;
  final List<BleDevice> bleDevices;
  final int selectedBleDeviceIndex;

  BleDevicesListMessage({
    BleDevicesListState state,
    BleDevicesListEvent event,
    List<BleDevice> bleDevices,
    int selectedBleDeviceIndex,
  })  : this.state = state,
        this.event = event,
        this.bleDevices = bleDevices,
        this.selectedBleDeviceIndex = selectedBleDeviceIndex;

  factory BleDevicesListMessage.defaultValue() {
    return BleDevicesListMessage(
      state: BleDevicesListState.scanning,
    );
  }

  BleDevicesListMessage copyWith({
    BleDevicesListState state,
    BleDevicesListEvent event,
    List<BleDevice> bleDevices,
    int selectedBleDeviceIndex,
  }) {
    return BleDevicesListMessage(
      state: state ?? this.state,
      event: event ?? this.event,
      bleDevices: bleDevices ?? this.bleDevices,
      selectedBleDeviceIndex:
          selectedBleDeviceIndex ?? this.selectedBleDeviceIndex,
    );
  }

  @override
  String toString() {
    return '''BleDevicesListMessage(
     state: $state,
     event: $event,
     bleDevices: $bleDevices,
     selectedBleDeviceIndex: $selectedBleDeviceIndex,
     )''';
  }
}
