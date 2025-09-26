import 'dart:convert';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import '../../domain/ble/ble_repository.dart';
import 'ble_uuids.dart';

class BleManager implements BleRepository {
  final FlutterReactiveBle _ble;
  QualifiedCharacteristic? _targetChar;
  String? _connectedId;

  BleManager(this._ble);

  @override
  Stream<Map<String, String>> scanDevices() {
    return _ble.scanForDevices(withServices: [BleUuids.service]).map(
          (d) => {"id": d.id, "name": d.name.isNotEmpty ? d.name : "Unknown"},
    );
  }

  @override
  Future<void> connect(String deviceId) async {
    _connectedId = deviceId;

    _ble.connectToDevice(id: deviceId).listen((update) {
      if (update.connectionState == DeviceConnectionState.connected) {
        _targetChar = QualifiedCharacteristic(
          deviceId: deviceId,
          serviceId: BleUuids.service,
          characteristicId: BleUuids.characteristic,
        );
      }
    });
  }

  @override
  Stream<String> subscribeData() {
    if (_targetChar == null) return const Stream.empty();
    return _ble.subscribeToCharacteristic(_targetChar!)
        .map((bytes) => utf8.decode(bytes));
  }

  @override
  Future<void> write(String text) async {
    if (_targetChar == null) return;
    await _ble.writeCharacteristicWithResponse(
      _targetChar!,
      value: utf8.encode(text),
    );
  }
}
