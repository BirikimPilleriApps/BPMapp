import 'package:flutter/material.dart';
import '../widgets/battery_soc_indicator.dart';
import '../widgets/info_card.dart';
import '../widgets/battery_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: BLE verisi yerine mock status
    final status = BatteryStatus(
      totalVoltage: 13000,
      totalCurrent: 500,
      totalSOC: 80,
      maxVoltage: 3600,
      minVoltage: 3200,
      averageVoltage: 3400,
      cycle: 200,
      temperature: 32,
      cellVoltages: [3300, 3320, 3350, 3340],
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(child: BatterySOCIndicator(soc: status.totalSOC)),
        const SizedBox(height: 16),
        InfoCard(label: "Total Voltage", value: "${status.totalVoltage} mV", icon: Icons.bolt),
        const SizedBox(height: 16),
        BatteryContent(status: status),
      ],
    );
  }
}
