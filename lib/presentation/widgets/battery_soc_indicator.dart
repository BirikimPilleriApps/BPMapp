import 'package:flutter/material.dart';

class BatterySOCIndicator extends StatelessWidget {
  final int soc;

  const BatterySOCIndicator({super.key, required this.soc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        painter: _BatteryPainter(soc),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$soc%",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text("SOC", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BatteryPainter extends CustomPainter {
  final int soc;
  _BatteryPainter(this.soc);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 20.0;
    final rect = Offset.zero & size;
    final startAngle = -90.0;

    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final socPaint = Paint()
      ..color = const Color(0xFF009383)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect.deflate(strokeWidth / 2), startAngle * (3.14 / 180),
        3.14, false, bgPaint);

    final sweepAngle = 360 * (soc / 100.0);
    canvas.drawArc(rect.deflate(strokeWidth / 2), startAngle * (3.14 / 180),
        sweepAngle * (3.14 / 180), false, socPaint);
  }

  @override
  bool shouldRepaint(_BatteryPainter oldDelegate) => oldDelegate.soc != soc;
}
