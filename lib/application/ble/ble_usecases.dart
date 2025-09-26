import '../../domain/ble/ble_repository.dart';

class BleUseCases {
  final BleRepository repository;
  BleUseCases(this.repository);

  Stream<Map<String, String>> scanDevices() => repository.scanDevices();

  Future<void> connect(String deviceId) => repository.connect(deviceId);

  Stream<String> subscribeData() => repository.subscribeData();

  Future<void> write(String text) => repository.write(text);
}
