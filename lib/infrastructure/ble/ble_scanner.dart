import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'ble_uuids.dart';

class BleScanner {
  final FlutterReactiveBle _ble;
  BleScanner(this._ble);

  Stream<DiscoveredDevice> scan() {
    return _ble.scanForDevices(withServices: [BleUuids.service]);
  }
}
