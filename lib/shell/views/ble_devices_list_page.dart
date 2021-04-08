import 'package:ble_testapp/core/bloc/ble_devices_list_bloc.dart';
import 'package:ble_testapp/core/bloc/ble_devices_list_message.dart';
import 'package:ble_testapp/shell/navigation/named_navigator_impl.dart';
import 'package:ble_testapp/shell/repos/ble_repo_impl.dart';
import 'package:flutter/material.dart';

class BleDevicesListPage extends StatefulWidget {
  final BleDevicesListBloc _bloc;

  BleDevicesListPage()
      : _bloc = BleDevicesListBloc(
            bleRepo: BleRepoImpl(), namedNavigator: NamedNavigatorImpl());

  @override
  _BleDevicesListPageState createState() => _BleDevicesListPageState();
}

class _BleDevicesListPageState extends State<BleDevicesListPage> {
  final _defaultMessage = BleDevicesListMessage.defaultValue();

  @override
  void initState() {
    widget._bloc.eventsSink
        .add(_defaultMessage.copyWith(event: BleDevicesListEvent.scan));
    super.initState();
  }

  @override
  void dispose() {
    widget._bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLE Devices List"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<BleDevicesListMessage>(
        initialData: _defaultMessage,
        stream: widget._bloc.statesStream,
        builder: (context, snapshot) {
          if (snapshot == null || snapshot.hasError || (!snapshot.hasData)) {
            return Container();
          } else {
            return _renderStates(context, snapshot.data);
          }
        },
      ),
    );
  }

  Widget _renderStates(BuildContext context, BleDevicesListMessage message) {
    Widget currentState = Container();

    switch (message.state) {
      case BleDevicesListState.scanning:
        currentState = Container(
          child: Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ),
        );
        break;
      case BleDevicesListState.ready:
        currentState = _renderReadyState(context, message);
        break;
    }

    return currentState;
  }

  Widget _renderReadyState(
      BuildContext context, BleDevicesListMessage message) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView.separated(
        separatorBuilder: (_, __) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onSelectBleDevice(message, index),
            child: Column(
              children: [
                Text(message.bleDevices[index].name.isNotEmpty
                    ? message.bleDevices[index].name
                    : "Unknow Name"),
                Text(message.bleDevices[index].id),
              ],
            ),
          );
        },
        itemCount: message.bleDevices.length,
      ),
    );
  }

  void _onSelectBleDevice(BleDevicesListMessage message, int index) {
    widget._bloc.eventsSink.add(message.copyWith(
        event: BleDevicesListEvent.selectBleDevice,
        selectedBleDeviceIndex: index));
  }
}
