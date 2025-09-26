class HistoryRecord {
  final String? id;
  final int timestamp;
  final int totalVoltageMv;
  final int totalCurrentMa;
  final int socPercent;
  final int maxMv;
  final int minMv;
  final int avgMv;
  final int temperatureC;
  final int cycle;
  final List<int> cellsMv;

  HistoryRecord({
    this.id,
    required this.timestamp,
    required this.totalVoltageMv,
    required this.totalCurrentMa,
    required this.socPercent,
    required this.maxMv,
    required this.minMv,
    required this.avgMv,
    required this.temperatureC,
    required this.cycle,
    required this.cellsMv,
  });

  factory HistoryRecord.fromJson(Map<String, dynamic> json, {String? id}) {
    return HistoryRecord(
      id: id,
      timestamp: json['timestamp'] ?? 0,
      totalVoltageMv: json['totalVoltageMv'] ?? 0,
      totalCurrentMa: json['totalCurrentMa'] ?? 0,
      socPercent: json['socPercent'] ?? 0,
      maxMv: json['maxMv'] ?? 0,
      minMv: json['minMv'] ?? 0,
      avgMv: json['avgMv'] ?? 0,
      temperatureC: json['temperatureC'] ?? 0,
      cycle: json['cycle'] ?? 0,
      cellsMv: List<int>.from(json['cellsMv'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'totalVoltageMv': totalVoltageMv,
      'totalCurrentMa': totalCurrentMa,
      'socPercent': socPercent,
      'maxMv': maxMv,
      'minMv': minMv,
      'avgMv': avgMv,
      'temperatureC': temperatureC,
      'cycle': cycle,
      'cellsMv': cellsMv,
    };
  }
}
