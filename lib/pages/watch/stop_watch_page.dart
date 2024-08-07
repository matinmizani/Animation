import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/pages/watch/reset_button.dart';
import 'package:project/pages/watch/start_stop_button.dart';
import 'package:project/pages/watch/top_watch_rendere.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch>
    with SingleTickerProviderStateMixin {
  Duration get _elapsed => _previousElapsed + _currentElapsed;
  Duration _previousElapsed = Duration.zero;
  Duration _currentElapsed = Duration.zero;
  bool _isRunning = false;
  late final Ticker _timer;

  @override
  void initState() {
    _timer = createTicker((elapsed) {
      setState(() {
        _currentElapsed = elapsed;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.dispose();
    super.dispose();
  }

  void _toggleRunning() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _timer.start();
      } else {
        _previousElapsed += _currentElapsed;
        _currentElapsed = Duration.zero;
        _timer.stop();
      }
    });
  }

  void _reset() {
    _timer.stop();
    setState(() {
      _isRunning = false;
      _previousElapsed = Duration.zero;
      _currentElapsed = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("stop Watch"),
          centerTitle: true,
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: AspectRatio(
              aspectRatio: 0.85,
              child: Stack(
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    return StopWatchRenderer(
                        elapsed: _elapsed, radius: constraints.maxWidth / 2);
                  }),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: StartStopButton(
                          isRunning: _isRunning,
                          onPressed: () => _toggleRunning()),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: ResetButton(onPressed: () => _reset()),
                    ),
                  ),
                ],
              )),
        )));
  }
}
