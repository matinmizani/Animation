import 'package:flutter/material.dart';
import 'package:project/constants/app_assets.dart';
import 'package:project/constants/centered_svg_icon.dart';
import 'package:project/pages/task/task_completion_ring.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({super.key, required this.iconName});
  final String iconName;

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    super.initState();
  }

  void _handleTapUp(TapUpDetails details) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } else {
      _animationController.value = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                TaskCompletionRing(progress: _animationController.value),
                Positioned.fill(
                    child: CenteredSvgIcon(
                  assets: widget.iconName,
                  color:
                      _animationController.status == AnimationStatus.completed
                          ? Colors.black
                          : Colors.white,
                ))
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
