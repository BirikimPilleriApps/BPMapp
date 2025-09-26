import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import '../../application/ble/ble_usecases.dart';
import '../../infrastructure/ble/ble_manager.dart';

class BlePage extends StatefulWidget {
  const BlePage({super.key});

  @override
  State<BlePage> createState() => _BlePageState();
}

class _BlePageState extends State<BlePage> {
  late BleUseCases _useCases;
  final _ble = FlutterReactiveBle();
  List<Map<String, String>> devices = [];
  String received = "";

  @override
  void initState() {
    super.initState();
    _useCases = BleUseCases(BleManager(_ble));

    _useCases.scanDevices().listen((dev) {
      if (!devices.any((d) => d["id"] == dev["id"])) {
        setState(() => devices.add(dev));
      }
    });
  }

  void _connectAndListen(String id) async {
    await _useCases.connect(id);
    _useCases.subscribeData().listen((data) {
      setState(() => received = data);
    });
    await _useCases.write("GET_DATA");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BLE Devices")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, i) {
                final dev = devices[i];
                return ListTile(
                  title: Text(dev["name"]!),
                  subtitle: Text(dev["id"]!),
                  onTap: () => _connectAndListen(dev["id"]!),
                );
              },
            ),
          ),
          Text("Gelen veri: $received"),
        ],
      ),
    );
  }
}
