import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const BPMApp());
}

class BPMApp extends StatelessWidget {
  const BPMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BPM App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF009383),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF009383)),
      ),
      home: const AppNavigation(),
    );
  }
}
