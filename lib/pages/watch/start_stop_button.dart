import 'package:flutter/material.dart';

class StartStopButton extends StatelessWidget {
  const StartStopButton({super.key, this.onPressed, required this.isRunning});

  final VoidCallback? onPressed;
  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: isRunning ? Colors.red[900] : Colors.green[900],
        child: InkWell(
          onTap: onPressed,
          child: Align(
            alignment: Alignment.center,
            child: Text(isRunning ? "Stop" : "Start"),
          ),
        ),
      ),
    );
  }
}
