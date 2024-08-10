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
  bool _showCheckIcon = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    _animationController.addStatusListener(_checkStatusUpdates);
    super.initState();
  }

  void _checkStatusUpdates(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _showCheckIcon = true;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _showCheckIcon = false;
        });
      });
    }
  }

  void _handleTapUpCancel() {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (_animationController.status != AnimationStatus.completed) {
      _animationController.forward();
    } else if (!_showCheckIcon) {
      _animationController.value = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapCancel: _handleTapUpCancel,
      onTapUp: (_) => _handleTapUpCancel(),
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            final progress = _animationController.value;
            final hasCompleted = progress == 1.0;
            final iconColor = hasCompleted ? Colors.black : Colors.white;
            return Stack(
              children: [
                SizedBox(
                  width: 240,
                  height: 240,
                  child:
                      TaskCompletionRing(progress: _animationController.value),
                ),
                Positioned.fill(
                    child: CenteredSvgIcon(
                  assets: hasCompleted && _showCheckIcon
                      ? AppAssets.check
                      : widget.iconName,
                  color: iconColor,
                ))
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController.removeStatusListener(_checkStatusUpdates);
    super.dispose();
  }
}
