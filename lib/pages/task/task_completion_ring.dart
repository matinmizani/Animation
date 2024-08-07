import 'dart:math';

import 'package:flutter/material.dart';

class TaskCompletionRing extends StatelessWidget {
  const TaskCompletionRing({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade400,
      body: Center(
        child: SizedBox(
          width: 240,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: CustomPaint(
              painter: RingPainter(
                  progress: progress,
                  taskNotCompletedColor: Colors.black,
                  taskCompletedColor: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  RingPainter(
      {super.repaint,
      required this.progress,
      required this.taskNotCompletedColor,
      required this.taskCompletedColor});

  final double progress;
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWith = size.width / 15;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWith) / 2;
    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWith
      ..color = taskNotCompletedColor
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgroundPaint);
    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWith
      ..color = taskCompletedColor
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        2 * pi * progress, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
