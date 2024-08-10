import 'package:flutter/material.dart';

class ElapsedTimeTextBasic extends StatelessWidget {
  const ElapsedTimeTextBasic({super.key, required this.elapsed});

  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    final seconds = elapsed.inSeconds % 60;
    final minutes = elapsed.inMinutes % 60;
    final secondsStr = seconds.toStringAsFixed(0).padLeft(2, "0");
    final minutesStr = minutes.toStringAsFixed(0).padLeft(2, "0");
    return Center(
      child: Text(
        "$minutesStr:$secondsStr",
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
