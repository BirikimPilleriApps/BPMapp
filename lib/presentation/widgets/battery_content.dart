import 'package:flutter/material.dart';

class BatteryStatus {
  final int totalVoltage;
  final int totalCurrent;
  final int totalSOC;
  final int maxVoltage;
  final int minVoltage;
  final int averageVoltage;
  final int cycle;
  final int temperature;
  final List<int> cellVoltages;

  BatteryStatus({
    required this.totalVoltage,
    required this.totalCurrent,
    required this.totalSOC,
    required this.maxVoltage,
    required this.minVoltage,
    required this.averageVoltage,
    required this.cycle,
    required this.temperature,
    required this.cellVoltages,
  });
}

class BatteryContent extends StatelessWidget {
  final BatteryStatus status;

  const BatteryContent({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final power = status.totalVoltage * status.totalCurrent / 1000000.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Genel Bilgiler",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          InfoRow("Toplam Voltaj", "${status.totalVoltage} mV"),
          InfoRow("Toplam Akım", "${status.totalCurrent} mA"),
          InfoRow("SOC", "${status.totalSOC}%"),
          InfoRow("Max Voltaj", "${status.maxVoltage} mV"),
          InfoRow("Min Voltaj", "${status.minVoltage} mV"),
          InfoRow("Ortalama Voltaj", "${status.averageVoltage} mV"),
          InfoRow("Cycle", "${status.cycle}"),
          InfoRow("Power", "${power.toStringAsFixed(2)} W"),
          const SizedBox(height: 16),
          const Text("Hücre Voltajları",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: status.cellVoltages.length,
            itemBuilder: (context, index) {
              final v = status.cellVoltages[index];
              return Card(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Cell ${index + 1}",
                          style: const TextStyle(color: Colors.black)),
                      Text("$v mV",
                          style: const TextStyle(
                              color: Color(0xFF009383),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}
