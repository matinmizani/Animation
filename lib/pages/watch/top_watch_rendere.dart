import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/pages/watch/clock_markers.dart';

import 'clock_hand.dart';
import 'elapsedTimeTextBasic.dart';

class StopWatchRenderer extends StatelessWidget {
  const StopWatchRenderer(
      {super.key, required this.elapsed, required this.radius});

  final Duration elapsed;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < 60; i++)
          Positioned(
            left: radius,
            top: radius,
            child: ClockSecondsTickMarker(
                seconds: i, radius: radius),
          ),
        for (var i = 5; i <= 60; i += 5)
          Positioned(
              top: radius,
              left: radius,
              child: ClockTextMarker(
                  value: i,
                  maxValue: 60,
                  radius: radius)),
        Positioned(
            left: radius,
            top: radius,
            child: ClockHand(
              color: Colors.orange,
              handLength: radius,
              handThickness: 2,
              rotationZAngle:
                  pi + (2 * pi / 60000) * elapsed.inMilliseconds,
            )),
        Positioned(
            left: 0,
            right: 0,
            top: radius * 1.3,
            child: ElapsedTimeTextBasic(elapsed: elapsed)),
      ],
    );
  }
}
