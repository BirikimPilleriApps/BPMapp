abstract class BleRepository {
  /// BLE cihazlarını tarar → cihaz id + isim döndürür
  Stream<Map<String, String>> scanDevices();

  /// Belirtilen cihaz id’sine bağlanır
  Future<void> connect(String deviceId);

  /// Bağlı cihazdan gelen veriyi dinler
  Stream<String> subscribeData();

  /// Bağlı cihaza yazı gönderir (örn: GET_DATA)
  Future<void> write(String text);
}
